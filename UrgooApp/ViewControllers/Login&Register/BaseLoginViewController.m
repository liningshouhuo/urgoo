//
//  BaseLoginViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/2.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseLoginViewController.h"
@interface BaseLoginViewController ()
@end

@implementation BaseLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pop{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)pushViewController:(BaseViewController*)viewController{
    if (self.navigationController == nil) {
        viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:viewController animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:viewController animated:YES];
    }}

@end
