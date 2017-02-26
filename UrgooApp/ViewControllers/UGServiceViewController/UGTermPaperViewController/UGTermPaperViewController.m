//
//  UGTermPaperViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTermPaperViewController.h"

@interface UGTermPaperViewController ()

@end

@implementation UGTermPaperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setCustomTitle:@"学期报告"];
    
    
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_REPORT_SEMESTERLZ_URL,kToken]];
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
