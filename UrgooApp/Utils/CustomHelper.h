//
//  CustomHelper.h
//  UrgooApp
//
//  Created by admin on 16/4/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomHelper : NSObject

//是否联网
+(BOOL)isNetWorking;

//验证手机
+ (BOOL)checkTelNumber:(NSString *) telNumber;
//密码是字母数字和下划线  "[a-zA-Z_0-9]+";
+ (BOOL) validPassword:(NSString *)password;

@end
