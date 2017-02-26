//
//  AppDelegate.h
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGNavigationController.h"
#import "UrgooTabBarController.h"
#import "LoginViewController.h"

#import <ZoomSDK/ZoomSDK.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,ZoomSDKAuthDelegate,ZoomSDKMeetingServiceDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(strong,nonatomic)UGNavigationController  *navController;
@property(strong,nonatomic)LoginViewController *loginVC;
@property(strong,nonatomic)UrgooTabBarController *tabbar;



+ (AppDelegate *)sharedappDelegate;

-(void)showLoginOut;
-(void)showNewLong;
-(void)showLogin;
-(void)showTabBar;
-(void)showZoomVideo;
-(void)zoomVideoViewByGetNetData;
-(void)isShowTabBarRdeDot;

@end

