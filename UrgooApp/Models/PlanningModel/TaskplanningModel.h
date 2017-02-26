//
//  TaskplanningModel.h
//  UrgooApp
//
//  Created by UrgooDev on 16/8/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface TaskplanningModel : BaseModel
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *subReply;
@property(nonatomic,copy)NSString *subjectTitle;
@property(nonatomic,copy)NSString *taskId;
@property(nonatomic,copy)NSString *taskStatus;

@end
