//
//  UGAccountDetailViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAccountDetailViewController.h"

@interface UGAccountDetailViewController ()

@end

@implementation UGAccountDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomTitle:@"账单详情"];
    
     [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];
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
