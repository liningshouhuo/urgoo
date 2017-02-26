//
//  WelcomeViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "WelcomeViewController.h"
#import "NewLoginViewController.h"
#import "NewUsersViewController.h"

#import "NewRegistViewController.h"

@interface WelcomeViewController ()

@property(strong,nonatomic)UIImageView *bgImageView;
@property(strong,nonatomic)UIImageView *loginImageV;

@end

@implementation WelcomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    [self initUI];
}


-(void)initUI{
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [UIImage imageNamed:@"bg_newLogin"];
    [self.view addSubview:_bgImageView];
    
    _loginImageV = [[UIImageView alloc] init];
    _loginImageV.frame = CGRectMake(0, 85, 146, 115);
    _loginImageV.center = CGPointMake(kScreenWidth/2, kScreenHeight/4);
    _loginImageV.image = [UIImage imageNamed:@"new_logo"];
    [_bgImageView addSubview:_loginImageV];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(0, kScreenHeight/2-38, kScreenWidth, 38);
    title.text = @"欢迎使用优顾";
    title.font = [UIFont systemFontOfSize:36];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    //[_bgImageView addSubview:title];
    
    
    NSArray *rightBtnsArr = @[@"新用户",@"登录"];
    for (NSInteger i = 0; i < rightBtnsArr.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, kScreenHeight-158-45-i*(45+18), kScreenWidth-30*2, 45);
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 0.6;
        button.layer.borderColor = [UIColor colorWithHexString:@"26bcaa"].CGColor;
        button.layer.masksToBounds = YES;
        button.tag = 200 + i;
        [button setTitle:rightBtnsArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"26bcaa"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"26bcaa"]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"26bcaa"]] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage createImageWithColor:RGBAlpha(255, 255, 255, 0.46)] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i==1) {
            button.selected = YES;
        }
        
        [_bgImageView addSubview:button];
        
    }

    
}

-(void)selectButton:(UIButton *)button
{
    NSInteger integer = button.tag - 200;
    if (integer == 1) {
        
        NewLoginViewController *newLoginVC = [[NewLoginViewController alloc] init];
        [self pushToNextViewController:newLoginVC];
        
    }else{
        
        NewUsersViewController *newUserVC = [[NewUsersViewController alloc] init];
        [self pushToNextViewController:newUserVC];
        
        //NewRegistViewController *VC = [[NewRegistViewController alloc] init];
        //[self pushToNextViewController:VC];
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
