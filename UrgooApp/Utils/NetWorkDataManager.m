//
//  NetWorkDataManager.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/9/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NetWorkDataManager.h"

//极光推送
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>


@implementation NetWorkDataManager

#pragma mark - 退出登录
+(void)isLognOut
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //退出登录后清除token
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //退出登录后清除订单信息
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //退出登录后 去除 极光推送
            [JPUSHService setAlias:@"" callbackSelector:nil object:self];
            
            if (!error) {
                DLog(@"退出成功");
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
            //推出登陆，切换到登录页面
            [[AppDelegate sharedappDelegate] showNewLong];
        });
    });
}

#pragma mark - tabBar红点
+(void)isTabBarRedDot:(void (^)(BOOL))Result
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"termType"] = @"2";
    
    [HttpClientManager postAsyn:UG_informationCount_URL params:params success:^(id json) {
        if (json) {
            DLog(@"是否有‘消息&预约’数据:%@",json);
            
            AssistantsService *service=[[AssistantsService alloc] init];
            MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]) {
                
                //Tabbar
                NSString *allCount = [NSString stringWithFormat:@"%@",json[@"body"][@"allCount"]];
                if (![allCount isEqualToString:@"0"]) {
                    Result(YES);
                }else{
                    Result(NO);
                }
                
            }
            
        }
    } failure:^(NSError *error) {
        DLog(@"出错：%@",error);
    }];

}

@end
