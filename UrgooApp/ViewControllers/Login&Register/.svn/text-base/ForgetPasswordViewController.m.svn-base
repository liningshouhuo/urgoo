//
//  ForgetPasswordViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "SettingPasswordViewController.h"
#import "HttpClientManager.h"

#import "ProfileService.h"
#import "AccountModel.h"
#import "MsgModel.h"


@interface ForgetPasswordViewController ()<UITextFieldDelegate>
{
    UIButton *submitBtn;
}
@property(strong,nonatomic)UIView *backView;
//账号&密码
@property(strong,nonatomic)UITextField *nameTextfield;
@property(strong,nonatomic)UITextField *passwordTextfield;
@property(strong,nonatomic)UIButton *sendAuthCodeBtn;

@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self setCustomTitle:@"找回密码"];
    
    
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
    
    [self initUI];

}
#pragma mark - initUI
-(void)initUI
{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 32, kScreenWidth, 89)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    //账号&密码
    _nameTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    _nameTextfield.backgroundColor =[UIColor whiteColor];
    _nameTextfield.delegate  = self;
    _nameTextfield.clearsOnBeginEditing = YES;
    [_nameTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _nameTextfield.borderStyle = UITextBorderStyleNone;
//     [_nameTextfield setKeyboardType:UIKeyboardTypeEmailAddress];
    [_nameTextfield setKeyboardType:UIKeyboardTypeNumberPad];

    _nameTextfield.placeholder = @"手机号";
    _nameTextfield.font = [UIFont systemFontOfSize:14];

    [_backView addSubview:_nameTextfield];
    
    
    //line
    UIView *line1 =[[UIView alloc]initWithFrame:CGRectMake(20, _nameTextfield.y+_nameTextfield.height, kScreenWidth-20, 0.5)];
    line1.backgroundColor =RGB(88, 88, 88);
    line1.alpha = 0.3;
    [_backView addSubview:line1];
    
    
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _nameTextfield.y+_nameTextfield.height+1, kScreenWidth-140, 44)];
    _passwordTextfield.backgroundColor = [UIColor whiteColor];
    _passwordTextfield.delegate  = self;
    _passwordTextfield.clearsOnBeginEditing = YES;
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    [_passwordTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _passwordTextfield.placeholder = @"验证码";
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_passwordTextfield];
    
    
    
    //获取验证码
    _sendAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendAuthCodeBtn.frame = CGRectMake(kScreenWidth-100, _nameTextfield.y+_nameTextfield.height+2, 90, 40);
    _sendAuthCodeBtn.layer.masksToBounds = YES;
    _sendAuthCodeBtn.layer.cornerRadius = 5;
    [_sendAuthCodeBtn addTarget:self action:@selector(sendAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateNormal];
    _sendAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    //    [_sendAuthCodeBtn setBackgroundColor:RGB(37, 175, 153)];
    [_backView addSubview:_sendAuthCodeBtn];

    
    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_passwordTextfield.x+_passwordTextfield.width+4, _nameTextfield.y+_nameTextfield.height+10, 1, 20)];
    lineLabel1.backgroundColor = RGB(37, 175, 153);
    [_backView addSubview:lineLabel1];
    
    
    //提交
    submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.frame = CGRectMake(50, _backView.y+_backView.height+80, kScreenWidth-100, 40);
    [submitBtn addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:submitBtn];
    [self addTapGestureOnView:self.view target:self selector:@selector(tapAction)];
    
    
    
//    _nameTextfield.text = @"13701682131";
    
}

-(void)sendAuthCodeAction
{
    NSLog(@"============");
    __weak ForgetPasswordViewController *weakSelf = self;
    if (_nameTextfield.text.length>0) {
        if ([CustomHelper checkTelNumber:_nameTextfield.text]) {
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] = _nameTextfield.text;
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_LOGIN_IDENTIFYING_CODE params:params success:^(id resultData) {

                ProfileService *service=[[ProfileService alloc] init];
                MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
                NSString *code=msg.code;

                if ([code isEqualToString:@"200"]) {
                    //DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:@"发送成功"];
                    [weakSelf.sendAuthCodeBtn countDwon:60];
                    
                }else if ([code isEqualToString:@"400"]){
                   
                    [weakSelf showSVString:msg.message];
                }
                
                
            } failure:^(NSError *error) {
                
                [weakSelf showSVString:@"发送失败，稍后重试"];

            }];
        }else{
            [weakSelf showSVErrorString:@"手机号输入有误"];
        }
    }else{
        [weakSelf showSVErrorString:@"请检查您的信息是否填写完整"];
    }
    

}
//防止短时间内重复点击 时间0.5 修改密码 确认按钮
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(submitAction) object:sender];
    [self performSelector:@selector(submitAction) withObject:sender afterDelay:0.3f];
}

#pragma mark  - next
-(void)submitAction
{
   
//    [self performSelector:@selector(changeButtonStatus) withObject:nil afterDelay:1.0f];//防止用户重复点击
    DLog(@"==============%@,%@",_nameTextfield.text,_passwordTextfield.text);
    
    
    __weak ForgetPasswordViewController *weakSelf = self;
    if (_nameTextfield.text.length>0&&_passwordTextfield.text.length>0) {
       
            
            
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] = _nameTextfield.text;
            params[@"activationCode"] = _passwordTextfield.text;
            params[@"termType"] = @"2";
            
           
            [HttpClientManager getAsyn:UG_LOGIN_CLIENT_FIND_PASSWORD params:params success:^(id resultData) {
                
                ProfileService *service=[[ProfileService alloc] init];
                MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([msg.code isEqualToString:@"200"]) {
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    //[weakSelf showSVString:resultData[@"header"][@"message"]];
                    // button.enabled = NO;
                    SettingPasswordViewController *vc = [[SettingPasswordViewController alloc]init];
                    vc.fromType=667;
                    vc.numStr = _nameTextfield.text;
                    [weakSelf pushToNextViewController:vc];
                    
                }else if ([resultData[@"header"][@"code"] isEqualToString:@"400"]){
                    //DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:msg.message];
                }
                
            } failure:^(NSError *error) {
                
                [weakSelf showSVString:@"发送失败，稍后重试"];
                
            }];
            
            /**[RequestManager clientFindPasswordWithPhoneNum:_nameTextfield.text activationCode:_passwordTextfield.text success:^(id resultData) {
                if ([resultData[@"header"][@"code"] isEqualToString:@"200"]) {
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    //[weakSelf showSVString:resultData[@"header"][@"message"]];
                    SettingPasswordViewController *vc = [[SettingPasswordViewController alloc]init];
                    vc.fromType=667;
                    vc.numStr = _nameTextfield.text;
                    [weakSelf pushToNextViewController:vc];
                    
                }else if ([resultData[@"header"][@"code"] isEqualToString:@"400"]){
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:resultData[@"header"][@"message"]];
                }
            } failed:^(NSError *error) {
                [weakSelf showSVErrorString:error.description];
            }];**/
        }    else{
        [weakSelf showSVErrorString:@"请检查您的信息是否填写完整"];
    }

    
    

}

-(void)tapAction
{
    [self allTextFieldsresignFirstResponder];
}
//失去第一响应者
-(void)allTextFieldsresignFirstResponder
{
    [_nameTextfield resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self allTextFieldsresignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
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
