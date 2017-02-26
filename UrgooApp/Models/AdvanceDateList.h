//
//  AdvanceDateList.h
//  UrgooApp
//
//  Created by UrgooDev on 16/6/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface AdvanceDateList : BaseModel
@property (strong,nonatomic) NSString * advanceDate;
@property (strong,nonatomic) NSString * date;
@property (strong,nonatomic) NSArray * timeList;
@property (strong,nonatomic) NSString * weekName;
@property (strong,nonatomic) NSString * busyDay;
@end
