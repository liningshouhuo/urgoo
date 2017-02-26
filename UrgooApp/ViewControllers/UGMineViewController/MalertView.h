//
//  MalertView.h
//  GsAnimation
//
//  Created by MX007 on 16/7/18.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectBlock)(NSInteger index);

@class MalertView;

@protocol MalertItemSelectDelegate <NSObject>

- (void)malertItemSelect:(NSInteger)index;

@end

@interface MalertView : UIView

@property (nonatomic,assign) id<MalertItemSelectDelegate> delegate;
@property (nonatomic,strong) SelectBlock selectBlock;

@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,strong) UIView *contentViewLeft;
@property (nonatomic,strong) UIView *contentViewRight;


@property (nonatomic,strong) UIView *bottomView;

@property (nonatomic,strong) UIButton *bottomBtn;
@property (nonatomic,strong) UIImageView *exitImgvi;

@property (nonatomic,strong) UIButton *bottomLeftBtn;
@property (nonatomic,strong) UIButton *bottomRightBtn;
@property (nonatomic,strong) UILabel *centerLine;
@property (nonatomic,strong) UIImageView *leftImgvi;
@property (nonatomic,strong) UIImageView *rightImgvi;


@property (nonatomic,assign) BOOL isLeft;

- (instancetype)initWithImageArrOfButton:(NSArray *)imgArr;
- (void)showAlert;

@end
