//
//  UrgooTabBarController.h
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMClientDelegate.h"
#import "EMMessage.h"
#import "UGConversationListController.h"


@interface UrgooTabBarController : UITabBarController

@property(strong,nonatomic)UGConversationListController *conversationVC;
@property(strong,nonatomic)NSArray * array;

- (void)jumpToChatList;

- (void)setupUnreadMessageCount;

- (void)didReceiveLocalNotification:(UILocalNotification *)notification;

- (void)playSoundAndVibration;

//- (void)showNotificationWithMessage:(EMMessage *)message;

@end
