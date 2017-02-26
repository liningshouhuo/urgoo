//
//  UILabel+Ext.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UILabel+Ext.h"

@implementation UILabel (Ext)

-(void)changLableTextColorFromNote:(NSString *)note text:(NSString *)string colorLength:(NSInteger)Length color:(UIColor *)color
{
    self.text = string;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
    NSRange range = NSMakeRange([[noteStr string] rangeOfString:note].location+1, Length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self setAttributedText:noteStr] ;

}

-(void)changLableTextColorToNote:(NSString *)note text:(NSString *)string colorLength:(NSInteger)Length color:(UIColor *)color
{
    self.text = string;
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
    NSRange range = NSMakeRange([[noteStr string] rangeOfString:note].location-Length+1,Length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [self setAttributedText:noteStr] ;
}


-(void)heightForLableText:(NSString *)string fontOfSize:(CGFloat)size frame:(CGRect)frame
{
    self.numberOfLines = 0;
    UIFont * font = [UIFont systemFontOfSize:size];
    self.font = font;
    self.lineBreakMode =NSLineBreakByTruncatingTail ;
    self.text = string ;
    
    CGSize size2 =CGSizeMake(frame.size.width,10000);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  actualsize2 =[string boundingRectWithSize:size2 options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    
    //更新UILabel的frame
    self.frame = CGRectMake(frame.origin.x, self.frame.origin.y+self.frame.size.height, actualsize2.width, actualsize2.height);
}
-(CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
        
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}  context:nil];
    return rect.size.height;
    
    
    
}
@end
