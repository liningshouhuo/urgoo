//
//  HttpClientManager.h
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpClientManager : AFHTTPSessionManager


+ (HttpClientManager*) getInstance;

+ (void)getAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

+ (void)postAsyn:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;


//上传文件
+(void)uploadFilesAsy:(NSString *)url  fileData:(NSData *)data params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;

@end
