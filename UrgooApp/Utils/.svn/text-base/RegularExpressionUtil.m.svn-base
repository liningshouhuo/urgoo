//
//  RegularExpressionUtil.m
//  UrgooApp
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "RegularExpressionUtil.h"

@implementation RegularExpressionUtil

/**
 * 功能：校验手机号码
 */
+(BOOL)validateMobile:(NSString *)mobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181,177
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|70|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,183,184,178
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|78|8[2-478])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186,176
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|76|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189,177
     22         */
    NSString * CT = @"^1((33|53|77|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumber] == YES)
        || ([regextestcm evaluateWithObject:mobileNumber] == YES)
        || ([regextestct evaluateWithObject:mobileNumber] == YES)
        || ([regextestcu evaluateWithObject:mobileNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
