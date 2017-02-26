//
//  SettingPasswordViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SettingPasswordViewController.h"
#import "RegisterSuccessViewController.h"
#import "HttpClientManager.h"
#import "MsgModel.h"
#import "AccountService.h"
#import "BaseLoginViewController.h"
#import "SignUpViewController.h"
#import "UGAssistantsViewController.h"
#import "NSString+Hash.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>


@interface SettingPasswordViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)UITextField *passwordTextfield;
@property(strong,nonatomic)UITextField *confirmPasswordTextField;
@property(strong,nonatomic)UIView *midView;
@property(strong,nonatomic)SignUpViewController * signUpVc;
@property(strong,nonatomic)NSTimer * timer;
//@property(strong,nonatomic)UIImageView * imageview;
@end

@implementation SettingPasswordViewController

-(void)startTimer{
       // self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollTimer) userInfo:nil repeats:NO];
        
    }

- (void) stopPainting{
    if (self.timer != nil){
        // 定时器调用invalidate后，就会自动执行release方法。不需要在显示的调用release方法
        [self.timer invalidate];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];

    if (_fromType==666) {
        [self setCustomTitle:@"确认密码"];
    }else if (_fromType==667){
        [self setCustomTitle:@"重置密码"];
    }
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
//    _vc2 = [[SignUpViewController alloc]init];
//    [_vc2 returnusernameBlock:^(NSString * text) {
////        NSString * str = text;
//        NSLog(@"111------------%@");
//    }];
    
//    SignUpViewController *vc2 = [[SignUpViewController alloc]init];
//    self.signUpVc = vc2;
//    self.signUpVc.delegate = self;

    [self initUI];
    NSLog(@"2222222-----%@",self.phonenumber);
 
}

-(void)setnusername:(NSString *)text{
    NSString  * str = text;
    NSLog(@"111111111111========%@",str);
    
    
}
-(void)initUI{

    _midView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44*2)];
    _midView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_midView];
    
    
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    _passwordTextfield.backgroundColor =[UIColor whiteColor];
    _passwordTextfield.delegate  = self;
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    _passwordTextfield.secureTextEntry = YES;
    _passwordTextfield.placeholder = @"设置密码";
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    //[_passwordTextfield setValue:[UIFont boldSystemFontOfSize:13] forKey:@"_placeholderLabel.font"];
    [_midView addSubview:_passwordTextfield];
    
    _confirmPasswordTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, _passwordTextfield.y+_passwordTextfield.height, kScreenWidth-40, 44)];
    _confirmPasswordTextField.backgroundColor =[UIColor whiteColor];
    _confirmPasswordTextField.delegate  = self;
    _confirmPasswordTextField.secureTextEntry = YES;
    [_confirmPasswordTextField setClearButtonMode:UITextFieldViewModeAlways];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    _confirmPasswordTextField.placeholder = @"确定密码";
    _confirmPasswordTextField.font = [UIFont systemFontOfSize:14];
    [_midView addSubview:_confirmPasswordTextField];
    
    
    
    //line
    for(NSInteger i=0;i<1;i++){
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 44*(i+1), kScreenWidth-20, 0.5)];
        lineLabel.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [_midView addSubview:lineLabel];
    }
    

    //提交
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.frame = CGRectMake(50, _midView.y+_midView.height+50, kScreenWidth-100, 40);
    [submitBtn addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"完成" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:submitBtn];
    

    
}
//防止短时间内重复点击 时间0.5
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(submitAction) object:sender];
    [self performSelector:@selector(submitAction) withObject:sender afterDelay:0.3f];
}

// 确认按钮
-(void)submitAction
{
//    [_confirmPasswordTextField resignFirstResponder];
//    [_passwordTextfield resignFirstResponder];
   // NSLog(@"dsd");
    __weak SettingPasswordViewController *weakSelf = self;
    
    if (_passwordTextfield.text.length>0&&_confirmPasswordTextField.text.length>0&&[_passwordTextfield.text isEqualToString:_confirmPasswordTextField.text]) {
    if ([CustomHelper validPassword:_passwordTextfield.text]) {
        
        if (_fromType==666) {
            
                [_confirmPasswordTextField resignFirstResponder];
                [_passwordTextfield resignFirstResponder];
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] = self.numStr;
            NSLog(@"%@",self.authStr);
            params[@"nickName"] = self.nickNameStr;
            params[@"identifyingCode"] = self.authStr;
            params[@"password"] =[self.passwordTextfield.text md5String];
            params[@"confirmPassword"] =[self.confirmPasswordTextField.text md5String];
            params[@"termType"] = @"2";
            
            [HttpClientManager postAsyn:UG_LOGIN_CLINTREGIST params:params success:^(id resultData) {
                NSLog(@"%@",resultData);
                //AccountService *service=[[AccountService alloc] init];
                MsgModel *msg=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([code isEqualToString:@"200"]) {
                    
                    NSString *userHxCodeStr =resultData[@"body"][@"userHxCode"];
                    NSString * userId =[NSString stringWithFormat:@"%@",resultData[@"body"][@"userId"]];
                    NSLog(@"%@",userId);
                    [self registJGpush:userId];
                    // NSString *userLoginIdStr =resultData[@"body"][@"userLoginId"];
                    
                    EMError *error = [[EMClient sharedClient] registerWithUsername:userHxCodeStr password:@"123456"];
                    NSLog(@"%@",error);
                    
                    if (error==nil) {
                        DLog(@"注册成功");
                        [weakSelf showSVSuccessWithStatus:@"注册成功"];
                        //                        if (weakSelf.fromType==666) {
                        //                            RegisterSuccessViewController *vc = [[RegisterSuccessViewController alloc]init];
                        //                            [weakSelf pushToNextViewController:vc];
                        //                        }else{
                        //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
                                               //                        }
                        LoginViewController * vc = [[LoginViewController alloc]init];
                         vc.fromType = 998;
                        [vc loginToUrgooserver:self.phonenumber password:[self.passwordTextfield.text md5String]];
                        
                    
                        
                       
                        
                        
                    }else{
                        DLog(@"注册的error%@",error.errorDescription);
                        [weakSelf showSVErrorString:error.errorDescription];
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
            
            
            
            /**[RequestManager registerWithPhoneNum:self.numStr nickName:self.nickNameStr identifyingCode:self.authStr password:self.passwordTextfield.text confirmPassword:self.confirmPasswordTextField.text success:^(id resultData) {
                DLog(@"---%@",resultData );
                
                if ([resultData[@"header"][@"code"]  isEqualToString:@"200"]) {
                    
                    NSString *userHxCodeStr =resultData[@"body"][@"userHxCode"];
                    
                    //                    NSString *userLoginIdStr =resultData[@"body"][@"userLoginId"];
                    
                    EMError *error = [[EMClient sharedClient] registerWithUsername:userHxCodeStr password:@"123456"];
                    if (error==nil) {
                        DLog(@"注册成功");
                        [weakSelf showSVSuccessWithStatus:@"注册成功"];
                        //                        if (weakSelf.fromType==666) {
                        //                            RegisterSuccessViewController *vc = [[RegisterSuccessViewController alloc]init];
                        //                            [weakSelf pushToNextViewController:vc];
                        //                        }else{
                        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                        //                        }
                        
                    }else{
                        DLog(@"注册的error%@",error.errorDescription);
                        [weakSelf showSVErrorString:error.errorDescription];
                    }
                    
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"404"]){
//                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"400"]){
//                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }
            }  failed:^(NSError *error) {
//                [weakSelf showSVErrorString:error.description];
            }];**/

        }
        else if (_fromType==667){
            
            //    忘记密码
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"phoneNum"] = _numStr;
            params[@"password"] = [_passwordTextfield.text md5String ];
            params[@"confirmPassword"] =[_confirmPasswordTextField.text md5String];
            params[@"termType"] = @"2";
            
            [HttpClientManager postAsyn:UG_LOGIN_UPDATE_PASSWORD params:params success:^(id resultData) {
                
                AccountService *service=[[AccountService alloc] init];
                MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
                NSString *code=msg.code;
                
                if ([code  isEqualToString:@"200"]) {
                    [weakSelf showSVSuccessWithStatus:@"修改成功"];
                  
                    CATransition *animation = [CATransition animation];
                    [animation setDuration:1.5];
                    [animation setType: @"ippleEffect"];
                    
                    [animation setSubtype: kCATransitionFromLeft];
                    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                    
                    //[weakSelf.navigationController.view.layer addAnimation:animation forKey:nil];
                    //[weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    [[AppDelegate sharedappDelegate] showNewLong];
                    
                }else if ([code  isEqualToString:@"400"]){
                  [ weakSelf showSVErrorString:msg.message];
                }else if ([code isEqualToString:@"405"]){
                    [weakSelf showSVString:msg.message];
                }
                
            } failure:^(NSError *error) {
                
                [weakSelf showSVString:@"发送失败，稍后重试"];
                
            }];

            
            /**[RequestManager updatePasswordWithPhoneNum:_numStr password:_passwordTextfield.text confirmPassword:_confirmPasswordTextField.text success:^(id resultData) {
                if ([resultData[@"header"][@"code"]  isEqualToString:@"200"]) {
                    [weakSelf showSVSuccessWithStatus:@"修改成功"];
                    
                    CATransition *animation = [CATransition animation];
                    [animation setDuration:1.5];
                    [animation setType: @"ippleEffect"];
                    
                    [animation setSubtype: kCATransitionFromLeft];
                    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
                    
                    [weakSelf.navigationController.view.layer addAnimation:animation forKey:nil];
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                    
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"404"]){
//                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"400"]){
//                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }
            }  failed:^(NSError *error) {
//                [weakSelf showSVErrorString:error.description];
            }];**/
            
            }
        
    }

    else{
        [weakSelf showSVErrorString:@"密码6-18位数字和字母组合"];
    }
    
    }else{
        [weakSelf showSVErrorString:@"两次输入密码不一致"];
    }


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark  极光推送的 userId 
-(void)registJGpush:(NSString *)userId{
    NSLog(@"%@",userId);
    NSSet *ssss = [NSSet setWithObjects:@"public", nil];
    [JPUSHService setTags:ssss alias:userId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        
    }];

    
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
