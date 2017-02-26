//
//  AppUpDataModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/5/6.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface AppUpDataModel : BaseModel

//@property (copy,nonatomic) NSString *description;
@property (copy,nonatomic) NSString *deviceType;
@property (copy,nonatomic) NSString *downloadUrl;
@property (copy,nonatomic) NSString *insertDateTime;
@property (copy,nonatomic) NSString *insertUserId;
@property (copy,nonatomic) NSString *roleType;
@property (copy,nonatomic) NSString *status;
@property (copy,nonatomic) NSString *updateDateTime;
@property (copy,nonatomic) NSString *updateUserId;
@property (copy,nonatomic) NSString *vesionCode;
@property (copy,nonatomic) NSString *vesionInfoId;
@property (copy,nonatomic) NSString *vesionName;
@property (copy,nonatomic) NSString *vesionDescription;
@property (copy,nonatomic) NSString *isForce;

@end
