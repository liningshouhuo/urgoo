//
//  PayOrderDtlModel.h
//  UrgooApp
//
//  Created by UrgooDev on 16/6/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface PayOrderDtlModel : BaseModel
@property(nonatomic,copy)NSString *orderCode;

@property(nonatomic,copy)NSString *depositStatus;
@property(nonatomic,copy)NSString *serviceNameLong;
@property(nonatomic,copy)NSString *orderDeposit;
@property(nonatomic,copy)NSString *workYear;
@property(nonatomic,copy)NSString *balancePrice;
@property(nonatomic,copy)NSString *payRequestOrderId;
@property(nonatomic,copy)NSString *priceTotal;
@property(nonatomic,copy)NSString *priceed;
@property(nonatomic,copy)NSString *serviceName;
@end
