//
//  SendEmailViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SendEmailViewController.h"

@interface SendEmailViewController ()
@property(strong,nonatomic)UIImageView *emailImageView;  //email
@property(strong,nonatomic) UILabel *emailLabel;
@end

@implementation SendEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"设置成功"];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self initUI];
    
}
#pragma mark - initUI
-(void)initUI
{
    _emailImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 43, 100, 95)];
    _emailImageView.image = [UIImage imageNamed:@"icon_forgot_password"];
    [self.view addSubview:_emailImageView];
    
    //名字
    _emailLabel = [[UILabel alloc]initWithFrame:CGRectMake(30,_emailImageView.y+_emailImageView.height+30,kScreenWidth-60,20)];
    _emailLabel.textAlignment = NSTextAlignmentCenter;
    _emailLabel.text = @"新密码设置成功，请重新登录";
    _emailLabel.font = [UIFont systemFontOfSize:12];
    _emailLabel.textColor = RGB(37, 175, 153);
    [self.view addSubview:_emailLabel];
    
    //back
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.layer.masksToBounds = YES;
    backBtn.layer.cornerRadius = 5;
    backBtn.frame = CGRectMake(50, _emailLabel.y+_emailLabel.height+50, kScreenWidth-100, 40);
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setTitle:@"重新登录" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setBackgroundColor:RGB(37, 175, 153)];
    [self.view addSubview:backBtn];
    
}
-(void)backAction
{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
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
