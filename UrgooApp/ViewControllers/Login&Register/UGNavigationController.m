//
//  UGNavigationController.m
//  UrgooApp
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGNavigationController.h"

#import "BaseViewController.h"
//http://ios.jobbole.com/84365/
//右拉侧滑显示
@interface UGNavigationController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign) BOOL enableRightGesture;
@end
@implementation UGNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    
   [self.navigationBar setTranslucent:NO];
    
    //[[UINavigationBar appearance] setBarTintColor:RGB(37, 175, 153)];
    //[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"26BDAB"]];
     //UIImage * img = [UIImage ]
      
     self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
    
    [[UINavigationBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"26BDAB"]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    
    
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    
    
}
-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    // 默认为支持右滑反回
//    if ([self.topViewController isKindOfClass:[BaseViewController class]]) {
//        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin)]) {
//            BaseViewController *vc = (BaseViewController *)self.topViewController;
//            self.enableRightGesture = [vc gestureRecognizerShouldBegin];
//        }
//    }
//    
//    return self.enableRightGesture;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    self.navigationController.swipeBackEnabled = NO;
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
