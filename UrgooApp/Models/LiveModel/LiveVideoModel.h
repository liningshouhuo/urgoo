//
//  LiveVideoModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface LiveVideoModel : BaseModel

@property (nonatomic,copy) NSString *masterPic;
@property (nonatomic,copy) NSString *des;
@property (nonatomic,copy) NSString *targetId;
@property (nonatomic,copy) NSString *paticipateCount;
@property (nonatomic,copy) NSString *isPlateform;
@property (nonatomic,copy) NSString *title;
//*status最新动态status为1.(time>0)倒计时 (time<0)进入直播  2.已结束     3.查看回播
@property (nonatomic,copy) NSString *status;
@property (nonatomic,copy) NSString *balanceTime;
@property (nonatomic,copy) NSString *liveId;


//liveDetail     status: 直播类型1：直播(倒计时进入)，2：已结束，3：查看回播(由运营人员上传视频)
@property (nonatomic,copy) NSString *introduce;
@property (nonatomic,copy) NSString *liveNotice;
@property (nonatomic,copy) NSString *liveTimeLong;
@property (nonatomic,copy) NSString *zoomNo;
@property (nonatomic,copy) NSString *liveStartTime;
@property (nonatomic,copy) NSString *video;
@property (nonatomic,copy) NSString *isSign;


@end
