//
//  UGPasswordSettingSucceedVIewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/4/26.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPasswordSettingSucceedVIewController.h"
#import "LoginViewController.h"
#import "UGNavigationController.h"

@interface UGPasswordSettingSucceedVIewController ()
@property(strong,nonatomic) UIImageView * imageView;
@end

@implementation UGPasswordSettingSucceedVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self needBackAction:NO];

    [self setCustomTitle:@"设置成功"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self initUI];
    
}
-(void)initUI{
    
    CGFloat X = kScreenWidth * 0.333;
    CGFloat Y = X * 0.25 ;
    CGFloat W = X;
    CGFloat H = X;
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
    
    _imageView.image = [UIImage imageNamed:@"setting_success@3x"];
    //_imageView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview: _imageView];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(X * 0.6, Y + H + 15, X * 1.8, 30)];
    label.text = @"新密码设置成功，请重新登录";
    label.textColor = RGB(104, 193, 180);
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    
    //提交
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 5;
    submitBtn.frame = CGRectMake(50, _imageView.y+_imageView.height+80, kScreenWidth-100, 40);
    [submitBtn addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitle:@"重新登录" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:submitBtn];

    
    
}
-(void)submitAction{
    
    /*
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    loginVC.hidesBottomBarWhenPushed = YES;
    
    UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
    
    
    
    NSLog(@"tijiao");
    */
    
    [[AppDelegate sharedappDelegate] showNewLong];
    
    
    
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
