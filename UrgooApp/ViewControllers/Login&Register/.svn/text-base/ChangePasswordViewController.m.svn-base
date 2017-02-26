//
//  ChangePasswordViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "SettingPasswordViewController.h"
#import "NSString+Hash.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)UITextField *phoneNumTextfield;
@property(strong,nonatomic)UITextField *authTextfield;
@property(strong,nonatomic)UIButton *sendAuthCodeBtn;

@property(strong,nonatomic)UIView *backView;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"设置密码"];
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
    
    [self initUI];
}
-(void)initUI{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44*2)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
    
    _phoneNumTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    _phoneNumTextfield.backgroundColor =[UIColor whiteColor];
    _phoneNumTextfield.delegate  = self;
    [_phoneNumTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _phoneNumTextfield.borderStyle = UITextBorderStyleNone;
    [_phoneNumTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _phoneNumTextfield.placeholder = @"手机号";
    _phoneNumTextfield.font = [UIFont systemFontOfSize:14];
    
    [_backView addSubview:_phoneNumTextfield];
    
    
    _authTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _phoneNumTextfield.y+_phoneNumTextfield.height, kScreenWidth-120, 44)];
    _authTextfield.backgroundColor =[UIColor whiteColor];
    _authTextfield.delegate  = self;
    [_authTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _authTextfield.borderStyle = UITextBorderStyleNone;
    [_authTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _authTextfield.placeholder = @"验证码";
    _authTextfield.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_authTextfield];
    
    
    //获取验证码
    _sendAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendAuthCodeBtn.frame = CGRectMake(kScreenWidth-100, _authTextfield.y+2, 90, 40);
    _sendAuthCodeBtn.layer.masksToBounds = YES;
    _sendAuthCodeBtn.layer.cornerRadius = 5;
    [_sendAuthCodeBtn addTarget:self action:@selector(sendAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateNormal];
    _sendAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];

    [_backView addSubview:_sendAuthCodeBtn];
  
    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_authTextfield.x+_authTextfield.width+4, _phoneNumTextfield.y+_phoneNumTextfield.height+10, 1, 20)];
    lineLabel1.backgroundColor = RGB(37, 175, 153);
    [_backView addSubview:lineLabel1];
    
    
    //line
    for(NSInteger i=0;i<2;i++){
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 43.5*(i+1), kScreenWidth-20, 0.5)];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [_backView addSubview:lineLabel];
    }
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    
    //提交
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.frame = CGRectMake(50, _backView.y+_backView.height+80, kScreenWidth-100, 40);
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:submitBtn];
    
}
//发送验证码
-(void)sendAuthCodeAction
{
    __weak ChangePasswordViewController *weakSelf = self;
    if (_phoneNumTextfield.text.length>0) {
        if ([CustomHelper isNetWorking]) {
            [RequestManager getIdentifyingCodeWithPhoneNum:_phoneNumTextfield.text success:^(id resultData) {
                if ([resultData[@"header"][@"code"] isEqualToString:@"200"]) {
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:resultData[@"header"][@"message"]];
                    [weakSelf.sendAuthCodeBtn countDwon:5];
                    
                }else if ([resultData[@"header"][@"code"] isEqualToString:@"400"]){
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:resultData[@"header"][@"message"]];
                }
            } failed:^(NSError *error) {
                [weakSelf showSVErrorString:error.description];
            }];
        }else{
            [weakSelf showSVErrorString:@"请确认连接了网络"];
        }
    }else{
        [weakSelf showSVErrorString:@"请检查您的信息是否填写完整"];
    }
}


-(void)submitAction
{
    DLog(@"提交");
    __weak ChangePasswordViewController *weakSelf = self;
    if (_phoneNumTextfield.text.length>0&&_authTextfield.text.length>0) {
        if ([CustomHelper isNetWorking]) {
            [RequestManager clientFindPasswordWithPhoneNum:_phoneNumTextfield.text activationCode:_authTextfield.text success:^(id resultData) {
                DLog(@"---%@",resultData );
                if ([resultData[@"header"][@"code"]  isEqualToString:@"200"]) {
                    SettingPasswordViewController *vc = [[SettingPasswordViewController alloc]init];
                    [weakSelf pushToNextViewController:vc];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"404"]){
                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"400"]){
                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"405"]){
                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }

            }  failed:^(NSError *error) {
                [weakSelf showSVErrorString:error.description];
            }];
        }else{
            [weakSelf showSVErrorString:@"请确认连接了网络"];
        }
    }else{
        [weakSelf showSVErrorString:@"请确认您的手机号和验证码正确"];
    }
    

  
    
}
-(void)tapAction{
    self.editing = YES;
    [self allTextFieldsresignFirstResponder];
}
//失去第一响应者
-(void)allTextFieldsresignFirstResponder
{
    [_phoneNumTextfield resignFirstResponder];
    [_authTextfield resignFirstResponder];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self allTextFieldsresignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
