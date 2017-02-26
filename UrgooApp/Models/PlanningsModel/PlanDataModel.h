//
//  PlanDataModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface PlanDataModel : BaseModel

@property (nonatomic,copy)   NSString *reportId;
@property (nonatomic,copy)   NSString *nextTime;
@property (nonatomic,strong) NSArray *listTask;
@property (nonatomic,strong) NSArray *listType;

@end
