//
//  HttpClientManager.m
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "HttpClientManager.h"

@implementation HttpClientManager


+ (HttpClientManager*) getInstance{
    
    static HttpClientManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc]init];
    });
    return instance;
}



- (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure

{
    
//     AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    
//    manager.requestSerializer.timeoutInterval = 15;
    self.requestSerializer.timeoutInterval = 30;
    [self GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
            NSLog(@"kToken是否过期：%@ ？602",responseObject[@"header"][@"code"]);
            if ([responseObject[@"header"][@"code"] isEqualToString:@"602"]) {
                [SVProgressHUD showErrorWithStatus:responseObject[@"header"][@"message"]];
                [[AppDelegate sharedappDelegate] showLoginOut];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
   
    // 1.创建请求管理者
    /**AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];**/
}

- (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
     self.requestSerializer.timeoutInterval = 30;
    [self POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ((success)) {
            success(responseObject);
            
            NSLog(@"kToken是否过期：%@ ？602",responseObject[@"header"][@"code"]);
            if ([responseObject[@"header"][@"code"] isEqualToString:@"602"]) {
                [SVProgressHUD showErrorWithStatus:responseObject[@"header"][@"message"]];
                [[AppDelegate sharedappDelegate] showLoginOut];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    // 1.创建请求管理者
   /** AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];**/
}



+(void)getAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    
    [[self getInstance] get:url params:params success:success failure:failure ];
    
}

+(void)postAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    [[self getInstance] post:url params:params success:success failure:failure];
}



-(void)uploadFiles:(NSString *)url  fileData:(NSData *)data params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
      AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
           //AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        if (data) {
            
            // 可以在上传时使用当前的系统时间作为文件名
                        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    // 设置时间格式
                       formatter.dateFormat = @"yyyyMMddHHmmss";
                       NSString *str = [formatter stringFromDate:[NSDate date]];
                      NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            
            //上传头像
            //            [formData appendPartWithFileData:data name:@"userIconFile" fileName:@".png" mimeType:@"image/png"];
            
            //            //上传头像
            //[formData appendPartWithFileData:data name:@"userIconFile" fileName:@"jpg" mimeType:@"image/jpg"];
            [formData appendPartWithFileData:data name:@"userIconFile" fileName:fileName mimeType:@"image/jpg"];
            //上传头像
            //            [formData appendPartWithFileData:data name:@"userIconFile" fileName:@"jpg" mimeType:@"image/jpg"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            
            
            DLog(@"上传头像成功");
            //成功回调
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            DLog(@"上传头像失败");
            //失败回调
            failure(error);
        }
    }];
    
}

+(void)uploadFilesAsy:(NSString *)url  fileData:(NSData *)data params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure{
    
    
    [[self getInstance] uploadFiles:url fileData:data params:params success:success failure:failure];
}




@end
