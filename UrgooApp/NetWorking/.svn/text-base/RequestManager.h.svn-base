//
//  RequestManager.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^SuccessBlock)(id resultData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^FailedBlock)(NSError *error);




@interface RequestManager : NSObject

+ (RequestManager*)sharedManager;

//获取验证码--注册
+(void)getIdentifyingCodeWithPhoneNum:(NSString *)phoneNum
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;



//注册
+(void)registerWithPhoneNum:(NSString *)phoneNum
                   nickName:(NSString *)nickName
            identifyingCode:(NSString *)identifyingCode
                   password:(NSString *)password
            confirmPassword:(NSString *)confirmPassword
                    success:(SuccessBlock)success
                     failed:(FailedBlock)failed;


//登录
+(void)loginWithPhoneNum:(NSString *)phoneNum
                password:(NSString *)password
                 success:(SuccessBlock)success
                  failed:(FailedBlock)failed;






//获取验证码--修改密码
+(void)identifyingCodeWithPhoneNum:(NSString *)phoneNum
                            success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

//找回密码-确认验证码
+(void)clientFindPasswordWithPhoneNum:(NSString *)phoneNum
                       activationCode:(NSString *)activationCode
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;


//忘记密码-输入新密码-忘记密码
+(void)updatePasswordWithPhoneNum:(NSString *)phonNum
                      password:(NSString *)password
               confirmPassword:(NSString *)confirmPassword
                       success:(SuccessBlock)success
                        failed:(FailedBlock)failed;


//找回密码-输入新密码--修改密码
+(void)updatePasswordWithToken:(NSString *)token
               currentPassword:(NSString *)currentPassword
                      password:(NSString *)password
               confirmPassword:(NSString *)confirmPassword
                       success:(SuccessBlock)success
                        failed:(FailedBlock)failed;




//完善资料
+(void)prefectInformationWithToken:(NSString *)token
                          nickName:(NSString *)nickName
                            gender:(NSString *)gender
                             grade:(NSString *)grade
                            cityId:(NSString *)cityId
                           targetCountry:(NSString *)targetCountry
                           success:(SuccessBlock)success
                            failed:(FailedBlock)failed;



//上传头像
+(void)updateUserIconWithToken:(NSString *)token
                  userIconFile:(NSData *)data
                       success:(SuccessBlock)success
                        failed:(FailedBlock)failed;



//获取家长信息
+(void)selectedParentsInfoWithToken:(NSString *)token
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

//个人资料里面的选择国家
+(void)selectCountryListWithToken:(NSString *)token
                          success:(SuccessBlock)success
                           failed:(FailedBlock)failed;



//获取城市列表
+(void)getCityListWithToken:(NSString *)token
                    success:(SuccessBlock)success
                     failed:(FailedBlock)failed;




@end
