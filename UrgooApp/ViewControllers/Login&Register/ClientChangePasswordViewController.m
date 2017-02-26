//
//  ClientChangePasswordViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ClientChangePasswordViewController.h"
#import "ProfileService.h"
#import "AccountModel.h"
#import "MsgModel.h";
#import "HttpClientManager.h"
#import "UGPasswordSettingSucceedVIewController.h"
#import "NSString+Hash.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
@interface ClientChangePasswordViewController ()<UITextFieldDelegate>
@property(strong,nonatomic)UITextField *currentPasswordTextField;
@property(strong,nonatomic)UITextField *passwordTextfield;
@property(strong,nonatomic)UITextField *confirmPasswordTextField;
@property(strong,nonatomic)UIView *backView;
@end

@implementation ClientChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"修改密码"];
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
    
    [self initUI];
}
-(void)initUI{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44*3)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    
    
    
    _currentPasswordTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, 0, kScreenWidth-40, 44)];
    _currentPasswordTextField.backgroundColor =[UIColor whiteColor];
    _currentPasswordTextField.delegate  = self;
    [_currentPasswordTextField setClearButtonMode:UITextFieldViewModeAlways];
    _currentPasswordTextField.borderStyle = UITextBorderStyleNone;
    _currentPasswordTextField.placeholder = @"原密码";
    _currentPasswordTextField.secureTextEntry = YES;
    _currentPasswordTextField.font = [UIFont systemFontOfSize:14];
    

//    _currentPasswordTextField.attributedPlaceholder = [NSAttributedString alloc]initWithString:@"原密码" attributes:<#(nullable NSDictionary<NSString *,id> *)#>
//    [_currentPasswordTextField setValue:[UIFont boldSystemFontOfSize:13] forKey:@"_placeholderLabel.font"];
    [_backView addSubview:_currentPasswordTextField];
    
    
    _passwordTextfield =[[UITextField alloc]initWithFrame:CGRectMake(20, _currentPasswordTextField.y+_currentPasswordTextField.height, kScreenWidth-40, 44)];
    _passwordTextfield.backgroundColor =[UIColor whiteColor];
    _passwordTextfield.delegate  = self;
    [_passwordTextfield setClearButtonMode:UITextFieldViewModeAlways];
    _passwordTextfield.borderStyle = UITextBorderStyleNone;
    _passwordTextfield.placeholder = @"新密码";
    _passwordTextfield.secureTextEntry  = YES;
    _passwordTextfield.font = [UIFont systemFontOfSize:14];
    [_backView addSubview:_passwordTextfield];
    
    
    _confirmPasswordTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, _passwordTextfield.y+_passwordTextfield.height, kScreenWidth-40, 44)];
    _confirmPasswordTextField.backgroundColor =[UIColor whiteColor];
    _confirmPasswordTextField.delegate  = self;
    [_confirmPasswordTextField setClearButtonMode:UITextFieldViewModeAlways];
    _confirmPasswordTextField.borderStyle = UITextBorderStyleNone;
    _confirmPasswordTextField.placeholder = @"确认新密码";
    _confirmPasswordTextField.secureTextEntry = YES;
    _confirmPasswordTextField.font = [UIFont systemFontOfSize:14];

    [_backView addSubview:_confirmPasswordTextField];
 
    
    
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
    [submitBtn addTarget:self action:@selector(starButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"确认" forState:UIControlStateNormal];
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

-(void)submitAction
{
    DLog(@"提交");
    __weak ClientChangePasswordViewController *weakSelf = self;
    if (![_passwordTextfield.text isEqualToString:_confirmPasswordTextField.text]&&_currentPasswordTextField.text.length > 0) {
        [weakSelf showSVErrorString:@"两次输入密码不一致"];
    }else{
    
    if (_currentPasswordTextField.text.length>0&&_passwordTextfield.text.length>0&&_confirmPasswordTextField.text.length>0&&[_passwordTextfield.text isEqualToString: _confirmPasswordTextField.text]) {
        if ([CustomHelper validPassword:_confirmPasswordTextField.text]) {
            
            
            // 1.拼接请求参数
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = kToken;
            params[@"currentPassword"] = [_currentPasswordTextField.text md5String];
            params[@"password"] = [_passwordTextfield.text md5String];
            params[@"confirmPassword"] = [_confirmPasswordTextField.text md5String];
            params[@"termType"] = @"2";
            
            [HttpClientManager getAsyn:UG_USER_UPDATE_PASSWORD params:params success:^(id resultData) {
                
                DLog(@"---%@",resultData );
                 ProfileService *service=[[ProfileService alloc] init];
                 MsgModel *model=[service getHeaderMsgWithDict:resultData[@"header"]];
                
                if ([model.code  isEqualToString:@"200"]) {
                    //[weakSelf showSVSuccessWithStatus:@"修改密码成功"];
                    //[weakSelf.navigationController popViewControllerAnimated:YES];
                    
                    [self loginOutAction];
                    UGPasswordSettingSucceedVIewController * vc = [[UGPasswordSettingSucceedVIewController alloc]init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self pushToNextViewController:vc];
                    //                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    //                    loginVC.hidesBottomBarWhenPushed = YES;
                    //
                    //                    UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
                    //                    [self presentViewController:loginNav animated:YES completion:nil];
                    //                    
                    
                }else if ([model.code  isEqualToString:@"400"]){
                    [ weakSelf showSVErrorString:model.message];
                }
                
                
            } failure:^(NSError *error) {
                [weakSelf showSVErrorString:@"网络请求失败，请稍后重试"];
                
            }];
            
           /**[RequestManager updatePasswordWithToken:kToken currentPassword:_currentPasswordTextField.text password:_passwordTextfield.text confirmPassword:_confirmPasswordTextField.text success:^(id resultData) {
                DLog(@"---%@",resultData );
                if ([resultData[@"header"][@"code"]  isEqualToString:@"200"]) {
                    [weakSelf showSVSuccessWithStatus:@"修改密码成功"];
                    //[weakSelf.navigationController popViewControllerAnimated:YES];
                    
                    [self loginOutAction];
                    LoginViewController *loginVC = [[LoginViewController alloc]init];
                    loginVC.hidesBottomBarWhenPushed = YES;
                    
                    UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
                    [self presentViewController:loginNav animated:YES completion:nil];
                    

                    
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"404"]){
//                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }else if ([resultData[@"header"][@"code"]  isEqualToString:@"400"]){
                    [ weakSelf showSVErrorString:resultData[@"header"][@"message"]];
                }
            }  failed:^(NSError *error) {
                [weakSelf showSVErrorString:error.description];
            }];**/
        }else{
            [weakSelf showSVErrorString:@"密码6-18位数字和字母组合"];
        }
    }else{
        [weakSelf showSVErrorString:@"请确认您的原密码和新密码输入正确"];
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
    [_currentPasswordTextField resignFirstResponder];
    [_passwordTextfield resignFirstResponder];
    [_confirmPasswordTextField resignFirstResponder];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self allTextFieldsresignFirstResponder];
}

#pragma mark --‘确认’修改密码的退出登录
-(void)loginOutAction
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                DLog(@"修改密码成功");
                
                //退出登录后清除token
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //退出登录后清除订单状态
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                //退出登录后 去除 极光推送
                [JPUSHService setAlias:@"" callbackSelector:nil object:self];
                //推出登陆，切换到登录页面
                //                [[AppDelegate sharedappDelegate] showLogin];
                //[AppDelegate sharedappDelegate].tabbar.selectedIndex=0;
            }
            else{
                DLog(@"退出登陆的error%@",error.errorDescription);
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });

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
