//
//  ExperienceListsModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface ExperienceListsModel : BaseModel

@property (strong, nonatomic) NSString *experienceId;
@property (strong, nonatomic) NSString *detailed;
@property (strong, nonatomic) NSString *endDate;
@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic) NSString *position;
@property (strong, nonatomic) NSString *startDate;

@end
