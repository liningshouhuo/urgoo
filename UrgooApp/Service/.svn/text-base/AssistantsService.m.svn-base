//
//  AssistantsService.m
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "AssistantsService.h"
#import "AssistantsModel.h"

#import "MJExtension.h"

@implementation AssistantsService






-(instancetype)getAssistantsWithDict:(NSDictionary *)dict{
    
    AssistantsModel * model =[[AssistantsModel alloc]init];
    model.cnName = dict[@"cnName"];
    model.taskSituation = dict[@"taskSituation"];
    model.enName = dict[@"enName"];
    model.planSituation = dict[@"planSituation"];
    model.status = dict[@"status"];
    
    return model;
}

-(NSMutableArray *)getOrderTitlesWithDict:(NSMutableArray *)mArray{
    
    NSMutableArray  *orderTitleArrays=[NSMutableArray array];
    
    for (NSDictionary *dic in mArray) {
        //[dic objectForKey:@"timeDate"];
        
        //enStatus
        NSString *parentName=[[dic objectForKey:@"enName"] stringByAppendingString:@"   "];
        NSString *enStatus=[dic objectForKey:@"enStatus"];
        //NSString *parentName2=[parentName stringByAppendingString:@"\n"];
        
        NSString *title=[parentName stringByAppendingString:enStatus];
        
        [orderTitleArrays addObject:title];
        //[dic objectForKey:@"scheduleContent"];
        //[titleArrays ]
    }
    
    //NSArray *orderModel = [OrderModel objectArrayWithKeyValuesArray:resultData[@"body"][@"adviserOrderList"]];
    
    //NSArray *orderdataArray = [OrderModel objectArrayWithKeyValuesArray:mArray];
    
    /**for (NSDictionary *dic in orderdataArray) {
      
        NSString *parentName=[[dic objectForKey:@"enName"] stringByAppendingString:@"   "];
        NSString *enStatus=[dic objectForKey:@"enStatus"];
        NSString *title=[parentName stringByAppendingString:enStatus];
        [orderTitleArrays addObject:title];
     
    }**/
    return orderTitleArrays;
}


-(NSMutableArray *)getScheduleTitlesWithDict:(NSMutableArray *)mArray{
    
    NSMutableArray  *ScheduleTitleArrays=[NSMutableArray array];
    for (NSDictionary *dic in mArray) {
     
        [ScheduleTitleArrays addObject:[dic objectForKey:@"timeDate"]];
    }

    return ScheduleTitleArrays;
}

@end
