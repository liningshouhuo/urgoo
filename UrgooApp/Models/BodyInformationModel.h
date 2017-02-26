//
//  BodyInformationModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/5/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface BodyInformationModel : BaseModel

@property(nonatomic,copy)NSString *AccountCount;
@property(nonatomic,copy)NSString *TaskCount;
@property(nonatomic,copy)NSString *systemCount;
@property(nonatomic,strong)NSArray *information;

@end
