//
//  MesgAccountModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/5/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface MesgAccountModel : BaseModel

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *informationId;
@property(nonatomic,copy)NSString *insertDatetime;
@property(nonatomic,copy)NSString *targetId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *unread;
@property(nonatomic,copy)NSString *typeName;

@end
