//
//  StringHelper.m
//  UrgooApp
//
//  Created by admin on 16/3/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper
//动态 计算行高
+ (CGFloat)textHeightFromTextString:(NSString *)text
                              width:(CGFloat)textWidth
                           fontSize:(CGFloat)size{
    if (iOS >= 7.0) {
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        CGRect rect = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        //返回计算出的行高
        return rect.size.height;
    }
    return 100;
}





//通过状态码来修改顾问的性别
+(NSString *)genderStrByNumStr:(NSString *)numStr{
    if ([numStr isEqualToString:@"1"]) {
        return @"男";
    }else if ([numStr isEqualToString:@"2"]){
        return @"女";
    }
    return @"男";
}
//通过性别修改状态
+(NSString *)genderNumByGenderStr:(NSString *)genderStr{
    if ([genderStr isEqualToString:@"男"]) {
        return @"1";
    }else if ([genderStr isEqualToString:@"女"]){
        return @"2";
    }return @"1";
}


//[@"China",@"USA",@"UK",@"Austrica",@"Japan",@"Canada",@"Others"]
//通过国家显示状态
+(NSString *)countryStrByNumStr:(NSString *)numStr{
    if ([numStr isEqualToString:@"1"]) {
        return @"美国";
    }else if ([numStr isEqualToString:@"2"]){
        return @"中国";
    }else if ([numStr isEqualToString:@"3"]){
        return @"英国";
    }else if ([numStr isEqualToString:@"4"]){
        return @"澳大利亚";
    }else if ([numStr isEqualToString:@"5"]){
        return @"日本";
    }else if ([numStr isEqualToString:@"6"]){
        return @"加拿大";
    }else if ([numStr isEqualToString:@"7"]){
        return @"其他";
    }
    return @"中国";
}

//通过状态显示国家
+(NSString *)countryNumByCountryStr:(NSString *)countryStr{
    if ([countryStr isEqualToString:@"美国"]) {
        return @"1";
    }else if ([countryStr isEqualToString:@"中国"]){
        return @"2";
    }else if ([countryStr isEqualToString:@"英国"]){
        return @"3";
    }else if ([countryStr isEqualToString:@"澳大利亚"]){
        return @"4";
    }else if ([countryStr isEqualToString:@"日本"]){
        return @"5";
    }else if ([countryStr isEqualToString:@"加拿大"]){
        return @"6";
    }else if ([countryStr isEqualToString:@"其他"]){
        return @"7";
    }return @"1";
}

//判断头像图像是否拼接
+(BOOL)isUserIconContainHttp:(NSString *)userIcon{
    
    
    NSString *str = @"qingdao";
    NSRange rang = [userIcon rangeOfString:str];
    if (rang.location != NSNotFound) {
        return YES;
    }else{
        return NO;
    }
    
    return 1;
}
//计算字符串的Size
+ (CGSize)getSizeByString:(NSString*)string AndFontSize:(CGFloat)font
{
    CGSize size = [string boundingRectWithSize:CGSizeMake(999, 25) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    size.width += 5;
    return size;
}


@end
