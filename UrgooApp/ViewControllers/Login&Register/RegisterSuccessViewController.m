//
//  RegisterSuccessViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "RegisterSuccessViewController.h"
#import "UrgooTabBarController.h"
#import "BasicInfomationViewController.h"
@interface RegisterSuccessViewController ()
@property(strong,nonatomic)UIImageView *smileImageView;  //smile
@end

@implementation RegisterSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"注册成功"];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self initUI];

}
#pragma mark - initUI
-(void)initUI
{
    _smileImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-50, 43, 100, 120)];
    _smileImageView.image = [UIImage imageNamed:@"Smile_h"];
    [self.view addSubview:_smileImageView];
    
    
    NSArray *titleArr = @[@"继续完善信息",@"进入首页"];
    for (NSInteger i =0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = 5;
        if (i==0) {
            button.frame = CGRectMake(60, _smileImageView.y+_smileImageView.height+41, kScreenWidth-120, 40);
            button.backgroundColor = RGB(37, 175, 153);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            button.frame = CGRectMake(30, _smileImageView.y+_smileImageView.height+41+40+10, kScreenWidth-60, 40);
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];

        }
        button.tag = 100+i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)buttonAction:(UIButton *)button
{
    if (button.tag ==100) {
        DLog(@"Fill in the information");
        BasicInfomationViewController *vc =[[BasicInfomationViewController alloc] init];
        vc.fromType = 666;
        [self pushViewController:vc];
    }else{
        NSLog(@"Enter the home page");
        [[AppDelegate sharedappDelegate] showTabBar];
        }
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
