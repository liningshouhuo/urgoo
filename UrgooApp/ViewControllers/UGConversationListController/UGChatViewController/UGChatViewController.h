//
//  UGChatViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "EaseMessageViewController.h"

#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"

@interface UGChatViewController : EaseMessageViewController<ZoomSDKMeetingServiceDelegate>


@property(strong,nonatomic)NSString *kHxStr;
@property(strong,nonatomic)NSString *name_zoom;
@property(strong,nonatomic)NSString *number_zoom;
@property(strong,nonatomic)NSString *numId;
@property(assign,nonatomic)BOOL      JPushZoom;
-(void)getMeetingNumid;
-(void)isClientAcceptVideoStatus:(NSString *)state result:(void(^)())success;

-(void)addMeeting:(NSString *)numId;
@end
