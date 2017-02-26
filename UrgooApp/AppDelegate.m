//
//  AppDelegate.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+EaseMob.h"
#import "LocalSubstitutionCache.h"
#import "UGGuardViewController.h"
#import "MsgModel.h"
#import "AssistantsService.h"
#import "MJExtension.h"
#import "AppUpDataModel.h"
#import "AssistantsModel.h"
#import "AppDelegate.h"
#import "UrgooTabBarControllerTest.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "UGPaySuccessViewController.h"
#import "WelcomeViewController.h"

//推送链接
#import "UGMyScheduleViewController.h"
#import "UGLiveVideoDetailViewController.h"
#import "UGAssistantViewController.h"
#import "UGCounselorDetailNewViewController.h"
#import "UGMyOrderViewController.h"

//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>

//zoom
#import "UGZoomVideoViewController.h"
#import "ZoomVideoView.h"
#import "ZoomVideoModel.h"
#import "ZoomInforModel.h"
#import "UGChatViewController.h"

//GrowingIO
#import "Growing.h"

//share
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import "HRSDK.h"

@interface AppDelegate ()<WXApiDelegate,UIAlertViewDelegate>
{
     AssistantsModel * model;
    UINavigationController *navZoomVC;
}
@property(strong,nonatomic)UIImageView * imageview;
@property(strong,nonatomic)  UIView * uiview;
@property(strong,nonatomic)  UIView * uiview1;
@property(strong,nonatomic)  AppUpDataModel *appUpDataModel;

@property(strong,nonatomic)  UIButton * button;
@property(strong,nonatomic)  NSString * APPURL;
@property(strong,nonatomic) NSString * isForce;
@property(strong,nonatomic) ZoomVideoView *zoomVideoView;
@property(strong,nonatomic) ZoomVideoModel *zoomVideoModel;
@property(strong,nonatomic) ZoomInforModel *zoomInforModel;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //华瑞银行
    [HRSDK initWithAppID:@"3ae8f6f3-7c62-4bdf-8b02-7ae4c55574ef"];
    
    //shareSDK
    [ShareSDK registerApp:@"141301f560a20"
          activePlatforms:@[@(SSDKPlatformSubTypeWechatSession),    @(SSDKPlatformSubTypeWechatTimeline)
                            ,@(SSDKPlatformTypeSinaWeibo)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
        
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 // 从微信开放平台获取 AppID，AppSecret
                 [appInfo SSDKSetupWeChatByAppId:@"wxddc4073835973bd3"
                                       appSecret:@"6541a855b720f36b307a956f9afd0414"];
                 
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"3587318305"
                                           appSecret:@"4814878e0de7555e33491692a9d4e11c"
                                         redirectUri:@"http://www.urgoo.cn"
                                            authType:SSDKAuthTypeBoth];
                 break;
                 
             default:
                 break;
         }
     }];
    
    

    //GrowingIO
    [Growing startWithAccountId:@"b667b6102e2b4e19"];
    
    //Zoom的介入
    UGZoomVideoViewController *mainVC = [[UGZoomVideoViewController alloc] init];
    navZoomVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navZoomVC.navigationBarHidden = YES;
    
    [[ZoomSDK sharedSDK] setZoomDomain:kZoomSDKDomain];
    [[ZoomSDK sharedSDK] setZoomRootController:navZoomVC];
    [self sdkAuth];
    
    
    // 极光推送
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    BOOL isProduction = YES;
#if DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    [JPUSHService setupWithOption:launchOptions appKey:JGAppKey
                          channel:JGChannel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];
    

    //微信支付
    [WXApi registerApp:@"wxddc4073835973bd3" withDescription:@"urgoo.client"];
    
    // 杨德成 20160405 js,css本地化初始化类
    LocalSubstitutionCache *cache = [[LocalSubstitutionCache alloc] init];
    [NSURLCache setSharedURLCache:cache];

    self.window =[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //检测网络
    //[GLobalRealReachability startNotifier];
    
    //环信3.0
    // 初始化环信SDK，详细内容在AppDelegate+EaseMob.m 文件中
    // SDK注册 APNS文件的名字, 需要与后台上传证书时的名字一一对应
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = PUSH_CER;
#else
    apnsCertName = @"ios_urgoo_client_distribution";
#endif
    [self easemobApplication:application
didFinishLaunchingWithOptions:launchOptions

                      appkey:HXAppKey                apnsCertName:apnsCertName
                 otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
    

    NSString *tokenStr = kToken;
    if (tokenStr.length > 1) {
        [self showTabBar];
    }else
        [self showNewLong];
    /*
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"guide"]){
    }else{
        self.window.rootViewController = [[UGGuardViewController alloc]init];
    }*/

    [self.window makeKeyAndVisible];
    self.window.backgroundColor =[UIColor whiteColor];
    
    [self getNetData];
    [self isShowTabBarRdeDot];
    
    NSDictionary *userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        [self KKapplication:application launchOptionsRemoteNotification:userInfo];
    }
    
    return YES;
}



#pragma  mark - zoom_Video
-(void)showZoomVideo
{
    [[NSUserDefaults standardUserDefaults] setObject:@"zoom" forKey:@"zoom"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UGZoomVideoViewController *mainVC = [[UGZoomVideoViewController alloc] init];
    navZoomVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    navZoomVC.navigationBarHidden = YES;
    
    [[ZoomSDK sharedSDK] setZoomDomain:kZoomSDKDomain];
    [[ZoomSDK sharedSDK] setZoomRootController:navZoomVC];
    //[self sdkAuth];
    self.window.rootViewController = navZoomVC;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //[ZoomSDKInviteHelper sharedInstance].customizeInvite = YES;
    //[ZoomSDKInviteHelper sharedInstance].inviteVCName = @"UGZoomVideoViewController";
}

#pragma mark - Auth Delegate
- (void)sdkAuth
{
    ZoomSDKAuthService *authService = [[ZoomSDK sharedSDK] getAuthService];
    if (authService)
    {
        authService.delegate = self;
        authService.clientKey = kZoomSDKAppKey;
        authService.clientSecret = kZoomSDKAppSecret;
        [authService sdkAuth];
    }
}

- (void)onZoomSDKAuthReturn:(ZoomSDKAuthError)returnValue
{
    NSLog(@"onZoomSDKAuthReturn注册Zoom提示： %d", returnValue);
    
    if (returnValue != ZoomSDKAuthError_Success)
    {
        /*
        NSString *message = [NSString stringWithFormat:NSLocalizedString(@"SDK authentication failed, error code: %zd", @""), returnValue];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", @"") otherButtonTitles:NSLocalizedString(@"Retry", @""), nil];
        [alert show];
         */
    }
}
#pragma mark - AlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self performSelector:@selector(sdkAuth) withObject:nil afterDelay:0.f];
    }
}

    

-(void)getNetData{
    
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
     [HttpClientManager postAsyn:UG_appUpData_URL  params:params success:^(id resultData) {
         NSLog(@"%@",resultData);
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:resultData[@"header"]];
        NSArray * arr= [NSArray array];
        arr = resultData[@"body"][@"VesionInfoList"];
         
        if ([msg.code isEqualToString:@"200"]) {
            NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
            
            for (NSDictionary * dict in arr) {
                _appUpDataModel = [AppUpDataModel mj_objectWithKeyValues:dict];
                
                if ([(NSString *)self.appUpDataModel.deviceType isEqualToString:@"1"]&&[(NSString *)self.appUpDataModel.roleType isEqualToString:@"2"]) {
                    
                    if ([self.appUpDataModel.vesionCode isEqualToString:version]) {
                        NSLog(@"sadsad");
                        NSLog(@"%@",self.appUpDataModel.vesionCode);
                        
                    }else{
                        NSLog(@"%@",self.appUpDataModel.vesionCode);
                        
                            if ([(NSString *)self.appUpDataModel.isForce isEqualToString:@"1"]) {

                            _isForce = self.appUpDataModel.isForce;
                            _APPURL=_appUpDataModel.downloadUrl;
                                NSLog(@"%@",_isForce);
                            [self addNewApp:self.appUpDataModel.vesionDescription];
                            
                        }else if ([(NSString *)self.appUpDataModel.isForce isEqualToString:@"2"]){
                            
                            _isForce = self.appUpDataModel.isForce;

                            _APPURL=_appUpDataModel.downloadUrl;
                            [self addNewApp:self.appUpDataModel.vesionDescription];
                        }

                    }
                }
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            
        }
    }failure:^(NSError *error) {
        
    }];
}

-(void)addNewApp:(NSString *)message{
    //NSString * str = [NSString stringWithFormat:@"%@",_appUpDataModel.vesionName];
    
    if ([_isForce isEqualToString:@"2"]) {
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"升级提示" message: message  delegate:self cancelButtonTitle:@"以后再说" otherButtonTitles:@"立即更新", nil];
        alerView.tag = 998;
        [alerView textFieldAtIndex:2];
        [alerView show];

    }else if([_isForce isEqualToString:@"1"]){
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"升级提示" message: message  delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
               alerView.tag = 999;
        [alerView textFieldAtIndex:1];
        [alerView show];

    }
    
}
#pragma mark - UIAlertViewDelegate(推送处理)
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@",_APPURL);
    DLog(@"%ld",buttonIndex);
    
    if (alertView.tag == 998) {
        if (buttonIndex == 1) {//点击确定按钮
            if (_APPURL) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_APPURL]];
            }
        }
    }else if (alertView.tag == 999){
        if (buttonIndex == 0) {//点击确定按钮
            if (_APPURL) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_APPURL]];
            }
        }
    }else if (alertView.tag == 1000){
        if (_tabbar && (buttonIndex != alertView.cancelButtonIndex)) {
            [AppDelegate sharedappDelegate].tabbar.selectedIndex = 1;
        }
    }else if (alertView.tag == 1001){//预约列表
        if (_tabbar && (buttonIndex != alertView.cancelButtonIndex)) {
           
            UGMyScheduleViewController *myScheduleVC = [[UGMyScheduleViewController alloc] init];
            myScheduleVC.isJPush = @"isJPush";
            if ([_zoomVideoModel.isConfirm isEqualToString:@"1"]) {
                myScheduleVC.isRedDot = @"isRedDot";
            }
            self.navController = [[UGNavigationController alloc] initWithRootViewController:myScheduleVC];
            self.window.rootViewController = self.navController;
        }
    }else if (alertView.tag == 1002){//直播详情
        if (_tabbar && (buttonIndex != alertView.cancelButtonIndex)) {
            UGLiveVideoDetailViewController *liveVideoDVC = [[UGLiveVideoDetailViewController alloc] init];
            liveVideoDVC.isJPush = @"isJPush";
            liveVideoDVC.liveId = _zoomVideoModel.liveId;
            self.navController = [[UGNavigationController alloc] initWithRootViewController:liveVideoDVC];
            self.window.rootViewController = self.navController;
        }
    }
    
}




/**
 这里切换的时候可以使用通知 代理 以及单例的UIApplication获取AppDelegate 执行 appDelegate里面的函数，但是通知 会很耗性能的，使用第三种比较好，就是目前 写的这一种
 */


#pragma mark - 切换为登录界面
-(void)showNewLong
{
    WelcomeViewController *welcomeVC = [[WelcomeViewController alloc] init];
    self.navController = [[UGNavigationController alloc] initWithRootViewController:welcomeVC];
    self.window.rootViewController = self.navController;
    //[self.window makeKeyAndVisible];
}


-(void)showLogin
{
    LoginViewController *login = [[LoginViewController alloc]init];
    self.navController = [[UGNavigationController alloc]initWithRootViewController:login];
    self.window.rootViewController = self.navController;
}

#pragma mark - 切换为显示tabbar界面
-(void)showTabBar
{
    _tabbar = [[UrgooTabBarController alloc]init];
    self.window.rootViewController = _tabbar;
    
    //注册  提示注册成功显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"tongzhi" object:nil];
    [self showSignUp];
    [self isShowTabBarRdeDot];
}

-(void)showLoginOut
{
    [NetWorkDataManager isLognOut];
}


-(void)isShowTabBarRdeDot
{
    [NetWorkDataManager isTabBarRedDot:^(BOOL isShowRed) {
        if (isShowRed) {
            [self.tabbar.tabBar showTabBarRedDotOnItemIndex:3.0];
        }else{
            [self.tabbar.tabBar hideTabBarRedDotOnItemIndex:3.0];
        }
    }];
}

+(AppDelegate *)sharedappDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

//显示注册成功 笑脸
-(void)showSignUp{
    CGFloat X = kScreenWidth * 0.18;
    CGFloat Y = X * 2 ;
    CGFloat W = kScreenWidth * 0.64 ;
    CGFloat H = W * 0.79;
    _uiview = [[UIView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
    _uiview.backgroundColor = [UIColor whiteColor];
    _uiview.layer.cornerRadius = 15;
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(W * 0.285, H * 0.13, W * 0.42, H * 0.52)];
    UIImage * image = [UIImage imageNamed:@"smilee"];
    _imageview.image = image;
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0.3 *W, H * 0.75, W * 0.41, H * 0.1)];
    lable.text = @"注册成功~";
    lable.textColor = [UIColor colorWithHexString:@"#27beac"];
    lable.font = [UIFont systemFontOfSize:18];
    lable.textAlignment = NSTextAlignmentCenter;
    [_uiview addSubview:lable ];
    [_uiview setHidden:YES];
    [_uiview addSubview:_imageview];
    
    [self.window.rootViewController.view addSubview:_uiview];
    
    _uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight )];
    _uiview1.backgroundColor = [UIColor blackColor];
    [self.window.rootViewController.view addSubview:_uiview1];
    _uiview1.alpha = 0.3;
    [self.window.rootViewController.view insertSubview:_uiview1 belowSubview:_uiview];
    [_uiview1 setHidden:YES];
    _uiview1.userInteractionEnabled = YES;
    _uiview.userInteractionEnabled = YES;
    [self.window.rootViewController.view bringSubviewToFront:_uiview];
    

}
- (void)tongzhi{
   
    [_uiview setHidden:NO];
    [_uiview1 setHidden:NO];
    [self performSelector:@selector(imageHidden) withObject:nil afterDelay:2];
    
    NSLog(@"－－－－－接收到通知------");
    
}
-(void)imageHidden{
    
    [_uiview setHidden:YES];
    [_uiview1 setHidden:YES];
}




#pragma mark - 推送处理
-(void)KKapplication:(UIApplication *)application launchOptionsRemoteNotification:(NSDictionary *)userInfo
{
    if (userInfo[@"_j_msgid"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpDataMainUIRedDotByJPushNotification" object:nil];
        //激光推送
        [JPUSHService handleRemoteNotification:userInfo];
        
        if (userInfo[@"extra"]) {
            _zoomVideoModel = [ZoomVideoModel mj_objectWithKeyValues:userInfo[@"extra"]];
            // 1.跳转“我”界面  2. Zoom视频(全屏视图)
            if ([_zoomVideoModel.type isEqualToString:@"2"]) {
                
                if (![User_Default objectForKey:@"LoctionZoom"]) {
                    [self zoomVideoViewByJPush:_zoomVideoModel];
                }
                
                if (_tabbar) {
                    _tabbar.selectedIndex = 1;
                }
            }else if ([_zoomVideoModel.type isEqualToString:@"3"]){
                
                if (application.applicationState == UIApplicationStateActive) {
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"消息" message: @"最新留学咨询"  delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"打开", nil];
                    alerView.tag = 1000;
                    //[alerView show];
                }else{
                    if (_tabbar) {
                        [AppDelegate sharedappDelegate].tabbar.selectedIndex = 1;
                    }
                }
            }else if ([_zoomVideoModel.type isEqualToString:@"1001"]){
                //预约普通推送->链接到未确认列表
                if (application.applicationState == UIApplicationStateActive) {
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"消息" message: @"您的预约有新消息"  delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"去看看", nil];
                    alerView.tag = 1001;
                    //[alerView show];
                }else{
                    if (_tabbar) {
                        UGMyScheduleViewController *myScheduleVC = [[UGMyScheduleViewController alloc] init];
                        myScheduleVC.isJPush = @"isJPush";
                        if ([_zoomVideoModel.isConfirm isEqualToString:@"1"]) {
                            myScheduleVC.isRedDot = @"isRedDot";
                        }
                        self.navController = [[UGNavigationController alloc] initWithRootViewController:myScheduleVC];
                        self.window.rootViewController = self.navController;
                    }
                }
            }else if ([_zoomVideoModel.type isEqualToString:@"2001"]){
                //直播详情
                if (application.applicationState == UIApplicationStateActive) {
                    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"消息" message: @"优顾直播消息"  delegate:self cancelButtonTitle:@"关闭" otherButtonTitles:@"去看看", nil];
                    alerView.tag = 1002;
                    //[alerView show];
                }else{
                    if (_tabbar) {
                        UGLiveVideoDetailViewController *liveVideoDVC = [[UGLiveVideoDetailViewController alloc] init];
                        liveVideoDVC.isJPush = @"isJPush";
                        liveVideoDVC.liveId = _zoomVideoModel.liveId;
                        self.navController = [[UGNavigationController alloc] initWithRootViewController:liveVideoDVC];
                        self.window.rootViewController = self.navController;
                    }
                }
            }else if ([_zoomVideoModel.type isEqualToString:@"3001"]){
                //消息
                if (application.applicationState != UIApplicationStateActive) {
                    if (_tabbar) {
                        
                        UGAssistantViewController *assistantVC =[[UGAssistantViewController alloc] init];
                        assistantVC.isJPush = @"isJPush";
                        self.navController = [[UGNavigationController alloc] initWithRootViewController:assistantVC];
                        self.window.rootViewController = self.navController;
                    }
                }
            }else if ([_zoomVideoModel.type isEqualToString:@"4001"]){
                //顾问详细
                if (application.applicationState != UIApplicationStateActive) {
                    if (_tabbar) {
                        UGCounselorDetailNewViewController *counselorDetailNewVC =[[UGCounselorDetailNewViewController alloc] init];
                        counselorDetailNewVC.isJPush = @"isJPush";
                        counselorDetailNewVC.counselorId = _zoomVideoModel.counselorId;
                        self.navController = [[UGNavigationController alloc] initWithRootViewController:counselorDetailNewVC];
                        self.window.rootViewController = self.navController;
                    }
                }
            }
        }
        
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (userInfo) {
        [self KKapplication:application launchOptionsRemoteNotification:userInfo];
    }
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    
}

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    DLog(@"%ld",notificationSettings.types);
    
    if (notificationSettings.types == UIUserNotificationTypeNone) {
        DLog(@"%ld",notificationSettings.types);
    }
}

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
        EMError * eMError = [[EMClient sharedClient] bindDeviceToken:deviceToken];
        NSLog(@"%@",eMError.errorDescription);
    });
    
    NSLog(@"注册成功  %@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [JPUSHService registerDeviceToken:deviceToken];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSString *  resultStatus = resultDic[@"resultStatus"];
            
                 
                 NSLog(@"这是 9.0 一下");
            
            NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:resultStatus,@"resultStatus",nil];
            //创建一个消息对象
            NSNotification * ailipay = [NSNotification notificationWithName:@"alipay_resultStatus" object:self userInfo:dict];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:ailipay];
                
            
        }];
    }
    
    //微信注册代理
    [WXApi handleOpenURL:url delegate:self];
    
    //GrowingIO
    [Growing handleUrl:url];
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result =___ %@",resultDic);
            NSString *  resultStatus = resultDic[@"resultStatus"];
            
            
            NSLog(@"这是 9.0 以上");
            
            NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:resultStatus,@"resultStatus",nil];
            //创建一个消息对象
            NSNotification * ailipay = [NSNotification notificationWithName:@"alipay_resultStatus" object:self userInfo:dict];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:ailipay];
            

        }];
    }
    
    //微信注册代理
    [WXApi handleOpenURL:url delegate:self];
    
    //GrowingIO
    [Growing handleUrl:url];
    
    return YES;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        NSString  * weCatpay = @"";
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付成功^_^";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                weCatpay = [NSString stringWithFormat:@"%d",resp.errCode];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付失败！"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                weCatpay = [NSString stringWithFormat:@"%d",resp.errCode];

                break;
                
                
                
        }
        
        NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:weCatpay,@"weCatpay",nil];
        //创建一个消息对象
        NSNotification * wexinpay = [NSNotification notificationWithName:@"weCat_resultStatus" object:self userInfo:dict];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:wexinpay];
        
        NSLog(@"%@",weCatpay);

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

#pragma mark - JPush进入Zoom
-(void)zoomVideoViewByJPush:(ZoomVideoModel *)zoomVideoModel
{
    typeof(self) weakSelf = self;
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    _zoomVideoView = [[ZoomVideoView alloc] init];
    _zoomVideoView.hidden = NO;
    _zoomVideoView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [_zoomVideoView initUIData:zoomVideoModel];
    [[UIApplication sharedApplication].keyWindow addSubview:_zoomVideoView];
    
    _zoomVideoView.rejectBlock = ^(){
        DLog(@"*****拒绝*****");
        [User_Default removeObjectForKey:@"LoctionZoom"];
        weakSelf.zoomVideoView.hidden = YES;
        [weakSelf isClientAcceptVideoStatus:@"2" result:^{
            
        }];
    };
    _zoomVideoView.acceptBlock = ^(){
        DLog(@"*****接受*****");
        [User_Default removeObjectForKey:@"LoctionZoom"];
        weakSelf.zoomVideoView.hidden = YES;
        [weakSelf isClientAcceptVideoStatus:@"1" result:^{
            
        }];
        [weakSelf addMeeting:zoomVideoModel];
    };
}

#pragma mark - 根据状态进入Zoom房间
-(void)zoomVideoViewByGetNetData
{
    typeof(self) weakSelf = self;
    [self ZoomDataByGetNetData:^(ZoomVideoModel *zoomVideoModel) {
        
        if (![zoomVideoModel.status isEqualToString:@"2"]) {
            DLog(@"有视频房间");
            [User_Default setObject:@"LoctionZoom" forKey:@"LoctionZoom"];
            [User_Default synchronize];
            [weakSelf zoomVideoViewByJPush:zoomVideoModel];
        }
        
    }];
}

-(void)ZoomDataByGetNetData:(void(^)(ZoomVideoModel *zoomVideoModel))zoomVideoModel
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]    = kToken;
    params[@"termType"] = @"2";
    
    [HttpClientManager postAsyn:UG_isJoinZoomRoom_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _zoomVideoModel = [ZoomVideoModel mj_objectWithKeyValues:json[@"body"][@"zoomInfo"]];
            if (_zoomVideoModel) {
                zoomVideoModel(_zoomVideoModel);
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [SVProgressHUD showErrorWithStatus:msg.message];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showSuccessWithStatus:@"网络请求超时, 请稍后再试！"];
    }];
}

-(void)isClientAcceptVideoStatus:(NSString *)state result:(void(^)())success{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"opStatus"] = state;// 1.接受 2.拒接 0.未操作
    params[@"termType"] = @"2";
    
    [HttpClientManager postAsyn:isClientcceptStates params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            success();
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络请求超时，请稍后再试！"];
    }];
}

-(void)addMeeting:(ZoomVideoModel *)zoomVideomodel{
    
    [[AppDelegate sharedappDelegate] showZoomVideo];
    
    ZoomSDKMeetingService *ms = [[ZoomSDK sharedSDK] getMeetingService];
    if (ms)
    {
        NSString *name = [User_Default objectForKey:@"Growing_user_name"];
        if (!name) {
            name = @"Parents";
        }
        ms.delegate = self;
        ZoomSDKMeetError ret = [ms joinMeeting:zoomVideomodel.zoomNo displayName:name password:@""];
        NSLog(@"onJoinaMeeting ret:%d", ret);
    }
}

#pragma mark - Zoom Meeting Service Delegate
- (void)onMeetingReturn:(ZoomSDKMeetError)error internalError:(NSInteger)internalError
{
    NSLog(@"onMeetingReturn:%d, internalError:%zd", error, internalError);
}

- (void)onMeetingStateChange:(ZoomSDKMeetingState)state
{
    NSLog(@"onMeetingStateChange:%d", state);
    if (state == ZoomSDKMeetingState_Idle) {
        [User_Default removeObjectForKey:@"LoctionZoom"];
        [[AppDelegate sharedappDelegate] showTabBar];
    }
    
#if 1
    if (state == ZoomSDKMeetingState_InMeeting)
    {
        //For customizing the content of Invite by SMS
        NSString *meetingID = [[ZoomSDKInviteHelper sharedInstance] meetingID];
        NSString *smsMessage = [NSString stringWithFormat:NSLocalizedString(@"Please join meeting with ID: %@", @""), meetingID];
        [[ZoomSDKInviteHelper sharedInstance] setInviteSMS:smsMessage];
        
        //For customizing the content of Copy URL
        NSString *joinURL = [[ZoomSDKInviteHelper sharedInstance] joinMeetingURL];
        NSString *copyURLMsg = [NSString stringWithFormat:NSLocalizedString(@"Meeting URL: %@", @""), joinURL];
        [[ZoomSDKInviteHelper sharedInstance] setInviteCopyURL:copyURLMsg];
    }
#endif
}




// App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// App将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
    [self isShowTabBarRdeDot];
    
    if ([_isForce isEqualToString:@"1"]) {
        [self getNetData];
    }
}


@end
