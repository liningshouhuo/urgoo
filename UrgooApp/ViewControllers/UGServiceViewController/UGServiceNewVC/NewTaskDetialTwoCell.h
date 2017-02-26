//
//  NewTaskDetialTwoCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTaskCommentModel.h"

typedef void(^ScrollBlock)(CGFloat scroll,BOOL isTop);
typedef void(^AddDataBlock)(NSString *number);

@interface NewTaskDetialTwoCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backGroundV;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) NSArray *commentArr;
@property (nonatomic, assign) int       number;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ScrollBlock scrollBlock;
@property (nonatomic,strong) AddDataBlock addDataBlock;
@property (nonatomic,strong) NewTaskCommentModel *commentModel;

-(void)initUI:(NSArray *)commentArr;

@end
