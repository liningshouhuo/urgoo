//
//  NetWorkDataManager.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/9/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkDataManager : NSObject

+(void)isLognOut;

+(void)isTabBarRedDot:(void(^)(BOOL isShowRed))Result;

@end
