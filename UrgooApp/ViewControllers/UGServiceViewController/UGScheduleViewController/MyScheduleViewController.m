//
//  MyScheduleViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "MyScheduleViewController.h"

@interface MyScheduleViewController ()


@end

@implementation MyScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"预约安排"];
    
    //[self loadWebViewWithUrlStr:UG_STUDENT_FOLLOW_URL];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_ParentSchedule_URL,kToken]];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
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
