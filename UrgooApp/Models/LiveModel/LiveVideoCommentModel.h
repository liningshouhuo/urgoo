//
//  LiveVideoCommentModel.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/20.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseModel.h"

@interface LiveVideoCommentModel : BaseModel

@property (nonatomic, copy) NSString *insertDatetime;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userIcon;
@property (nonatomic, copy) NSString *content;

@end
