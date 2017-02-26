//
//  AssistantsService.h
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseService.h"

@interface AssistantsService : BaseService

-(NSMutableArray *)getOrderTitlesWithDict:(NSMutableArray *)mArray;

-(NSMutableArray *)getScheduleTitlesWithDict:(NSMutableArray *)mArray;
-(instancetype)getAssistantsWithDict:(NSDictionary *)dict;

@end
