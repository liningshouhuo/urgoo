//
//  ChatHelper.h
//  UrgooApp
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "UGChatViewController.h"
#import "UrgooTabBarController.h"
#import "UGConversationListController.h"
#import "UGCallViewController.h"

@interface ChatHelper : NSObject<EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate,EMCallManagerDelegate>
@property (strong, nonatomic) EMCallSession *callSession;

//@property (nonatomic, weak) ContactListViewController *contactViewVC;

@property (nonatomic, weak) UGConversationListController *conversationListVC;

@property (nonatomic, weak) UrgooTabBarController *mainVC;

@property (nonatomic, weak) UGChatViewController *chatVC;


@property (strong, nonatomic) UGCallViewController *callController;

+ (instancetype)shareHelper;

- (void)asyncPushOptions;

- (void)asyncGroupFromServer;

- (void)asyncConversationFromDB;


- (void)makeCallWithUsername:(NSString *)aUsername
                     isVideo:(BOOL)aIsVideo;

- (void)hangupCallWithReason:(EMCallEndReason)aReason;

- (void)answerCall;
@end
