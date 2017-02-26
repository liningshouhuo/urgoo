//
//  BaseViewController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (BOOL)gestureRecognizerShouldBegin {
    return YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
     [SVProgressHUD dismiss];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    
//    self.navigationItem.hidesBackButton = YES;

    
    [self needBackAction:YES];
    //[self needRightAction:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    
   // [self.navigationController.navigationBar setBackgroundColor:RGB(24, 152, 130)];
    
}
-(void)needBackAction:(BOOL)isNeed
{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}
-(void)needRightAction:(BOOL)isNeed{
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"assistantbtn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAssistant)];
        self.navigationItem.rightBarButtonItem = backItem;

        
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}
#pragma mark - custom title
-(void)setCustomTitle:(NSString *)title
{
    UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
    customLabel.textAlignment = NSTextAlignmentCenter;
    customLabel.textColor = [UIColor whiteColor];
    customLabel.font = [UIFont systemFontOfSize:16];
    customLabel.text = title;
    self.navigationItem.titleView = customLabel;
}
#pragma mark  - back
-(void)backAssistant{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self backToAssistant];
   }
-(void)backToAssistant{
    
     [AppDelegate sharedappDelegate].tabbar.selectedIndex = 0;
}
-(void)backAction
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark --  导航条隐藏后的左侧按钮
-(void)hiddenNavigationNeedLeftBackButtonImageName:(NSString *)imagename
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    leftButton.frame = CGRectMake(10, 30, 30, 20);
    [leftButton setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
}
-(void)leftButtonAction
{
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}



-(void)showSVErrorString:(NSString *)errorString
{
    [SVProgressHUD showErrorWithStatus:errorString];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];


}
-(void)dismiss{
    [SVProgressHUD dismiss];
}


-(void)showSVString:(NSString *)showString
{
    [SVProgressHUD showInfoWithStatus:showString];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

}

- (void)showSVNetWorkError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:error.description];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

}

- (void)showSVServiceFail:(id)resultData{
    [SVProgressHUD showInfoWithStatus:resultData[@"msg"]];
    

    
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

}

- (void)showSVSuccessWithStatus:(NSString *)successStr{
    [SVProgressHUD showSuccessWithStatus:successStr];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];
}


- (void)showSVServiceSuccess:(id)resultData{
    [SVProgressHUD showSuccessWithStatus:resultData[@"msg"]];
    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1];

}

- (BOOL)checkServiceIfSuccess:(id)resultData{
    return [resultData[@"code"]boolValue];
}

- (void)addTapGestureOnView:(UIView*)view target:(id)target selector:(SEL)selector{
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:target action:selector];
    gest.numberOfTapsRequired = 1;
    gest.numberOfTouchesRequired = 1;
    [view addGestureRecognizer:gest];
}

-(void)pushToNextViewController:(BaseViewController *)viewController
{
    if (self.navigationController == nil) {
        viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:viewController animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:viewController animated:YES];
    }

}








@end
