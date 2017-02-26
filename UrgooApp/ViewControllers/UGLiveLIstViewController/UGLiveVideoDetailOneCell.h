//
//  UGLiveVideoDetailOneCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"
#import "LiveVideoModel.h"

typedef void(^AdvanceBlock)();

@interface UGLiveVideoDetailOneCell : UITableViewCell

@property (nonatomic, strong) UIView  *backGroundView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *aspect;
@property (nonatomic, assign) CGFloat hightOne;
@property (nonatomic, strong) UIButton *advanceButn;

@property (nonatomic,strong)  AdvanceBlock advanceBlock;

-(void)initUI:(LiveVideoModel *)model;

@end
