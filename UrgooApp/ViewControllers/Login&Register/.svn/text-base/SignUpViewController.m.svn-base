//
//  SignUpViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SignUpViewController.h"
#import "RegisterSuccessViewController.h"
#import "SettingPasswordViewController.h"
#import "ServiceAgreementViewController.h"
#import "HttpClientManager.h"
#import "MsgModel.h"
#import "AccountService.h"


@interface SignUpViewController ()<UITextFieldDelegate>


@property(strong,nonatomic)UITextField *nicknameTextField;
@property(strong,nonatomic)UITextField *phoneNumTextfield;
@property(strong,nonatomic)UITextField *authTextfield;
@property(strong,nonatomic)UITextField *InviteCodeTextfield;
@property(strong,nonatomic)UIButton *sendAuthCodeBtn;

@property(strong,nonatomic)UIView *midView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"注册"];
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];

    [self initUI];
}
-(void)initUI{
    
 
   
    
    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44*3)];
    _midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midView];
    
    _nicknameTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    _nicknameTextField.backgroundColor =[UIColor whiteColor];
    _nicknameTextField.delegate  = self;
    [_nicknameTextField setClearButtonMode:UITextFieldViewModeAlways];
    _nicknameTextField.borderStyle = UITextBorderStyleNone;
    _nicknameTextField.placeholder = @"昵称";
    _nicknameTextField.tag = 1;
    _nicknameTextField.font = [UIFont systemFontOfSize:14];

    [_midView addSubview:_nicknameTextField];
    
    _phoneNumTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _nicknameTextField.y+_nicknameTextField.height, kScreenWidth-40, 44)];
    _phoneNumTextfield.backgroundColor =[UIColor whiteColor];
    _phoneNumTextfield.delegate  = self;
    [_phoneNumTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _phoneNumTextfield.borderStyle = UITextBorderStyleNone;
    [_phoneNumTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _phoneNumTextfield.placeholder = @"手机号";
    _phoneNumTextfield.tag = 2;
    _phoneNumTextfield.font = [UIFont systemFontOfSize:14];
    [_midView addSubview:_phoneNumTextfield];
    
    _authTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _phoneNumTextfield.y+_phoneNumTextfield.height, kScreenWidth-40-100, 44)];
    _authTextfield.backgroundColor =[UIColor whiteColor];
    _authTextfield.delegate  = self;
    [_authTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _authTextfield.borderStyle = UITextBorderStyleNone;
    [_authTextfield setKeyboardType:UIKeyboardTypeNumberPad];
    _authTextfield.placeholder = @"验证码";
    _authTextfield.tag = 3;
    _authTextfield.font = [UIFont systemFontOfSize:14];
    [_midView addSubview:_authTextfield];
   
    //获取验证码
    _sendAuthCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendAuthCodeBtn.frame = CGRectMake(kScreenWidth-100, _phoneNumTextfield.y+_phoneNumTextfield.height+2, 90, 40);
    _sendAuthCodeBtn.layer.masksToBounds = YES;
    _sendAuthCodeBtn.layer.cornerRadius = 5;
    [_sendAuthCodeBtn addTarget:self action:@selector(sendAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [_sendAuthCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitleColor:RGB(37, 175, 153) forState:UIControlStateNormal];
    _sendAuthCodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    [_sendAuthCodeBtn setBackgroundColor:RGB(37, 175, 153)];
    [_midView addSubview:_sendAuthCodeBtn];
    
    
   UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(_authTextfield.x+_authTextfield.width+4, _phoneNumTextfield.y+_phoneNumTextfield.height+10, 1, 20)];
    lineLabel1.backgroundColor = RGB(37, 175, 153);
    [_midView addSubview:lineLabel1];
    
    
    
    _InviteCodeTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _authTextfield.y+_authTextfield.height, kScreenWidth-40, 44)];
    _InviteCodeTextfield.backgroundColor =[UIColor whiteColor];
    _InviteCodeTextfield.delegate  = self;
    [_InviteCodeTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _InviteCodeTextfield.borderStyle = UITextBorderStyleNone;
    _InviteCodeTextfield.placeholder = @"邀请码(选填):";
     _InviteCodeTextfield.font = [UIFont systemFontOfSize:14];
   // [_midView addSubview:_InviteCodeTextfield];
    
    
    //line
    for(NSInteger i=0;i<2;i++){
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 44*(i+1), kScreenWidth-20, 0.5)];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [_midView addSubview:lineLabel];
    }
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    
    
    //服务协议
    UIButton *pactButn = [UIButton buttonWithType:UIButtonTypeCustom];
    pactButn.frame = CGRectMake(20, _authTextfield.y+_authTextfield.height+15, 90, 40);
    pactButn.selected = YES;
    [pactButn addTarget:self action:@selector(clickPactButn) forControlEvents:UIControlEventTouchUpInside];
    [pactButn setTitle:@"《服务协议》" forState:UIControlStateNormal];
    [pactButn setTitleColor:RGB(37, 175, 153) forState:UIControlStateSelected];
    pactButn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.view addSubview:pactButn];
    
    
    //提交
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.frame = CGRectMake(50, pactButn.y+pactButn.height+5, kScreenWidth-100, 40);
    [submitBtn addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:submitBtn];
    
    
    
    //键盘升降
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
//    _nicknameTextField.text = @"nickName";
//    _phoneNumTextfield.text = @"13701682131";
//    _authTextfield.text = @"9455";
//    _InviteCodeTextfield.text = @"邀请码";
}
//防止短时间内重复点击 时间0.5 注册下一步 确认按钮
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(submitAction) object:sender];
    [self performSelector:@selector(submitAction) withObject:sender afterDelay:0.3f];
}

-(void)clickPactButn{
    ServiceAgreementViewController *ServiceAgreementVC = [[ServiceAgreementViewController alloc] init];
    [self.navigationController pushViewController:ServiceAgreementVC animated:YES];
}

- (void)keyboardWillShow:(NSNotification *)nf {
    


}
- (void)keyboardWillHidden:(NSNotification *)nf {

  
}


//发送验证码
-(void)sendAuthCodeAction
{
    __weak SignUpViewController *weakSelf = self;
    if (_nicknameTextField.text.length>0&&_phoneNumTextfield.text.length>0) {
        if ([CustomHelper checkTelNumber:_phoneNumTextfield.text]) {
            
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] =_phoneNumTextfield.text;
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_LOGIN_GET_IDENTIFYING_CODE params:params success:^(id resultData) {
                
                AccountService *service=[[AccountService alloc] init];
                MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([code isEqualToString:@"200"]) {
                    // DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
                    [weakSelf showSVString:@"发送成功"];
                    [weakSelf.sendAuthCodeBtn countDwon:60];
                    
                }else if ([msg.code isEqualToString:@"400"]){
                    DLog(@"注册验证码--->%@",resultData[@"header"][@"message"]);
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
//下一步按钮
-(void)submitAction{
    DLog(@"提交");
   __weak SignUpViewController *weakSelf = self;
//
   NSLog(@"手机  号码------%@",self.phoneNumTextfield.text);
//

    
    SettingPasswordViewController *vc = [[SettingPasswordViewController alloc]init];
              vc.phonenumber = self.phoneNumTextfield.text;
    vc.fromType = 666;
    
    vc.nickNameStr = self.nicknameTextField.text;
    vc.numStr = self.phoneNumTextfield.text; 
    vc.authStr = self.authTextfield.text;
    vc.invateStr = self.InviteCodeTextfield.text;
    
    if (weakSelf.nicknameTextField.text.length != 0 && [CustomHelper checkTelNumber:weakSelf.phoneNumTextfield.text] && weakSelf.authTextfield.text.length == 4) {
//        //下个页面
        [self pushToNextViewController:vc];
    }else{
        [weakSelf showSVErrorString:@"昵称,手机号,验证码有误"];
    }

}
//-(void)returnusernameBlock:(ReturnusernameBlock)block{
//    self.returnusernameBlock = block;
//}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    __weak SignUpViewController *weakSelf = self;
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

-(void)tapAction{
    self.editing = YES;
    [self allTextFieldsresignFirstResponder];
}
//失去第一响应者
-(void)allTextFieldsresignFirstResponder
{
    [_nicknameTextField resignFirstResponder];
    [_phoneNumTextfield resignFirstResponder];
    [_authTextfield resignFirstResponder];
    [_InviteCodeTextfield resignFirstResponder];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self allTextFieldsresignFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
