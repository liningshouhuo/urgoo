//
//  CycleCollectionViewCell.m
//  图片轮播器
//
//  Created by Mac on 16/4/24.
//  Copyright © 2016年 闫龙. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height

@interface CycleCollectionViewCell()

@property (weak, nonatomic) UIImageView *imageView;

@end


@implementation CycleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
   // NSArray * array = @[@"1",@"2",@"3"];
    self.contentView.backgroundColor = [UIColor whiteColor];
//    self.imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH,self.bounds.size.height)];
   // UIImageView * imageView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH,300)];
    _imageView = imageView;
   
    //把UIImageView的contentMode收属性设置为：UIViewContentModeScaleToFill试试。
    _imageView.contentMode = UIViewContentModeScaleToFill;
    
    //self.imageView.frame = CGRectMake(0, 0, kWIDTH,200);
//     _imageView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    [self.contentView addSubview:_imageView];
    return self;
}
-(void)setStr:(NSString *)str{
    _str = str;
    
    NSString *headImgStr= _str;
    
    if ([headImgStr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"4"] ];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,headImgStr];
        
        [self.imageView  sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"4"]  ];
    }
    

    //NSLog(@"%@",_str);
    //[self.imageView sd_setImageWithURL:[NSURL URLWithString:_str] placeholderImage:[UIImage imageNamed:@"mengchong"]];
     _imageView.contentMode = UIViewContentModeScaleToFill;
    //_imageView.tag =  str;
    
}
@end
