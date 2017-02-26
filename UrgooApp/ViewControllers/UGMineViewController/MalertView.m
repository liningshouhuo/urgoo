//
//  MalertView.m
//  GsAnimation
//
//  Created by MX007 on 16/7/18.
//  Copyright © 2016年 zhangfaxing. All rights reserved.
//

#import "MalertView.h"

#define WidthDis  [UIScreen mainScreen].bounds.size.width
#define HeightDis [UIScreen mainScreen].bounds.size.height

#define marginX 50 //左右边距
#define marginY 50 //上下间距
#define RowDis     25 //水平间距

#define itemW   (WidthDis-2*RowDis-marginX*2)/3.0
#define itemH   (WidthDis-2*RowDis-marginX*2)/3.0+30

#define itemY   HeightDis-230  //最上面item的y坐标  Height/2-50
#define distance 400

@implementation MalertView


- (instancetype)initWithImageArrOfButton:(NSArray *)imgArr
{
    self = [super initWithFrame:CGRectMake(0, 0, WidthDis, HeightDis)];
    
    if (self) {
    
        
        //模糊效果
        //UIBlurEffect *light = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        //_bgView = [[UIVisualEffectView alloc]initWithEffect:light];
        //_bgView.frame = self.bounds;
        //[self addSubview:_bgView];
        
        _bgView = [[UIView alloc] init];
        _bgView.frame = self.frame;
        _bgView.backgroundColor = [UIColor colorWithRed:0/225.f green:0/225.f blue:0/225.f alpha:0.5];
        [self addSubview:_bgView];
        
        
        _isLeft = YES;
        
        //左边的view
        _contentViewLeft = [[UIView alloc] initWithFrame:self.frame];
        [_bgView addSubview:_contentViewLeft];
        
        
        
            for (int i =0; i<imgArr.count; i++) {
                
                UIView *item = [[UIView alloc] init];
                item.frame = CGRectMake(marginX +(RowDis+itemW)*(i%3), itemY+(itemH+marginY)*(i/3)+distance, itemW, itemH);
                item.backgroundColor = [UIColor clearColor];
                item.tag = 100+i;
                [_contentViewLeft addSubview:item];
                
                
                UIImageView *imgvi = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgArr[i]]];
                imgvi.frame = CGRectMake(0, 0, itemW, itemW);
                imgvi.layer.cornerRadius = itemW/2;
                imgvi.backgroundColor = [UIColor clearColor];
                [item addSubview:imgvi];
                
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, itemW+9, itemW, 21)];
                lable.text = @"图片／视频";
                lable.font = [UIFont systemFontOfSize:14.0];
                lable.textAlignment = NSTextAlignmentCenter;
                lable.textColor = [UIColor darkGrayColor];
                //[item addSubview:lable];
                
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = item.bounds;
                button.tag = 110+i;
                [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [item addSubview:button];
            }

        
        
    

        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(WidthDis/2-24, HeightDis-100, 48, 48)];
        _bottomView.backgroundColor = [UIColor clearColor];
        [_bgView addSubview:_bottomView];
        
        
        
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _bottomBtn.frame = _bottomView.bounds;
        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"share_closed_icon"] forState:UIControlStateNormal];
        [_bottomBtn addTarget:self action:@selector(alertDismiss) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_bottomBtn];
        
    }
    return self;
}

- (void)showAlert
{
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _bgView.alpha = 1;
                //_exitImgvi.transform = CGAffineTransformRotate(_exitImgvi.transform, M_PI_4);
                
            } completion:^(BOOL finished) {
                
            }];
        });
    });
    
    
    for (int i=0; i<6; i++) {
        
        dispatch_async(queue, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIView *itemView = [_contentViewLeft viewWithTag:i+100];
                
                    [UIView animateWithDuration:(i+2)/10.0 animations:^{
                        
                        itemView.transform = CGAffineTransformTranslate(itemView.transform, 0, -distance);

                    }completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:0.1 animations:^{

                            itemView.transform = CGAffineTransformTranslate(itemView.transform, 0, 10);
                            
                        }];
                        
                    }];
                    
            });
        });
    }
    
    
}

- (void)alertDismiss
{
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    
    
    dispatch_async(queue1, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.2 animations:^{
                
                _exitImgvi.transform = CGAffineTransformIdentity;
                _rightImgvi.transform = CGAffineTransformIdentity;
                _bottomBtn.alpha = 0;
            }];
        });
    });
    
    for (int i=0; i<6; i++) {
        
        dispatch_async(queue1, ^{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIView *itemView = nil;
                if (_isLeft) {
                    itemView = [_contentViewLeft viewWithTag:i+100];
                }else{
                    itemView = [_contentViewRight viewWithTag:i+10];
                }
                
                if (i<3) {
                    
                    //此处判断i＝0时 在动画时间最长的完成方法中执行隐藏view的操作
                    if (i==0) {
                        
                        [UIView animateWithDuration:(5-i)/10.0 animations:^{
                            
                            itemView.transform = CGAffineTransformIdentity;
                            
                            
                        }completion:^(BOOL finished) {
                            
                            [UIView animateWithDuration:0.2 animations:^{
                                
                                self.alpha = 0;
                                
                            } completion:^(BOOL finished) {
                                
                                self.hidden = YES;
                            }];
                            
                        }];
                        
                    }else {
                        
                        [UIView animateWithDuration:(5-i)/10.0 animations:^{
                            
                            itemView.transform = CGAffineTransformIdentity;
                            
                        }];
                        
                    }
                    
                }else if (i<6) {
                    
                    [UIView animateWithDuration:(6-i)/10.0 animations:^{
                        
                        itemView.transform = CGAffineTransformIdentity;
                        
                    }];
                    
                }
                
            });
        });
    }
    
    
}


- (void)itemButtonClick:(UIButton *)sender
{
//    if (self.delegate) {
//       [self.delegate malertItemSelect:sender.tag];
//    }
    if (_selectBlock) {
        _selectBlock(sender.tag);
    }
    
}

@end
