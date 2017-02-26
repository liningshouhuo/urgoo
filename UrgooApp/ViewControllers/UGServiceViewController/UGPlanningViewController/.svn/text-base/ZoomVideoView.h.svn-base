//
//  ZoomVideoView.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomVideoModel.h"

typedef void(^RejectBlock)();
typedef void(^AcceptBlock)();

@interface ZoomVideoView : UIView

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,strong) UIImageView *heardImageV;
@property (nonatomic,strong) UILabel     *name;
@property (nonatomic,strong) UIButton    *rejectButn;
@property (nonatomic,strong) UIButton    *acceptButn;
@property (nonatomic,strong) RejectBlock rejectBlock;
@property (nonatomic,strong) AcceptBlock acceptBlock;

-(void)initUIData:(ZoomVideoModel *)model;

@end
