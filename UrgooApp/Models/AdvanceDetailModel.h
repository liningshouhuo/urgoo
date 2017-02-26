//
//  AdvanceDetailModel.h
//  UrgooApp
//
//  Created by UrgooDev on 16/6/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface AdvanceDetailModel : BaseModel
@property (strong,nonatomic) NSString * advanceId;
@property (strong,nonatomic) NSArray * cnName;
@property (strong,nonatomic) NSString * countryName;
@property (strong,nonatomic) NSString * enName;
@property (strong,nonatomic) NSString * message;
@property (strong,nonatomic) NSString * organization;
@property (strong,nonatomic) NSString * status;
@property (strong,nonatomic) NSString * userIcon;
@property (strong,nonatomic) NSString * workYear;


@end
