//
//  NewLoginViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewLoginViewController.h"
#import "NSString+Hash.h"
#import "ForgetPasswordViewController.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "Growing.h"

#import "CutOutClearView.h"

@interface NewLoginViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)UIImageView *bgImageView;
@property(strong,nonatomic)UIImageView *loginImageV;
//账号&密码
@property(strong,nonatomic)UITextField *numTextField;
@property(strong,nonatomic)UITextField *passwordTextfield;

@property(strong,nonatomic)UITextField *phoneNumTextfield;
@property(strong,nonatomic)UITextField *authTextfield;
@property(strong,nonatomic)UIButton    *sendAuthCodeBtn;

@end

@implementation NewLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    [self initUI];
    [self hiddenNavigationNeedLeftBackButtonImageName:@"BackChevron"];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)initUI
{
    UIImageView *backG = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    backG.userInteractionEnabled = YES;
    backG.image = [UIImage imageNamed:@"bg_newLogin"];
    [self.view addSubview:backG];
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [UIImage imageNamed:@"bg_newLogin_white"];
    [_bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    [backG addSubview:_bgImageView];
    
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, 30, kScreenWidth, 20);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    title.text = @"登录";
    [_bgImageView addSubview:title];
    
    _loginImageV = [[UIImageView alloc] init];
    _loginImageV.frame = CGRectMake(0, 85, 146, 115);
    _loginImageV.center = CGPointMake(kScreenWidth/2, kScreenHeight/5);
    _loginImageV.image = [UIImage imageNamed:@"newlogo_color"];
    //[_bgImageView addSubview:_loginImageV];
    
    NSMutableArray *paths = [NSMutableArray array];
    NSArray *imageArr = @[@"newuser_icon",@"newpassword_icon"];
    for (int i = 0; i < 2; i ++) {
        /*
        UIView *whiteBackG = [[UIView alloc] init];//_loginImageV.bottom+43
        whiteBackG.frame = CGRectMake(30, kScreenHeight/4 + i*55, kScreenWidth-30*2, 46);
        whiteBackG.layer.cornerRadius = 4;
        whiteBackG.backgroundColor = [UIColor whiteColor];
        [_bgImageView addSubview:whiteBackG];
        */
        
        {
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(30, kScreenHeight/4 + i*55)];// (x,y)
            [bezierPath addLineToPoint: CGPointMake(kScreenWidth-30, kScreenHeight/4+ i*55)];
            [bezierPath addLineToPoint: CGPointMake(kScreenWidth-30, 46+kScreenHeight/4+ i*55)];
            [bezierPath addLineToPoint: CGPointMake(30, 46+kScreenHeight/4+ i*55)];
            [bezierPath closePath];
            [paths addObject:bezierPath];
        }
        
        UIImageView *userImageV = [[UIImageView alloc] init];
        userImageV.frame = CGRectMake(43, 11 + kScreenHeight/4 + i*55 , 20, 23);
        userImageV.image = [UIImage imageNamed:imageArr[i]];
        //[backG addSubview:userImageV];//验证码登录注释
    }
    CutOutClearView *cutOutView = [[CutOutClearView alloc] initWithFrame:self.view.bounds];
    cutOutView.fillColor        = [UIColor redColor];
    cutOutView.paths            = paths;
    _bgImageView.maskView = cutOutView;
    
    //账号&密码  ****_loginImageV.bottom+44
    _numTextField =[[UITextField alloc]initWithFrame:CGRectMake(75, kScreenHeight/4 + 1, kScreenWidth-75-30, 44)];
    _numTextField.delegate  = self;
    _numTextField.textColor = [UIColor colorWithHexString:@"484848"];
    _numTextField.font = [UIFont systemFontOfSize:14];
    _numTextField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    [_numTextField setClearButtonMode:UITextFieldViewModeAlways];
    _numTextField.borderStyle = UITextBorderStyleNone;
    [_numTextField setKeyboardType:UIKeyboardTypeNumberPad];
    //[_bgImageView addSubview:_numTextField];
    //[self.view addSubview:_numTextField];//验证码登录注释
    
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(75, _numTextField.bottom+11, _numTextField.width, 44)];
    _passwordTextfield.textColor = [UIColor colorWithHexString:@"484848"];
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    _passwordTextfield.delegate  = self;
    _passwordTextfield.secureTextEntry = YES;
    _passwordTextfield.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    //[self.view addSubview:_passwordTextfield];//验证码登录注释
    
    
    
    
    
    _phoneNumTextfield =[[UITextField alloc]initWithFrame:CGRectMake(45, kScreenHeight/4 + 1, kScreenWidth-75-30, 44)];
    _phoneNumTextfield.backgroundColor =[UIColor clearColor];
    _phoneNumTextfield.delegate  = self;
    [_phoneNumTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _phoneNumTextfield.borderStyle = UITextBorderStyleNone;
    [_phoneNumTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _phoneNumTextfield.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    _phoneNumTextfield.tag = 2;
    _phoneNumTextfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_phoneNumTextfield];
    
    
    _authTextfield =[[UITextField alloc]initWithFrame:CGRectMake(_phoneNumTextfield.x, _phoneNumTextfield.bottom + 9, kScreenWidth-45*2-100, 46)];
    _authTextfield.backgroundColor =[UIColor clearColor];
    _authTextfield.delegate  = self;
    [_authTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _authTextfield.borderStyle = UITextBorderStyleNone;
    [_authTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _authTextfield.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    _authTextfield.tag = 3;
    _authTextfield.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_authTextfield];
    
    
    //获取验证码
    _sendAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendAuthCodeBtn.frame = CGRectMake(kScreenWidth-100-30, _phoneNumTextfield.bottom + 9, 90, 46);
    _sendAuthCodeBtn.layer.masksToBounds = YES;
    _sendAuthCodeBtn.layer.cornerRadius = 5;
    [_sendAuthCodeBtn addTarget:self action:@selector(clickLoginCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateNormal];
    _sendAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_sendAuthCodeBtn];
    
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_authTextfield.rightWith+4, _phoneNumTextfield.bottom+20, 1, 27)];
    lineLabel1.backgroundColor = RGB(37, 175, 153);
    [self.view addSubview:lineLabel1];
    
    
    //登陆&忘记密码
    NSArray *titleBtnsArr = @[@"登录",@"忘记密码?"];
    for (NSInteger i =0; i< titleBtnsArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, _passwordTextfield.bottom + 34, kScreenWidth-30*2, 45);
        button.tag = 200+i;
        button.layer.cornerRadius = 4;
        [button setTitle:titleBtnsArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickLoginOrforgetButn:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            button.frame = CGRectMake(30, _passwordTextfield.bottom + 79, kScreenWidth-30*2, 45);
            button.titleLabel.font = [UIFont systemFontOfSize:16];
            button.backgroundColor = [UIColor colorWithHexString:@"26bcaa"];
            [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
        }else if (i == 1){
            button.frame = CGRectMake(kScreenWidth-100, _passwordTextfield.bottom + 9, 70, 20);
            [button setTitleColor:[UIColor colorWithHexString:@"a1a1a1"] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
        }
        //验证码登录注释
        if (i == 0) {
            [_bgImageView addSubview:button];
        }
        
    }

    
}

-(void)clickLoginOrforgetButn:(UIButton *)button
{
    NSInteger integern = button.tag - 200;
    if (integern == 0) {
        
        [self login];
        
    }else if (integern == 1){
        //忘记密码
        ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
        [self pushToNextViewController:vc];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self login];
    return YES;
}

-(void)login
{
    typeof(self) weakSelf = self;
    [weakSelf tapImage];
    
    if ([CustomHelper isNetWorking]) {
        if (_phoneNumTextfield.text.length>0 && _authTextfield.text.length>0) {
            
            if (_authTextfield.text.length == 4) {
                [self loginToUrgooserver:_phoneNumTextfield.text password:self.authTextfield.text];
            }else{
                [weakSelf showSVString:@"验证码错误"];
            }
            
        }else{
            [weakSelf showSVString:@"手机号或验证码不能为空"];
        }
    }else{
        [weakSelf showSVErrorString:@"请确认连接了网络"];
    }
    
}

#pragma mark - 登录
-(void)loginToUrgooserver:(NSString *)username password:(NSString *)pwd
{
        //收键盘
        [self tapImage];
    
        typeof(self) weakSelf = self;
        //登录
        [SVProgressHUD showWithStatus:@"loading..."];
        [SVProgressHUD  setBackgroundColor:[UIColor clearColor]];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"username"] = username;
        params[@"password"] = pwd;
        params[@"termType"] = @"2";
        
        [HttpClientManager postAsyn:UG_loginClientLoginByCode_URL params:params success:^(id resultData) {
            
            MsgModel *model= (MsgModel *)[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
            
            
            if ([model.code isEqualToString:@"400"]) {
                [weakSelf showSVString:model.message];
            }else if ([model.code isEqualToString:@"602"]){
                [[AppDelegate sharedappDelegate] showNewLong];
            }
            else if ([model.code isEqualToString:@"200"]) {
 
                EMError *error = [[EMClient sharedClient] loginWithUsername:resultData[@"body"][@"userHxCode"] password:@"123456"];
                DLog(@"%@",error);
                if (!error||error) {
                    DLog(@"登陆成功");
                    
                    if (_isRegist) {
                        DLog(@"注册登录1^_^");
                        //客服环信id:ydc2001
                        EMError *error = [[EMClient sharedClient].contactManager addContact:serviceId message:@"我想加您为好友"];
                        if (error) {
                            NSLog(@"添加失败");
                            [[EMClient sharedClient].contactManager addContact:serviceId message:@"我想加您为好友"];
                        }
                    }
                    
                    //自动登录
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    
                    //Zoom
                    //[self zoomByEmail_getHost_id:@"" success:^{
                        
                        //Growingio
                        NSString *user_id = [NSString stringWithFormat:@"%@",resultData[@"body"][@"userId"]];
                        NSString *user_name = resultData[@"body"][@"nickName"];
                        NSString *user_phone = username;
                        [Growing setCS1Value:user_id forKey:@"user_id"];
                        [Growing setCS2Value:user_name forKey:@"user_name"];
                        [Growing setCS3Value:user_phone forKey:@"user_phone"];
                        [User_Default setObject:user_id forKey:@"Growing_user_id"];
                        [User_Default setObject:user_name forKey:@"Growing_user_name"];
                        [User_Default setObject:user_phone forKey:@"Growing_user_phone"];
                        [User_Default synchronize];
                        
                        //JPush
                        NSString * userId =  [NSString stringWithFormat:@"%@",resultData[@"body"][@"userId"]];
                        [self registJGpush:userId];
                        
                        
                        //userHxCode
                        [[NSUserDefaults standardUserDefaults] setObject:resultData[@"body"][@"userHxCode"] forKey:@"userHxCode"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        NSString *tokenStr =  resultData[@"body"][@"token"];
                        
                        
                        if ([tokenStr isEqualToString:@"(null)"]) {
                            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }else{
                            //token
                            [[NSUserDefaults standardUserDefaults] setObject:tokenStr forKey:@"token"];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }
                        
                        
                        [SVProgressHUD dismiss];
                        //如果登陆的话
                        [[AppDelegate sharedappDelegate] showTabBar];
                    
                        if (_isRegist) {
                            _isRegist = NO;
                            DLog(@"注册登录2^_^");
                            //[self performSelector:@selector(notification) withObject:nil afterDelay:0.5];
                        }
                    
                        //环信登录成功的状态通知
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                    //}];
                }
                else{
                    [weakSelf showSVErrorString:@"登录失败,请稍后重试"];
                }
            }
            
        } failure:^(NSError *error) {
            [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
            
        }];
    
}


#pragma mark - 发送验证码
-(void)clickLoginCodeAction
{
    typeof(self)  weakSelf = self;
    if (_phoneNumTextfield.text.length > 0) {
        if ([CustomHelper checkTelNumber:_phoneNumTextfield.text]) {
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] =_phoneNumTextfield.text;
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_loginGetIdentifyingCodeLogin_URL params:params success:^(id resultData) {
                
                AccountService *service=[[AccountService alloc] init];
                MsgModel *msg= (MsgModel *)[service getHeaderMsgWithDict:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([code isEqualToString:@"200"]) {
                    
                    [weakSelf showSVString:@"发送成功"];
                    [weakSelf.sendAuthCodeBtn countDwon:60];
                    
                }else if ([msg.code isEqualToString:@"400"]){
                    
                    [weakSelf showSVString:msg.message];
                }
                
            } failure:^(NSError *error) {
                
                [weakSelf showSVString:@"发送失败，稍后重试"];
                
            }];
            
        }else{
            [weakSelf showSVString:@"手机号码输入错误"];
        }
    }else{
        [weakSelf showSVString:@"请输入手机号码"];
    }
}



#pragma mark  极光推送的 userId
-(void)registJGpush:(NSString *)userId{
    NSLog(@"%@",userId);
    NSSet *ssss = [NSSet setWithObjects:@"public", nil];
    [JPUSHService setTags:ssss alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
    }];
}

#pragma mark - 点击图片收键盘
-(void)tapImage
{
    [_numTextField resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}


-(void)notification
{
    NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
    //通过通知中心发送通知
    [[NSNotificationCenter defaultCenter] postNotification:notification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
