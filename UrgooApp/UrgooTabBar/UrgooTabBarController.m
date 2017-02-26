//
//  UrgooTabBarController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UrgooTabBarController.h"

//replaceUGMessageVC
//消息页面
#import "UGMessagesViewController.h"
#import "UGChatViewController.h"
//通讯录
//#import "UGContactListViewController.h"

//找顾问

#import "UGSearchClientViewController2.h"
#import "UGSearchClientViewController.h"

#import "UGMineViewController.h"
#import "UGServiceViewController.h"
#import "UGAssistantsViewController.h"

#import "UGNavigationController.h"

#import "LoginViewController.h"


#import "UserProfileManager.h"
#import "MsgModel.h"
#import "AssistantsService.h"
#import "AssistantsModel.h"

#import "UGNewHomePageViewController.h"
#import "UGNewServiceViewController.h"
#import "UGLiveVideoesViewController.h"
#import "UGServiceNewViewController.h"

//两次提示的默认间隔
static const CGFloat kDefaultPlaySoundInterval = 3.0;
static NSString *kMessageType = @"MessageType";
static NSString *kConversationChatter = @"ConversationChatter";
static NSString *kGroupName = @"GroupName";





@interface UrgooTabBarController ()<UITabBarControllerDelegate,EMChatManagerDelegate>
{
    UGAssistantsViewController  *_assistantVC;
    UGNewHomePageViewController * _searchVC;
    //UGSearchClientViewController2 *_searchVC;
    //UGServiceViewController *_serviceVC;
    UGServiceNewViewController  * _serviceVC;
    UGMineViewController        *_mineVC;
    UGLiveVideoesViewController *_liveVideoesVC;
    NSArray * array;
    AssistantsModel * model;
    
}

@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (strong,nonatomic) UIButton * button;
@end

@implementation UrgooTabBarController

//4.13代理方法监听消息的接收
- (void)didReceiveMessages:(NSArray *)aMessages{
    [self setupUnreadMessageCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;

    //注册消息回调 4.13李宁
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
//    [self addChildViewController:@"UGAssistantsViewController" title:@"Assistant" image:@"tag_icon_assistant" selectedImage:@"tag_icon_assistant_active"];
//    [self addChildViewController:@"UGConversationListController" title:@"Message" image:@"tag_icon_message" selectedImage:@"tag_icon_message_active"];
//    [self addChildViewController:@"UGServiceViewController" title:@"Serveice" image:@"tag_icon_service" selectedImage:@"tag_icon_service_active"];
//    [self addChildViewController:@"UGMineViewController" title:@"Me" image:@"tag_icon_profile" selectedImage:@"tag_icon_profile_active"];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupUnreadMessageCount) name:@"setupUnreadMessageCount" object:nil];
    //注册  提示注册成功显示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNotificationWithMessage:) name:@"showNotificationWithMessage" object:nil];
    
    [self setupSubviews];

    //[self loadRequest];
    //[self setupSubviews];
    [self setupUnreadMessageCount];
    [self setupUntreatedApplyCount];
    
}
//-(void)loadRequest{
//    __weak UrgooTabBarController * weakSelf = self;
//
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"token"] = kToken;//gfaPvUV+GxQ=
//    //params[@"termType"] =@"2";
//    NSLog(@"%@",kToken);
//   // MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
//    [HttpClientManager getAsyn:UG_USER_SELECT_ORDER_INFO   params:params success:^(id resultData) {
//        
//        AssistantsService * assistantsService=[[AssistantsService alloc] init];
//        MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
//        
//        if ([msg.code isEqualToString:@"200"]){
//            model = [assistantsService getAssistantsWithDict:resultData[@"body"]];
//          
//            NSString * Orderstr =  resultData[@"body"][@"status"];
//            
//            if ([Orderstr isEqualToString:@"(null)"]) {
//                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }else{
//                //token
//                [[NSUserDefaults standardUserDefaults] setObject:Orderstr forKey:@"OrderStatus"];
//                [[NSUserDefaults standardUserDefaults] synchronize];
//            }
//            
//
//            
//            [self setupSubviews];
//            
//            
//            
//        }else if ([msg.code isEqualToString:@"400"]){
//          //[weakSelf showSVString:msg.message];
//            [self setupSubviews];
//
//            NSLog(@"11111111---------");
//        }
//            
//            
//            
//        
//    } failure:^(NSError *error) {
//     // [weakSelf showSVErrorString:@"Network request failed, please try again later"];
//        NSLog(@"没有网络");
//        [self setupSubviews];
//
//    }];
//    
//    
//    
//}
#pragma mark - private

- (void)setupSubviews
{
//    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
//    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    
    
    
    //assistantVC
    _searchVC = [[UGNewHomePageViewController alloc] init];
    _searchVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"找顾问" image:[[UIImage imageNamed:@"newpage_tag_icon_1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"new_tag_icon_profile_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_searchVC.tabBarItem];
    [self selectedTapTabBarItems:_searchVC.tabBarItem];
    

    
    //assistantVC
    //优宝
    _assistantVC = [[UGAssistantsViewController alloc] init];
    //_assistantVC.model =model;
    _assistantVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"优优" image:[[UIImage imageNamed:@"tag_icon_assistant"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_assistant_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_assistantVC.tabBarItem];
    [self selectedTapTabBarItems:_assistantVC.tabBarItem];
    
    //_conversationVC

    _conversationVC = [[UGConversationListController alloc] init];
    _conversationVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"直播" image:[[UIImage imageNamed:@"new_tag_icon_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"new_tag_icon_message_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_conversationVC.tabBarItem];
    [self selectedTapTabBarItems:_conversationVC.tabBarItem];

    ///
    _liveVideoesVC = [[UGLiveVideoesViewController alloc] init];
    _liveVideoesVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"直播" image:[[UIImage imageNamed:@"tag_icon_zhibo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_zhibo_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_liveVideoesVC.tabBarItem];
    [self selectedTapTabBarItems:_liveVideoesVC.tabBarItem];

    
    
    //_serviceVC
    _serviceVC = [[UGServiceNewViewController alloc] init];
    _serviceVC.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"规划" image:[[UIImage imageNamed:@"new_tag_icon_service"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"new_tag_icon_service_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_serviceVC.tabBarItem];
    [self selectedTapTabBarItems:_serviceVC.tabBarItem];
    
    //_mineVC
    _mineVC = [[UGMineViewController alloc] init];
    _mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"new_tag_icon_profile_active_copy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"new_tag_icon_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_mineVC.tabBarItem];
    [self selectedTapTabBarItems:_mineVC.tabBarItem];
    
    
    
    UGNavigationController *assistantNav1=[[UGNavigationController alloc] initWithRootViewController:_assistantVC];
    UGNavigationController *assistantNav=[[UGNavigationController alloc] initWithRootViewController:_searchVC];
//
    UGNavigationController *conversationNav=[[UGNavigationController alloc] initWithRootViewController:_liveVideoesVC];
    UGNavigationController *serviceNav=[[UGNavigationController alloc] initWithRootViewController:_serviceVC];
    UGNavigationController *mineNav=[[UGNavigationController alloc] initWithRootViewController:_mineVC];
    
    if (!model.status ) {
       
        
        if ( [OrderStatus isEqualToString:@"1"]) {
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
            NSLog(@"222222222-------");
        }else {
            NSLog(@"如果  没有 订单  信息   %@",OrderStatus);
            self.viewControllers = @[assistantNav, conversationNav, serviceNav,mineNav];
        }
        
        
    }else{
        
        if ([(NSString * )model.status isEqualToString:@"1"]) {
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
            NSLog(@"222222222-------");
        }else{
            NSLog(@"如果 有  订单 信息 没有订单%@",OrderStatus);
            self.viewControllers = @[assistantNav, conversationNav, serviceNav,mineNav];
        }
    }
    self.tabBar.translucent = NO;
    
    
    NSString *zoom = [[NSUserDefaults standardUserDefaults] objectForKey:@"zoom"];
    if (zoom.length > 0) {
        self.selectedIndex = 0;
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"zoom"];
    }
}
#pragma mark 若下单完成，点击找顾问会自动跳到优宝
//-(void)ClickBtn{
//    
//    
//    self.selectedIndex =0;
//    if ([OrderStatus isEqualToString:@"2"]) {
//        NSLog(@"dsad");
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"token"] = kToken;
//        [HttpClientManager getAsyn:UG_USER_SELECT_ORDER_INFO params:params success:^(id json) {
//            MsgModel * masmodel = [MsgModel mj_objectWithKeyValues:json[@"header"] ];
//            if ([masmodel.code isEqualToString:@"200"]) {
//                AssistantsModel * assistantsmodel = [AssistantsModel mj_objectWithKeyValues:json[@"body"]];
//                NSString * Orderstr = assistantsmodel.status;
//                if ([Orderstr isEqualToString:@"2"]) {
//                    NSLog(@"没有下单");
//                }else if ([Orderstr isEqualToString:@"1"]){
//                    
//                    [[AppDelegate sharedappDelegate] showTabBar];
//                    if ([Orderstr isEqualToString:@"(null)"]) {
//                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                    }else{
//                        //token
//                        [[NSUserDefaults standardUserDefaults] setObject:Orderstr forKey:@"OrderStatus"];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                    }
//                    
//                    
//                    
//                }
//            }
//        } failure:^(NSError *error) {
//            NSLog(@"没有网络");
//        }];
//    }else if ([OrderStatus isEqualToString:@"1"]){
//        //self.viewControllers =@[assistantNav1, conversationNav, serviceNav,mineNav];
//        NSLog(@"订单状态已经存在");
//    }
//    
//    
//}


-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0f]}  forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(37, 175, 153)}  forState:UIControlStateSelected];
}


#pragma mark - public

- (void)jumpToChatList
{
    if ([self.navigationController.topViewController isKindOfClass:[UGChatViewController class]]) {
        //        ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
        //        [chatController hideImagePicker];
    }
    else if(_conversationVC)
    {
        [self.navigationController popToViewController:self animated:NO];
        [self setSelectedViewController:_conversationVC];
    }
}

- (EMConversationType)conversationTypeFromMessageType:(EMChatType)type
{
    EMConversationType conversatinType = EMConversationTypeChat;
    switch (type) {
        case EMChatTypeChat:
            conversatinType = EMConversationTypeChat;
            break;
        case EMChatTypeGroupChat:
            conversatinType = EMConversationTypeGroupChat;
            break;
        case EMChatTypeChatRoom:
            conversatinType = EMConversationTypeChatRoom;
            break;
        default:
            break;
    }
    return conversatinType;
}


- (void)didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    if (userInfo)
    {
        if ([self.navigationController.topViewController isKindOfClass:[UGChatViewController class]]) {
//                        ChatViewController *chatController = (ChatViewController *)self.navigationController.topViewController;
//                        [chatController hideImagePicker];
        }
        
        NSArray *viewControllers = self.navigationController.viewControllers;
        [viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop){
            if (obj != self)
            {
                if (![obj isKindOfClass:[UGChatViewController class]])
                {
                    [self.navigationController popViewControllerAnimated:NO];
                }
                else
                {
                    NSString *conversationChatter = userInfo[kConversationChatter];
                    UGChatViewController *chatViewController = (UGChatViewController *)obj;
                    if (![chatViewController.conversation.conversationId isEqualToString:conversationChatter])
                    {
                        [self.navigationController popViewControllerAnimated:NO];
                        EMChatType messageType = [userInfo[kMessageType] intValue];
                        chatViewController = [[UGChatViewController alloc] initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                        switch (messageType) {
                            case EMChatTypeChat:
                            {
                                NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
                                for (EMGroup *group in groupArray) {
                                    if ([group.groupId isEqualToString:conversationChatter]) {
                                        chatViewController.title = group.subject;
                                        break;
                                    }
                                }
                            }
                                break;
                            default:
                                chatViewController.title = conversationChatter;
                                break;
                        }
                        [self.navigationController pushViewController:chatViewController animated:NO];
                    }
                    *stop= YES;
                }
            }
            else
            {
                UGChatViewController *chatViewController = (UGChatViewController *)obj;
                NSString *conversationChatter = userInfo[kConversationChatter];
                EMChatType messageType = [userInfo[kMessageType] intValue];
                chatViewController = [[UGChatViewController alloc] initWithConversationChatter:conversationChatter conversationType:[self conversationTypeFromMessageType:messageType]];
                switch (messageType) {
                    case EMChatTypeGroupChat:
                    {
                        NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
                        for (EMGroup *group in groupArray) {
                            if ([group.groupId isEqualToString:conversationChatter]) {
                                chatViewController.title = group.subject;
                                break;
                            }
                        }
                    }
                        break;
                    default:
                        chatViewController.title = conversationChatter;
                        break;
                }
                [self.navigationController pushViewController:chatViewController animated:NO];
            }
        }];
    }
    else if (_conversationVC)
    {
        
        
        
        
        [self.navigationController popToViewController:self animated:NO];
        
        
//        //add201604091415  刷新新消息提醒
//        [self setupUnreadMessageCount];
        
        
        
        DLog(@"convervc收到了");
        
        
        [self setSelectedViewController:_conversationVC];
        
        
      
    }
    
    
    
    DLog(@"通知的消息是否收到了");
}



- (void)setupUntreatedApplyCount
{
//    NSInteger unreadCount = [[[ApplyViewController shareController] dataSource] count];
//    if (_contactsVC) {
//        if (unreadCount > 0) {
//            _contactsVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
//        }else{
//            _contactsVC.tabBarItem.badgeValue = nil;
//        }
//    }
}


// 统计未读消息数
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (_conversationVC) {
        
        
        DLog(@"unreadCount---->====%d",(int)unreadCount);
        
        if (unreadCount > 0) {
            _conversationVC.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
            
            //add201603280944   保持页面收到消息刷新数据源
            [_conversationVC refreshDataSource];
        }else{
            _conversationVC.tabBarItem.badgeValue = nil;
        }
    }

    
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
}

- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}

- (void)showNotificationWithMessage:(NSNotification *)mes//(EMMessage *)message
{
    EMMessage *message = mes.object;
    
    
    
    EMPushOptions *options = [[EMClient sharedClient] pushOptions];
    //发送本地推送
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate date]; //触发通知的时间
    
    if (options.displayStyle == EMPushDisplayStyleMessageSummary) {
        EMMessageBody *messageBody = message.body;
        NSString *messageStr = nil;
        switch (messageBody.type) {
            case EMMessageBodyTypeText:
            {
                messageStr = ((EMTextMessageBody *)messageBody).text;
            }
                break;
            case EMMessageBodyTypeImage:
            {
                messageStr = NSLocalizedString(@"message.image", @"Image");
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                messageStr = NSLocalizedString(@"message.location", @"Location");
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                messageStr = NSLocalizedString(@"message.voice", @"Voice");
            }
                break;
            case EMMessageBodyTypeVideo:{
                messageStr = NSLocalizedString(@"message.video", @"Video");
            }
                break;
            default:
                break;
        }
        //add201603281014   UserProfileManager 这个类中是关于用户的信息，屏蔽掉了一些文件如修改头像什么的
//        NSString *title = [[UserProfileManager sharedInstance] getNickNameWithUsername:message.from];
//        DLog(@"推送中的title---%@",title);

        
        
        if (message.chatType == EMChatTypeGroupChat) {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:message.conversationId]) {
//                    title = [NSString stringWithFormat:@"%@(%@)", message.from, group.subject];
                    break;
                }
            }
        }
        else if (message.chatType == EMChatTypeChatRoom)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
            NSMutableDictionary *chatrooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
            NSString *chatroomName = [chatrooms objectForKey:message.conversationId];
            if (chatroomName)
            {
//                title = [NSString stringWithFormat:@"%@(%@)", message.from, chatroomName];
            }
        }
        
//        notification.alertBody = [NSString stringWithFormat:@"%@:%@", title, messageStr];
    }
    else{
        notification.alertBody = NSLocalizedString(@"receiveMessage", @"you have a new message");
    }
    
# warning 去掉注释会显示[本地]开头, 方便在开发中区分是否为本地推送
    //notification.alertBody = [[NSString alloc] initWithFormat:@"[本地]%@", notification.alertBody];
    
    notification.alertAction = NSLocalizedString(@"open", @"Open");
    notification.timeZone = [NSTimeZone defaultTimeZone];
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
    } else {
        notification.soundName = UILocalNotificationDefaultSoundName;
        self.lastPlaySoundDate = [NSDate date];
    }
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[NSNumber numberWithInt:message.chatType] forKey:kMessageType];
    [userInfo setObject:message.conversationId forKey:kConversationChatter];
    notification.userInfo = userInfo;
    
    //发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    //    UIApplication *application = [UIApplication sharedApplication];
    //    application.applicationIconBadgeNumber += 1;
}


//- (void)addChildViewController:(NSString *)childController title:(NSString *)title image:(NSString *)normalImg selectedImage:(NSString *)selectedImg {
//    Class class = NSClassFromString(childController);
//    BaseViewController *controller = [[class alloc] init];
//    controller.title = title;
//    
//    UGNavigationController *navi = [[UGNavigationController alloc] initWithRootViewController:controller];
//    [navi.tabBarItem setImage:[[UIImage imageNamed:normalImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [navi.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    [navi.tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
//    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0f]} forState:UIControlStateNormal];
//    [navi.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(37, 175, 153)} forState:UIControlStateSelected];
//    [self addChildViewController:navi];
//}


//-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    if (tabBarController.viewControllers[3]==viewController) {
//        viewController.navigationController.navigationBar.hidden = YES;
//    }
//}
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
//{
//    return YES;
//}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{

    NSString *tokenStr = [NSString stringWithFormat:@"%@",kToken];
    
//    DLog(@"kToken---***>>>%@",tokenStr);
//    DLog(@"kToken-Length--%d",(int)tokenStr.length);
//    if ((tabBarController.viewControllers[1]==viewController||tabBarController.viewControllers[2]==viewController)) {
    if ((tabBarController.viewControllers[1]==viewController||tabBarController.viewControllers[2]==viewController||tabBarController.viewControllers[3]==viewController)&&(tokenStr.length==0||tokenStr.length==6)) {

       LoginViewController *loginVC = [[LoginViewController alloc]init];
       loginVC.hidesBottomBarWhenPushed = YES;
                      
        UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
         [self.selectedViewController presentViewController:loginNav animated:YES completion:nil];
        

        return NO;
    }
    return YES;
}
//- (void)viewWillLayoutSubviews{
//    CGRect tabFrame = self.tabBar.frame; //self.TabBar is IBOutlet of your TabBar
//    tabFrame.size.height = 80;
//    tabFrame.origin.y = self.view.frame.size.height - 80;
//    self.tabBar.frame = tabFrame;
//   
//   // [self.tabBar bringSubviewToFront:self.bottomToolView];
//}
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
