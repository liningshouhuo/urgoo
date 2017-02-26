//
//  NewTaskDataModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"
#import "NewTaskInforModel.h"

@interface NewTaskDataModel : BaseModel

@property (nonatomic,strong) NewTaskInforModel *taskDetail;
@property (nonatomic,strong) NSArray  *taskComment;


@end
