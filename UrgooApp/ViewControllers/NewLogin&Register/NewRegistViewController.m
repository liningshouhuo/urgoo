//
//  NewRegistViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/15.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewRegistViewController.h"
#import "NewLoginViewController.h"
#import "AccountService.h"
#import "NSString+Hash.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

#import "CutOutClearView.h"

@interface NewRegistViewController ()<UITextFieldDelegate>
{
    UILabel *title;
}

@property(strong,nonatomic)UIImageView *bgImageView;
@property(strong,nonatomic)UITextField *nicknameTextField;
@property(strong,nonatomic)UITextField *phoneNumTextfield;
@property(strong,nonatomic)UITextField *authTextfield;
@property(strong,nonatomic)UITextField *passwordTextfield;
@property(strong,nonatomic)UITextField *confirmPasswordTextField;
@property(strong,nonatomic)UIButton    *sendAuthCodeBtn;

@end

@implementation NewRegistViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    [self tapImageBackGround];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //键盘升降
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self initUI];
    //[self hiddenNavigationNeedLeftBackButtonImageName:@"BackChevron"];
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
    [_bgImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageBackGround)]];
    [backG addSubview:_bgImageView];
    
    
    title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, 30, kScreenWidth, 20);
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    title.text = @"注册";
    [_bgImageView addSubview:title];
    
    NSString *noteStr = @"优顾正在为您推荐推匹配的顾问\n请设置您的账号";
    UILabel *note = [[UILabel alloc] init];
    note.frame = CGRectMake(0, title.bottom + 30, kScreenWidth, 54);
    note.numberOfLines = 2;
    note.font = [UIFont systemFontOfSize:18];
    note.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    note.text = noteStr;
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:noteStr];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle1 setLineSpacing:5];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [noteStr length])];
    [note setAttributedText:attributedString1];
    note.textAlignment = NSTextAlignmentCenter;
    //[_bgImageView addSubview:note];
    
    NSMutableArray *paths = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        /*
        UIView *whiteBackG = [[UIView alloc] init];
        whiteBackG.frame = CGRectMake(30, note.bottom+35 + i*55, kScreenWidth-30*2, 46);
        whiteBackG.layer.cornerRadius = 4;
        whiteBackG.backgroundColor = [UIColor whiteColor];
        [_bgImageView addSubview:whiteBackG];
         */
        
        {
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(30, note.bottom+35 + i*55)];// (x,y)
            [bezierPath addLineToPoint: CGPointMake(kScreenWidth-30, note.bottom+35+ i*55)];
            [bezierPath addLineToPoint: CGPointMake(kScreenWidth-30, 46+note.bottom+35+ i*55)];
            [bezierPath addLineToPoint: CGPointMake(30, 46+note.bottom+35+ i*55)];
            [bezierPath closePath];
            [paths addObject:bezierPath];
        }
    }
    CutOutClearView *cutOutView = [[CutOutClearView alloc] initWithFrame:self.view.bounds];
    cutOutView.fillColor        = [UIColor redColor];
    cutOutView.paths            = paths;
    _bgImageView.maskView = cutOutView;

    
    _nicknameTextField =[[UITextField alloc]initWithFrame:CGRectMake(45, note.bottom+35, kScreenWidth-45*2, 46)];
    _nicknameTextField.backgroundColor =[UIColor clearColor];
    _nicknameTextField.delegate  = self;
    _nicknameTextField.borderStyle = UITextBorderStyleNone;
    _nicknameTextField.tag = 1;
    _nicknameTextField.font = [UIFont systemFontOfSize:14];
    _nicknameTextField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"昵称" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    [_nicknameTextField setClearButtonMode:UITextFieldViewModeAlways];
    [self.view addSubview:_nicknameTextField];
    
    _phoneNumTextfield =[[UITextField alloc]initWithFrame:CGRectMake(_nicknameTextField.x, _nicknameTextField.bottom + 9, _nicknameTextField.width, 46)];
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
    [_sendAuthCodeBtn addTarget:self action:@selector(clickAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateNormal];
    _sendAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:_sendAuthCodeBtn];
    
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_authTextfield.rightWith+4, _phoneNumTextfield.bottom+20, 1, 27)];
    lineLabel1.backgroundColor = RGB(37, 175, 153);
    [self.view addSubview:lineLabel1];
    
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(_authTextfield.x, _authTextfield.bottom + 9, _phoneNumTextfield.width, 46)];
    _passwordTextfield.backgroundColor =[UIColor clearColor];
    _passwordTextfield.delegate  = self;
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    _passwordTextfield.secureTextEntry = YES;
    _passwordTextfield.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    _passwordTextfield.tag = 4;
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    //[self.view addSubview:_passwordTextfield];//验证码登录注释掉
    
    _confirmPasswordTextField =[[UITextField alloc]initWithFrame:CGRectMake(_passwordTextfield.x, _passwordTextfield.bottom + 9, _passwordTextfield.width, 46)];
    _confirmPasswordTextField.backgroundColor =[UIColor clearColor];
    _confirmPasswordTextField.delegate  = self;
    _confirmPasswordTextField.secureTextEntry = YES;
    [_confirmPasswordTextField setClearButtonMode:UITextFieldViewModeAlways];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    _confirmPasswordTextField.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"确定密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"a0cbc6"]}];
    _confirmPasswordTextField.tag = 5;
    _confirmPasswordTextField.font = [UIFont systemFontOfSize:14];
    //[self.view addSubview:_confirmPasswordTextField];//验证码登录注释掉
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    submitBtn.frame = _confirmPasswordTextField.frame;
    submitBtn.layer.cornerRadius = 4;
    [submitBtn addTarget:self action:@selector(clickNextButn) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"注册" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[submitBtn setBackgroundImage:[UIImage imageNamed:@"New_ture_button"] forState:UIControlStateNormal];//验证码登录注释掉
    submitBtn.backgroundColor = [UIColor colorWithHexString:@"26bcaa"];
    [_bgImageView addSubview:submitBtn];
    
}


#pragma mark - 发送验证码
-(void)clickAuthCodeAction
{
    typeof(self)  weakSelf = self;
    if (_nicknameTextField.text.length > 0 && _phoneNumTextfield.text.length > 0) {
        if ([CustomHelper checkTelNumber:_phoneNumTextfield.text]) {
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] =_phoneNumTextfield.text;
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_LOGIN_GET_IDENTIFYING_CODE params:params success:^(id resultData) {
                
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
            [weakSelf showSVErrorString:@"手机号码输入错误"];
        }
    }else{
        [weakSelf showSVErrorString:@"请检查您的信息是否填写完整"];
    }
}

#pragma mark - 点击“下一步”按钮
-(void)clickNextButn
{
    [self tapImageBackGround];
    
    typeof(self)  weakSelf = self;
    
    _passwordTextfield.text = @"123456";
    _confirmPasswordTextField.text = @"123456";
    
    if (_nicknameTextField.text.length == 0 || _phoneNumTextfield.text.length == 0 || _authTextfield.text.length == 0 ||_passwordTextfield.text.length == 0 || _confirmPasswordTextField.text.length == 0) {
        [weakSelf showSVErrorString:@"填写信息不完整！"];
    }else if (![CustomHelper checkTelNumber:_phoneNumTextfield.text]){
        [weakSelf showSVErrorString:@"手机号错误"];
    }else
    
    if (_passwordTextfield.text.length>0&&_confirmPasswordTextField.text.length>0&&[_passwordTextfield.text isEqualToString:_confirmPasswordTextField.text]) {
        if ([CustomHelper validPassword:_passwordTextfield.text]) {
            
                // 1.拼接请求参数
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"phoneNum"] = self.phoneNumTextfield.text;
                params[@"nickName"] = self.nicknameTextField.text;
                params[@"identifyingCode"] = self.authTextfield.text;
                params[@"password"] =[self.passwordTextfield.text md5String];
                params[@"confirmPassword"] =[self.confirmPasswordTextField.text md5String];
                params[@"termType"] = @"2";
                
                [HttpClientManager postAsyn:UG_LOGIN_CLINTREGIST params:params success:^(id resultData) {
                    NSLog(@"%@",resultData);
                    
                    MsgModel *msg = [MsgModel mj_objectWithKeyValues:resultData[@"header"]];
                    NSString *code = msg.code;
                    
                    if ([code isEqualToString:@"200"]) {
                        
                        NSString *userHxCodeStr =resultData[@"body"][@"userHxCode"];
                        NSString * userId =[NSString stringWithFormat:@"%@",resultData[@"body"][@"userId"]];
                        [self kaddJsonQuestionString:userId];
                        
                        EMError *error = [[EMClient sharedClient] registerWithUsername:userHxCodeStr password:@"123456"];
                        NSLog(@"%@",error);
                        
                        if (!error || error) {
                            DLog(@"注册成功");
                            [weakSelf showSVSuccessWithStatus:@"注册成功"];
                            
                             NewLoginViewController *NewLoginVC = [[NewLoginViewController alloc]init];
                             NewLoginVC.isRegist = YES;
                             [NewLoginVC loginToUrgooserver:self.phoneNumTextfield.text password:self.authTextfield.text];
                            
                        }else{
                            DLog(@"注册的error%@",error.errorDescription);
                            //[weakSelf showSVErrorString:error.errorDescription];
                        }
                        
                    }else if ([msg.code  isEqualToString:@"404"]){
                        [ weakSelf showSVErrorString:msg.message];
                    }else if ([msg.code  isEqualToString:@"400"]){
                        [ weakSelf showSVErrorString:msg.message];
                    }else if ([msg.code  isEqualToString:@"405"]){
                        [ weakSelf showSVErrorString:msg.message];
                    }
                    
                } failure:^(NSError *error) {
                    
                    [weakSelf showSVString:@"发送失败，稍后重试"];
                    
                }];
            
        }
        else{
            [weakSelf showSVErrorString:@"密码6-18位数字和字母组合"];
        }
        
    }else{
        [weakSelf showSVErrorString:@"两次输入密码不一致"];
    }
    
}

#pragma mark - JsonQuestionString
-(void)kaddJsonQuestionString:(NSString *)userId
{
    typeof(self) weakSelf = self;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userId"] = userId;
    params[@"questionJson"] = _JsonQuestionStr;
    
    [HttpClientManager postAsyn:UG_clientRegistJsonString_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    typeof(self)  weakSelf = self;
    if (textField.tag == 1 ) {
        if (textField.text.length != 0) {
            weakSelf.nicknameTextField.text = textField.text;
        }else{
            [weakSelf showSVString:@"昵称不能为空"];
        }
    }else if (textField.tag == 2){
        if ([CustomHelper checkTelNumber:textField.text]) {
            weakSelf.phoneNumTextfield.text = textField.text;
        }else if (textField.text.length == 0){
            [weakSelf showSVString:@"手机号未填写"];
        }else{
            [weakSelf showSVErrorString:@"手机号错误"];
        }
    }else if (textField.tag == 3){
        if (textField.text.length == 4) {
            weakSelf.authTextfield.text = textField.text;
        }else if (textField.text.length == 0){
            [weakSelf showSVString:@"验证码未填写"];
        }else{
            [weakSelf showSVErrorString:@"验证码错误"];
        }
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self tapImageBackGround];
    return YES;
}


#pragma mark - 点击图片收键盘
-(void)tapImageBackGround
{
    [_nicknameTextField resignFirstResponder];
    [_phoneNumTextfield resignFirstResponder];
    [_authTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
    [_confirmPasswordTextField resignFirstResponder];
}

#pragma mark  极光推送的 userId
-(void)registJGpush:(NSString *)userId{
    NSLog(@"%@",userId);
    NSSet *ssss = [NSSet setWithObjects:@"public", nil];
    [JPUSHService setTags:ssss alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];
}

#pragma mark - secondView的监听键盘的升降
- (void)keyboardShow:(NSNotification *)nf {
    
    [UIView animateWithDuration:0.25 animations:^{
        if (kScreenHeight < 600) {
            self.view.frame = CGRectMake(0, -100, kScreenWidth, kScreenHeight);
            title.frame = CGRectMake(0, 130, kScreenWidth, 20);
        }
    } completion:^(BOOL finished) {
    }];
}
- (void)keyboardHidden:(NSNotification *)nf {
    
    [UIView animateWithDuration:0.25 animations:^{
    } completion:^(BOOL finished) {
        self.view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        title.frame = CGRectMake(0, 30, kScreenWidth, 20);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
