//
//  BaseViewController.h
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


// 默认返回为YES,表示支持右滑返回
- (BOOL)gestureRecognizerShouldBegin;


-(void)setCustomTitle:(NSString *)title;

-(void)needBackAction:(BOOL)isNeed;
-(void)needRightAction:(BOOL)isNeed;
-(void)backAction;

//导航条隐藏后的左侧按钮
-(void)hiddenNavigationNeedLeftBackButtonImageName:(NSString *)imagename;


-(void)showSVString:(NSString *)showString;
-(void)showSVErrorString:(NSString *)errorString;
- (void)showSVNetWorkError:(NSError*)error;
- (void)showSVServiceFail:(id)resultData;
- (void)showSVServiceSuccess:(id)resultData;
- (void)showSVSuccessWithStatus:(NSString *)successStr;


- (BOOL)checkServiceIfSuccess:(id)resultData;
- (void)addTapGestureOnView:(UIView*)view target:(id)target selector:(SEL)selector;

-(void)pushToNextViewController:(BaseViewController *)viewController;



@end
