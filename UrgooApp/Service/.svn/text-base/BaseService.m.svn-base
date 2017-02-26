//
//  BaseService.m
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseService.h"
#import "MsgModel.h"

@implementation BaseService

-(instancetype)getHeaderMsgWithDict:(NSDictionary *)dict{
    
    MsgModel *model=[[MsgModel alloc] init];
    model.code=dict[@"code"];
    model.message =dict[@"message"];
    model.serverTime=dict[@"serverTime"];
    return model;

}
@end
