////
////  RequestManager.m
////  UrgooApp
////
////  Created by LuoYiJia on 16/3/24.
////  Copyright © 2016年 Urgoo. All rights reserved.
////
//
#import "RequestManager.h"
//
//
@implementation RequestManager
@end
//
//+(RequestManager *)sharedManager{
//    static RequestManager *instance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        instance = [[self alloc]init];
//    });
//    return instance;
//}
//
//-(void)getDataWithGetType:(NSString *)url
//             successBlock:(SuccessBlock)success
//             failureBlock:(FailedBlock)failure{
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//#ifdef DEBUG
//    NSLog(@"GET url:\n%@",url);
//#endif
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (success) {
//#ifdef DEBUG
//            NSLog(@"successed response:\n%@",responseObject);
//#endif
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//#ifdef DEBUG
//            NSLog(@"failed error:\n%@",error.localizedDescription);
//#endif
//            failure(error);
//        }
//    }];
//}
//
//-(void)postDataByUrl:(NSString *)url
//        byDictionary:(NSDictionary *)dictionary
//        successBlock:(SuccessBlock)success
//        failureBlock:(FailedBlock)failure{
//    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager manager] initWithBaseURL:[NSURL URLWithString:UG_HOST]];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//     manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
//    [manager.requestSerializer setTimeoutInterval:10];
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"",@"", nil];
//    [params addEntriesFromDictionary:dictionary];
//#ifdef DEBUG
//    NSLog(@"POST url:\n%@\nparameters:\n%@",url,params );
//#endif
//    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//#ifdef DEBUG
//        NSLog(@"successed response:\n%@",responseObject);
//#endif
//        if (success) {
//            success(responseObject);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//#ifdef DEBUG
//        NSLog(@"failed response:\n%@",error.description);
//#endif
//        if (failure) {
//            failure(error);
//        }
//    }];
//}
//
////获取验证码
//+(void)getIdentifyingCodeWithPhoneNum:(NSString *)phoneNum
//                              success:(SuccessBlock)success
//                               failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"phoneNum":phoneNum};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_GET_IDENTIFYING_CODE byDictionary:params successBlock:success failureBlock:failed];
//}
//
////http://115.28.50.163:8080/urgoo/001/001/login/identifyingCode?phoneNum=18272194089
//
////注册
//+(void)registerWithPhoneNum:(NSString *)phoneNum
//                   nickName:(NSString *)nickName
//            identifyingCode:(NSString *)identifyingCode
//                   password:(NSString *)password
//            confirmPassword:(NSString *)confirmPassword
//                    success:(SuccessBlock)success
//                     failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"phoneNum":phoneNum,
//                             @"nickName":nickName,
//                             @"identifyingCode":identifyingCode,
//                             @"password":password,
//                             @"confirmPassword":confirmPassword};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_CLINTREGIST byDictionary:params successBlock:success failureBlock:failed];
//}
////http://115.28.50.163:8080/urgoo/001/001/login/clientRegist?phoneNum=18272194089&nickName=www&identifyingCode=0262&password=123123&confirmPassword=123123
//
//
//
////登陆
//+(void)loginWithPhoneNum:(NSString *)phoneNum
//                 password:(NSString *)password
//                  success:(SuccessBlock)success
//                   failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"username":phoneNum,
//                             @"password":password};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_COUNT byDictionary:params successBlock:success failureBlock:failed];
//}
//
////http://115.28.50.163:8080/urgoo/001/001/login/clientLogin?username=13701682131&password=ccc
//
//
//
//
//
//
////获取验证码--修改密码
//+(void)identifyingCodeWithPhoneNum:(NSString *)phoneNum
//                              success:(SuccessBlock)success
//                               failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"phoneNum":phoneNum};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_IDENTIFYING_CODE byDictionary:params successBlock:success failureBlock:failed];
//}
//
//
//
////找回密码-输入验证码
////http://www.chenruixuan.com/archives/1078.html
////add201604051701
//+(void)clientFindPasswordWithPhoneNum:(NSString *)phoneNum
//                       activationCode:(NSString *)activationCode
//                              success:(SuccessBlock)success
//                               failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"phoneNum":phoneNum,
//                             @"activationCode":activationCode};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_CLIENT_FIND_PASSWORD byDictionary:params successBlock:success failureBlock:failed];
//}
//
////http://115.28.50.163:8080/urgoo/001/001/login/clientFindPassword?phoneNum=18272194089&activationCode=6873
//
////忘记密码-输入新密码-忘记密码
//+(void)updatePasswordWithPhoneNum:(NSString *)phonNum
//                         password:(NSString *)password
//                  confirmPassword:(NSString *)confirmPassword
//                          success:(SuccessBlock)success
//                           failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"phoneNum":phonNum,
//                             @"password":password,
//                             @"confirmPassword":confirmPassword};
//    [[self sharedManager]postDataByUrl:UG_LOGIN_UPDATE_PASSWORD byDictionary:params successBlock:success failureBlock:failed];
//
//}
//
//
////http://115.28.50.163:8080/urgoo/001/001/login/updatePassword?phoneNum=18272194089&password=aaa&confirmPassword=aaa
//
//
//
////找回密码-输入新密码-修改密码
//+(void)updatePasswordWithToken:(NSString *)token
//               currentPassword:(NSString *)currentPassword
//                      password:(NSString *)password
//               confirmPassword:(NSString *)confirmPassword
//                       success:(SuccessBlock)success
//                        failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token,
//                             @"currentPassword":currentPassword,
//                             @"password":password,
//                      @"confirmPassword":confirmPassword};
//    [[self sharedManager]postDataByUrl:UG_USER_UPDATE_PASSWORD byDictionary:params successBlock:success failureBlock:failed];
//}
////http://115.28.50.163:8080/urgoo/001/001/login/clientFindPassword?phoneNum=18272194089&userActivationCode=4538
//
//
////完善资料
//+(void)prefectInformationWithToken:(NSString *)token
//                          nickName:(NSString *)nickName
//                            gender:(NSString *)gender
//                             grade:(NSString *)grade
//                            cityId:(NSString *)cityId
//                     targetCountry:(NSString *)targetCountry
//                           success:(SuccessBlock)success
//                            failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token,
//                             @"nickName":nickName,
//                             @"gender":gender,
//                             @"grade":grade,
//                             @"cityId":cityId,
//                             @"targetCountry":targetCountry};
//    [[self sharedManager]postDataByUrl:UG_USER_PREFECT_INFOMATION byDictionary:params successBlock:success failureBlock:failed];
//}
////http://115.28.50.163:8080/urgoo/001/001/user/perfectInformation?token=fuByJ4SdOEA=&nickName=0262&gender=0262&grade=1&cityId=1&targetCountry=1
//
//
//
////上传头像
//+(void)updateUserIconWithToken:(NSString *)token
//                  userIconFile:(NSData *)data
//                       success:(SuccessBlock)success
//                        failed:(FailedBlock)failed{
//    
//    NSString *url=[NSString stringWithFormat:@"%@",UG_USER_UPDATE_USER_ICON];
//    NSDictionary *params = @{@"token":token,
//                             @"userIconFile":data};
//    
//    
//    
//    //    DLog(@"data----->%@",data);
//    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
//    
//    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        if (data) {
//            
//            // 可以在上传时使用当前的系统时间作为文件名
//            //            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            //            // 设置时间格式
//            //            formatter.dateFormat = @"yyyyMMddHHmmss";
//            //            NSString *str = [formatter stringFromDate:[NSDate date]];
//            //            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
//            
//            
//            //上传头像
//            //            [formData appendPartWithFileData:data name:@"userIconFile" fileName:@".png" mimeType:@"image/png"];
//            
//            //上传头像
//            [formData appendPartWithFileData:data name:@"userIconFile" fileName:@"jpg" mimeType:@"image/jpg"];
//        }
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if (responseObject) {
//            
//            
//            DLog(@"上传头像成功");
//            //成功回调
//            success(responseObject);
//            
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failed) {
//            DLog(@"上传头像失败");
//            //失败回调
//            failed(error);
//        }
//    }];
//    
//}
//
//
//
//
//
//
////展示家长信息
//+(void)selectedParentsInfoWithToken:(NSString *)token
//                              success:(SuccessBlock)success
//                               failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token};
//    [[self sharedManager]postDataByUrl:UG_USER_SELECT_PARENTS_INFO byDictionary:params successBlock:success failureBlock:failed];
//}
//
//
//
////个人资料里面的选择国家
//+(void)selectCountryListWithToken:(NSString *)token
//                          success:(SuccessBlock)success
//                           failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token};
//    [[self sharedManager]postDataByUrl:UG_PROFILE_SELECT_COUNTRY_LIST byDictionary:params successBlock:success failureBlock:failed];
//}
////http://115.28.50.163:8080/urgoo/001/001/profile/selectCountryList?token=fuByJ4SdOEA=
//
//
////获取城市列表
//+(void)getCityListWithToken:(NSString *)token
//                    success:(SuccessBlock)success
//                     failed:(FailedBlock)failed{
//    NSDictionary *params = @{@"token":token};
//    [[self sharedManager]postDataByUrl:UG_CityList_URL byDictionary:params successBlock:success failureBlock:failed];
//}
//
//
//
//
//@end
