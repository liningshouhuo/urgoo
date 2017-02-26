//
//  StringHelper.h
//  UrgooApp
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringHelper : NSString
//动态 计算行高
+ (CGFloat)textHeightFromTextString:(NSString *)text
                              width:(CGFloat)textWidth
                           fontSize:(CGFloat)size;

//通过状态码来修改顾问的性别
+(NSString *)genderStrByNumStr:(NSString *)numStr;
//通过性别修改状态
+(NSString *)genderNumByGenderStr:(NSString *)genderStr;


//通过国家显示状态
+(NSString *)countryStrByNumStr:(NSString *)numStr;

//通过状态显示国家
+(NSString *)countryNumByCountryStr:(NSString *)countryStr;
//判断头像图像是否拼接
+(BOOL)isUserIconContainHttp:(NSString *)userIcon;


//计算字符串的Size
+ (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font;
@end
