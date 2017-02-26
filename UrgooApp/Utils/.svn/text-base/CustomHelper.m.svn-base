//
//  CustomHelper.m
//  UrgooApp
//
//  Created by admin on 16/4/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "CustomHelper.h"

@implementation CustomHelper

+(BOOL)isNetWorking
{
//    ReachabilityStatus status = [GLobalRealReachability currentReachabilityStatus];
//    if (status == RealStatusNotReachable)
//    {
//        DLog(@"网络不可用");
//        return NO;
//    }
//    
//    if (status == RealStatusViaWiFi)
//    {
//        DLog(@"网络WiFi");
//
//        return YES;
//    }
//    
//    if (status == RealStatusViaWWAN)
//    {
//        DLog(@"网络WWAN");
//
//        return YES;
//    }
    return YES;

}
//密码 "[a-zA-Z_0-9]+"
+(BOOL)validPassword:(NSString *)password{
    NSString *passwordRegex = @"[a-zA-Z_0-9]{6,18}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
//    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:password];
//    return isMatch;
}

/*手机号验证 MODIFIED BY HELENSONG*/
 + (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


@end
