//
//  UGLiveVideoDetailViewController.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"

@interface UGLiveVideoDetailViewController : BaseViewController<ZoomSDKMeetingServiceDelegate>

@property (nonatomic,copy) NSString *liveId;
@property (nonatomic,assign) BOOL  isSignSuccess;

@property (nonatomic,copy) NSString *isJPush;
@property (nonatomic,copy) NSString *byHome;
@property (strong, nonatomic) NSString *byGuanZhu2;

@end
