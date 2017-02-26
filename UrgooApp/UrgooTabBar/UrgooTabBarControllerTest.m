//
//  UrgooTabBarControllerTest.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UrgooTabBarControllerTest.h"
//消息页面
#import "UGMessagesViewController.h"
#import "UGChatViewController.h"
//通讯录
//#import "UGContactListViewController.h"

//找顾问

#import "UGSearchClientViewController2.h"

#import "UGMineViewController.h"
#import "UGServiceViewController.h"
#import "UGAssistantsViewController.h"

#import "UGNavigationController.h"

#import "LoginViewController.h"


#import "UserProfileManager.h"
#import "MsgModel.h"
#import "AssistantsService.h"
#import "AssistantsModel.h"


@interface UrgooTabBarControllerTest ()
{
    UGAssistantsViewController *_assistantVC;
    UGSearchClientViewController2 *_searchVC1;
    UGServiceViewController *_serviceVC;
    UGMineViewController *_mineVC;
    NSArray * array;
    AssistantsModel * model;
    
}


@end

@implementation UrgooTabBarControllerTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupSubviews
{
    //    self.tabBar.backgroundImage = [[UIImage imageNamed:@"tabbarBackground"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    //    self.tabBar.selectionIndicatorImage = [[UIImage imageNamed:@"tabbarSelectBg"] stretchableImageWithLeftCapWidth:25 topCapHeight:25];
    
    
    
    //assistantVC
    _searchVC1 = [[UGSearchClientViewController2 alloc] init];
    //_searchVC1.fromType = 666;
    _searchVC1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"找顾问" image:[[UIImage imageNamed:@"tag_icon_profile_active_copy2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_profile1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_searchVC1.tabBarItem];
    [self selectedTapTabBarItems:_searchVC1.tabBarItem];
    
    
    
    //assistantVC
    //优宝
    _assistantVC = [[UGAssistantsViewController alloc] init];
    //_assistantVC.model =model;
    _assistantVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"优优" image:[[UIImage imageNamed:@"tag_icon_assistant"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_assistant_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_assistantVC.tabBarItem];
    [self selectedTapTabBarItems:_assistantVC.tabBarItem];
    
    //_conversationVC
    _conversationVC1 = [[UGConversationListController alloc] init];
    _conversationVC1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"消息" image:[[UIImage imageNamed:@"tag_icon_message"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_message_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_conversationVC1.tabBarItem];
    [self selectedTapTabBarItems:_conversationVC1.tabBarItem];
    
    
    //_serviceVC
    _serviceVC = [[UGServiceViewController alloc] init];
    _serviceVC.tabBarItem =[[UITabBarItem alloc] initWithTitle:@"规划" image:[[UIImage imageNamed:@"tag_icon_service"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_service_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_serviceVC.tabBarItem];
    [self selectedTapTabBarItems:_serviceVC.tabBarItem];
    
    //_mineVC
    _mineVC = [[UGMineViewController alloc] init];
    _mineVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我" image:[[UIImage imageNamed:@"tag_icon_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:@"tag_icon_profile_active"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [self unSelectedTapTabBarItems:_mineVC.tabBarItem];
    [self selectedTapTabBarItems:_mineVC.tabBarItem];
    
    
    
    UGNavigationController *assistantNav1=[[UGNavigationController alloc] initWithRootViewController:_assistantVC];
    UGNavigationController *assistantNav=[[UGNavigationController alloc] initWithRootViewController:_searchVC1];
    //
    UGNavigationController *conversationNav=[[UGNavigationController alloc] initWithRootViewController:_conversationVC1];
    UGNavigationController *serviceNav=[[UGNavigationController alloc] initWithRootViewController:_serviceVC];
    UGNavigationController *mineNav=[[UGNavigationController alloc] initWithRootViewController:_mineVC];
    
    if (!model.status ) {
        
        
        if ( [OrderStatus isEqualToString:@"1"]) {
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
            NSLog(@"222222222-------");
        }else {
            NSLog(@"如果  没有 订单  信息   %@",OrderStatus);
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
        }
        
        
    }else{
        
        if ([(NSString * )model.status isEqualToString:@"1"]) {
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
            NSLog(@"222222222-------");
        }else{
            NSLog(@"如果 有  订单 信息 没有订单%@",OrderStatus);
            self.viewControllers = @[assistantNav1, conversationNav, serviceNav,mineNav];
        }
    }
    self.tabBar.translucent = NO;
    
    //    [self selectedTapTabBarItems:_chatListVC.tabBarItem];
}
-(void)unSelectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0f]}  forState:UIControlStateNormal];
}

-(void)selectedTapTabBarItems:(UITabBarItem *)tabBarItem
{
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(37, 175, 153)}  forState:UIControlStateSelected];
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
