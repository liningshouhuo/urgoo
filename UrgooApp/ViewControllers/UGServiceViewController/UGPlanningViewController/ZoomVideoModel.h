//
//  ZoomVideoModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface ZoomVideoModel : BaseModel

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *hxCode;


@property (nonatomic,copy) NSString *zoomId;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *pic;
@property (nonatomic,copy) NSString *zoomNo;
@property (nonatomic,copy) NSString *status;//0:用户未操作，1：接受，2：拒绝

//处理推送字段
@property (nonatomic,copy) NSString *isConfirm;//0:没有红点  1：有红点
@property (nonatomic,copy) NSString *liveId;
@property (nonatomic,copy) NSString *counselorId;

@end
