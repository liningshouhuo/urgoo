//
//  UGWorkssDetailViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGWorkssDetailViewController.h"

@interface UGWorkssDetailViewController ()

@end

@implementation UGWorkssDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"作品详情"];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@001/001/attention/workDtl?workId=%@&token=%@",UG_HOST,_workId,kToken]];
    DLog(@"%@",[NSString stringWithFormat:@"%@001/001/attention/workDtl?workId=%@&token=%@",UG_HOST,_workId,kToken]);
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
