//
//  UGClientViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGClientViewController.h"

@interface UGClientViewController ()

@end

@implementation UGClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomTitle:@"顾问"];
    
    [self loadWebViewWithUrlStr:UG_STUDENT_CLINT_URL];
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
