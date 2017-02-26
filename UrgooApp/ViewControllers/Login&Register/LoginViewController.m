//
//  LoginViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "LoginViewController.h"


#import "SignUpViewController.h"
#import "ChangePasswordViewController.h"
#import "ForgetPasswordViewController.h"
#import "RequestManager.h"
#import "HttpClientManager.h"
#import "AccountService.h"
#import "MsgModel.h"
#import "UGAssistantsViewController.h"
#import "UGServiceViewController.h"
#import "UGSearchClientViewController2.h"
#import "NSString+Hash.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "Growing.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(strong,nonatomic)UIImageView *bgImageView;




@property(strong,nonatomic)UIView *midView; //中间的一整块
@property(strong,nonatomic)UIImageView *midImageView; //账号密码
@property(strong,nonatomic)UIImageView *downImageView;//下面的注册登录背景


//账号&密码
@property(strong,nonatomic)UITextField *numTextField;
@property(strong,nonatomic)UITextField *passwordTextfield;

@property(strong,nonatomic)NSString *tokenTure;




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{

    
    
    //登陆
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [UIImage imageNamed:@"bg_test"];
    [self.view addSubview:_bgImageView];
 
    //skip
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.frame = CGRectMake(kScreenWidth-60, 20, 60, 40);
    [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [skipBtn addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:skipBtn];
    
    
    //5 6
    CGFloat kHeight;
    if (kScreenWidth ==320) {
        kHeight = 200;
    }else{
        kHeight = 240;
    }
    
    //midView
    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight, kScreenWidth, 247+30.5)];
    _midView.backgroundColor =[UIColor clearColor];
    [_bgImageView addSubview:_midView];
    
    
    
    
    
    
    //midImageView
    _midImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 89)];
    _midImageView.image = [UIImage imageNamed:@"userpwd"];
    _midImageView.userInteractionEnabled = YES;
    [_midView addSubview:_midImageView];
    
  
    
    //账号&密码
    _numTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-20, 44)];
    _numTextField.delegate  = self;
    _numTextField.textColor = [UIColor whiteColor];
    _numTextField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [_numTextField setClearButtonMode:UITextFieldViewModeAlways];
    _numTextField.borderStyle = UITextBorderStyleNone;
    [_numTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [_midImageView addSubview:_numTextField];
 
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _numTextField.y+_numTextField.height+1, kScreenWidth-20, 44)];
    _passwordTextfield.textColor =[UIColor whiteColor];
    _passwordTextfield.delegate  = self;
    _passwordTextfield.secureTextEntry = YES;
    _passwordTextfield.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    [_midImageView addSubview:_passwordTextfield];
    
    
    //downImageView
    _downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _passwordTextfield.y+_passwordTextfield.height+29, kScreenWidth, 44)];
    _downImageView.image = [UIImage imageNamed:@"signuplognin"];
    _downImageView.userInteractionEnabled = YES;
    [_midView addSubview:_downImageView];
    
    //注册&登陆&忘记密码
    NSArray *rightBtnsArr = @[@"注册",@"登录",@"忘记密码?"];
    for (NSInteger i =0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:rightBtnsArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(RightBtnsAction:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==0) {
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.frame = CGRectMake(10, 0, kScreenWidth/3-0.5, 44);
            [_downImageView addSubview:button];
        }else if (i==1){
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            button.frame = CGRectMake(kScreenWidth/3 + 10, 0, 2*kScreenWidth/3,44);
            [_downImageView addSubview:button];
        }else if (i==2){
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:RGB(82, 86, 94) forState:UIControlStateNormal];
            button.frame = CGRectMake(kScreenWidth/2-100, _passwordTextfield.y+_passwordTextfield.height+29+40+20, 200,30 );
//            button.titleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
//            button.titleLabel.layer.shadowOpacity = 1;
//            button.titleLabel.layer.shadowRadius = 0.1;
//            
//            button.titleLabel.clipsToBounds = NO;
            [_midView addSubview:button];
        }
        button.tag = 200+i;
     
    }

    
    
    
    [_bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    
    
    //_numTextField.text = @"18767161510";
    //_passwordTextfield.text = @"test123456";


    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.textColor = [UIColor whiteColor];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.textColor = [UIColor whiteColor];
}
#pragma mark - 点击图片收键盘
-(void)tapImage
{
    [_numTextField resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}


#pragma mark - skip
-(void)skipAction
{
    [_numTextField resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [AppDelegate sharedappDelegate].tabbar.selectedIndex =0;
    [[AppDelegate sharedappDelegate] showTabBar];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSString *userIdStr = @"";
    
    [self login];
    
    return YES;
}


//登录
-(void)loginToUrgooserver:(NSString *)username password:(NSString *)pwd{
    //收键盘
    [self tapImage];
    
    if (_fromType == 998) {
        //注册登录
        __weak LoginViewController *weakSelf = self;
        // 1.拼接请求参数
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"username"] = username;
        params[@"password"] = pwd;
        
        [HttpClientManager postAsyn:UG_LOGIN_COUNT params:params success:^(id resultData) {
            
            AccountService *service=[[AccountService alloc] init];
            
            MsgModel *model=[service getHeaderMsgWithDict:resultData[@"header"]];
            
            
            if ([model.code isEqualToString:@"400"]) {
                [weakSelf showSVString:model.message];
            }else if ([model.code isEqualToString:@"405"]){
                
            }
            else if ([model.code isEqualToString:@"200"]) {
                DLog(@"resultData--->%@",resultData[@"header"][@"message"]);
                [weakSelf showSVString:model.message];
                
                _tokenTure = resultData[@"body"][@"token"];
                
                
                DLog(@"userHxCode--->%@",resultData[@"body"][@"userHxCode"]);
                EMError *error = [[EMClient sharedClient] loginWithUsername:resultData[@"body"][@"userHxCode"] password:@"123456"];
                if (!error) {
                    DLog(@"登陆成功");
                    //客服环信id:ydc2001
                    EMError *error = [[EMClient sharedClient].contactManager addContact:serviceId message:@"我想加您为好友"];
                    if (error) {
                        NSLog(@"添加失败");
                        [[EMClient sharedClient].contactManager addContact:serviceId message:@"我想加您为好友"];                    }

                    
                    //自动登录
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    [self zoomByEmail_getHost_id:@"" success:^{
                        
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
                        
                        //如果登陆的话
                        [[AppDelegate sharedappDelegate] showTabBar];
                        [self performSelector:@selector(notification) withObject:nil afterDelay:0.5];
                        
                        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                        
                    }];
                
                }
                else{
                    [weakSelf showSVErrorString:@"登录失败,请稍后重试"];
                }
            }
            
        } failure:^(NSError *error) {
            [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
            
        }];

    }else{
    __weak LoginViewController *weakSelf = self;
    // 1.拼接请求参数
        //登录
        [SVProgressHUD showWithStatus:@"loading..."];
        [SVProgressHUD  setBackgroundColor:[UIColor clearColor]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = username;
    params[@"password"] = [pwd md5String];
    
    [HttpClientManager postAsyn:UG_LOGIN_COUNT params:params success:^(id resultData) {
        NSLog(@"%@",resultData);
       // AccountService *service=[[AccountService alloc] init];
        
        MsgModel *model=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });

        if ([model.code isEqualToString:@"400"]) {
            //NSLog(@"meiyou wangluo");
            [weakSelf showSVString:model.message];
        }
        else if ([model.code isEqualToString:@"200"]) {
            DLog(@"resultData--->%@",resultData[@"header"][@"message"]);
           // [weakSelf showSVString:model.message];
            _tokenTure = resultData[@"body"][@"token"];
            
            
            
            DLog(@"userHxCode--->%@",resultData[@"body"][@"userHxCode"]);
            EMError *error = [[EMClient sharedClient] loginWithUsername:resultData[@"body"][@"userHxCode"] password:@"123456"];
            DLog(@"%@",error);
            if (!error) {
                DLog(@"登陆成功");
                
                
                //自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                //Zoom
                [self zoomByEmail_getHost_id:@"" success:^{
                    
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
                    
                    //环信登录成功的状态通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
                }];
            }
            else{
                [weakSelf showSVErrorString:@"登录失败,请稍后重试"];
            }
        }
        
    } failure:^(NSError *error) {
          [SVProgressHUD dismiss];
        [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
        
    }];
    }
    
    
   // NSString * str = @"167";
   //[self registJGpush:str];
}

-(void)notification{
           NSNotification *notification =[NSNotification notificationWithName:@"tongzhi" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        
        
        
        
        
    
    
    
}

-(void)login{
    __weak LoginViewController *weakSelf = self;
    [weakSelf tapImage];
    
    if ([CustomHelper isNetWorking]) {
        if (_numTextField.text.length>0&&_passwordTextfield.text.length>0) {
            
             [self loginToUrgooserver:_numTextField.text password:_passwordTextfield.text];
           
        }else{
          [weakSelf showSVErrorString:@"账号密码不能为空"];
        }
    }else{
        [weakSelf showSVErrorString:@"请确认连接了网络"];
    }

}


#pragma mark - RightBtnsAction
-(void)RightBtnsAction:(UIButton *)button
{
    __weak LoginViewController *weakSelf = self;
    [weakSelf tapImage];

    if (button.tag ==200) {
        //注册
        SignUpViewController *vc =[[SignUpViewController alloc]init];
        [self pushViewController:vc];
    }else if (button.tag ==201){
            if ([CustomHelper isNetWorking]) {
                if (_numTextField.text.length>0&&_passwordTextfield.text.length>0) {
                    
                     [self loginToUrgooserver:_numTextField.text password:_passwordTextfield.text];
                    
                }else{
                    [weakSelf showSVErrorString:@"账号密码不能为空"];
                
                }
            }else{
                [weakSelf showSVErrorString:@"请确认连接了网络"];
            }
        
        
    }else if (button.tag ==202){
        //忘记密码
        ForgetPasswordViewController *vc = [[ForgetPasswordViewController alloc]init];
        [self pushToNextViewController:vc];
        
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    [self tapImage];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    self.navigationController.navigationBarHidden = NO;
}
#pragma mark  极光推送的 userId
-(void)registJGpush:(NSString *)userId{
    NSLog(@"%@",userId);
    NSSet *ssss = [NSSet setWithObjects:@"public", nil];
    [JPUSHService setTags:ssss alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];
    
    
}
#pragma mark - ********* zoom的注册 ********
-(void)zoomByEmail_getHost_id:(NSString *)Id success:(void(^)())getEmailsuccess
{
    __weak typeof(self) weakSelf = self;
    
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = _tokenTure;
    params[@"hostId"] = Id;
    DLog(@"%@?token=%@",UG_getZoomHost_id_URL,kToken);
    
    [HttpClientManager postAsyn:UG_getZoomHost_id_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        NSLog(@"%@",json);
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *email = json[@"body"][@"email"];
            NSString *password = json[@"body"][@"password"];
            NSString *hostId = json[@"body"][@"hostId"];
            
            if (hostId.length < 1) {
                //注册zoom
                [self signUpZoomUser:email passWorld:password result:^{
                    getEmailsuccess();
                }];
            }else{
                //注册成功
                NSLog(@"注册成功:%@",hostId);
                getEmailsuccess();
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"Network request failed, please try again later"];
        [SVProgressHUD dismiss];
    }];
}

-(void)signUpZoomUser:(NSString *)email passWorld:(NSString *)pWorld result:(void(^)())result{
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"api_key"]    = KZoomAPIKey;
    params[@"api_secret"] = KZoomAPISecret;
    params[@"data_type"]  = @"JSON";
    params[@"type"]       = @"1";
    params[@"email"]      = email;
    params[@"password"]   = pWorld;
    
    
    [HttpClientManager postAsyn:@"https://api.zoom.us/v1/user/autocreate" params:params success:^(id resultData) {
        
        NSLog(@"注册用户：%@",resultData);
        
        NSString *Id = [NSString stringWithFormat:@"%@",resultData[@"id"]];
        if (Id.length > 0) {
            
            [self zoomByEmail_getHost_id:Id success:^{
                result();
            }];
        }else{
            //失败
            result();
        }
        
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
@end
