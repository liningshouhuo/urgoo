//
//  UGLiveCollectionViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveCollectionViewCell.h"
#import "Masonry.h"
@interface UGLiveCollectionViewCell()

@property (strong,nonatomic)UIImageView * imageview;
@end
@implementation UGLiveCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self initUI];
    //[self loadURl];
   // _groupArray = [NSMutableArray array];
    //self.backgroundColor = [UIColor yellowColor];
    return self;
    
}

-(void)initUI{
    _imageview = [[UIImageView alloc]init];
    //UIImageView.backgroundColor = [UIColor blueColor];
    //imageview.image= [UIImage imageNamed:@"live_photo1"];
    [self addSubview:_imageview];
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
    
}
-(void)setImageName:(NSString *)imageName{
    
    _imageview.image = [UIImage imageNamed:imageName];
    
    
    
    
    
    
}
@end
