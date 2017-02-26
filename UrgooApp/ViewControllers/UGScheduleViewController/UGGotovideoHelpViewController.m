//
//  UGGotovideoHelpViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/15.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGGotovideoHelpViewController.h"

@interface UGGotovideoHelpViewController ()

@end

@implementation UGGotovideoHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@""];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@%@?token=%@",UG_HOST,gotovideoHelp,kToken]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@?token=%@",UG_HOST,gotovideoHelp,kToken]);
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
