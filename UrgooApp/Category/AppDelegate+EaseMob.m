//
//  AppDelegate+EaseMob.m
//  UrgooApp
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "AppDelegate+EaseMob.h"
#import "LoginViewController.h"

#import "MBProgressHUD.h"
#import "ChatHelper.h"
//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#import "Growing.h"

/**
 *  本类中做了EaseMob初始化和推送等操作
 */


@implementation AppDelegate (EaseMob)
- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
                    appkey:(NSString *)appkey
              apnsCertName:(NSString *)apnsCertName
otherConfig:(NSDictionary *)otherConfig
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    
    [[EaseSDKHelper shareHelper] easemobApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:appkey
                                       apnsCertName:apnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    
    [ChatHelper shareHelper];
    
    BOOL isAutoLogin = [EMClient sharedClient].isAutoLogin;
    if (isAutoLogin){
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@YES];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
    }
}

#pragma mark - App Delegate
/*
// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
        EMError * eMError = [[EMClient sharedClient] bindDeviceToken:deviceToken];
        //DLog(@"=====%@",eMError.errorDescription);
        NSLog(@"%@",eMError.errorDescription);
        
    });
    NSLog(@"注册成功  %@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}*/

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.failToRegisterApns", Fail to register apns)
//                                                    message:error.description
//                                                   delegate:nil
//                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
//                                          otherButtonTitles:nil];
//    [alert show];
}

#pragma mark - login changed

- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
//    UINavigationController *navigationController = nil;
    if (loginSuccess) {//登陆成功加载主窗口控制器
        //加载申请通知的数据
//        [[ApplyViewController shareController] loadDataSourceFromLocalDB];
//        if (self.tabbar == nil) {
//            self.tabbar = [[UrgooTabBarController alloc] init];
//            navigationController = [[UGNavigationController alloc] initWithRootViewController:self.tabbar];
//        }else{
//            navigationController  = self.tabbar.navigationController;
//        }
        // 环信UIdemo中有用到Parse，您的项目中不需要添加，可忽略此处
//        [self initParse];
        
        NSString *user_id = [User_Default objectForKey:@"Growing_user_id"];
        NSString *user_name = [User_Default objectForKey:@"Growing_user_name"];
        NSString *user_phone = [User_Default objectForKey:@"Growing_user_phone"];
        [Growing setCS1Value:user_id forKey:@"user_id"];
        [Growing setCS2Value:user_name forKey:@"user_name"];
        [Growing setCS3Value:user_phone forKey:@"user_phone"];

        
        //[self showTabBar];
        
        [ChatHelper shareHelper].mainVC = self.tabbar;
        
        [[ChatHelper shareHelper] asyncGroupFromServer];
        [[ChatHelper shareHelper] asyncConversationFromDB];
        [[ChatHelper shareHelper] asyncPushOptions];
    }
    else{//登陆失败加载登陆页面控制器
        self.tabbar = nil;
        [ChatHelper shareHelper].mainVC = nil;
        
        //[self showLogin];
        [[AppDelegate sharedappDelegate] showNewLong];
        
//        LoginViewController *loginController = [[LoginViewController alloc] init];
//        navigationController = [[UGNavigationController alloc] initWithRootViewController:loginController];
//        [self clearParse];
    }
    
    //设置7.0以下的导航栏
//    if ([UIDevice currentDevice].systemVersion.floatValue < 7.0){
//        navigationController.navigationBar.barStyle = UIBarStyleDefault;
//        [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"titleBar"]
//                                                 forBarMetrics:UIBarMetricsDefault];
//        [navigationController.navigationBar.layer setMasksToBounds:YES];
//    }
    
//    self.window.rootViewController = navigationController;
}

#pragma mark - EMPushManagerDelegateDevice

// 打印收到的apns信息
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"apns.content", @"Apns content")
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"ok", @"OK")
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
