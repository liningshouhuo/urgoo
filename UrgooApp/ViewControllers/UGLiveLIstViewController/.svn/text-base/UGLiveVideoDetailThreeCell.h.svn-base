//
//  UGLiveVideoDetailThreeCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailCommentCell.h"
#import "LiveVideoCommentModel.h"

typedef void(^AddDataBlock)(NSString *number);

@interface UGLiveVideoDetailThreeCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView   *backGroundView;
@property (nonatomic,strong) UILabel  *title;
@property (nonatomic,assign) CGFloat   hightOne;
@property (nonatomic,strong) UIButton *commentButn;
@property (nonatomic,strong) UIButton *joinVideo;
@property (nonatomic,assign) int       number;
@property (nonatomic,assign) NSInteger countNum;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray     *commentArray;
@property (nonatomic,strong) LiveVideoCommentModel     *liveVideoCommentModel;
@property (nonatomic,strong) AddDataBlock               addDataBlock;



-(void)initUI:(NSArray *)commentArray;

@end
