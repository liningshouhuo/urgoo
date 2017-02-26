//
//  UGLiveVideoDetailTwoCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AllBlock)();
typedef void(^OneBlock)(NSString *number);

@interface UGLiveVideoDetailTwoCell : UITableViewCell

@property (nonatomic,strong) UIView   *backGroundView;
@property (nonatomic,strong) UILabel  *title;
@property (nonatomic,strong) UIButton *allButn;
@property (nonatomic,assign) CGFloat   hightOne;

@property (nonatomic,strong) AllBlock  allBlock;
@property (nonatomic,strong) OneBlock  oneBlock;

-(void)initUI:(NSArray *)imageArr;

@end
