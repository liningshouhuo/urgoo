//
//  LiveZoomModel.h
//  UrgooApp
//
//  Created by UrgooDev on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface LiveZoomModel : BaseModel
@property(nonatomic,copy)NSString *liveId;
@property(nonatomic,copy)NSString *masterPic;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *titleSub;
@end
