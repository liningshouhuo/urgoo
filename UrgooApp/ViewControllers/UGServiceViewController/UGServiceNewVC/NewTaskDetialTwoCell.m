//
//  NewTaskDetialTwoCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewTaskDetialTwoCell.h"
#import "NewTaskDetialCommentCell.h"

@implementation NewTaskDetialTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return self;
}

-(void)initUI:(NSArray *)commentArr
{
    _commentArr = [NSMutableArray arrayWithArray:commentArr];
    
    _backGroundV = [[UIView alloc] init];
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, 290);
    _backGroundV.backgroundColor = [UIColor whiteColor];
    _backGroundV.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.contentView addSubview:_backGroundV];
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(30, 15, kScreenWidth-30*2, 30);
    _title.text = @"动态";
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    _title.font = [UIFont systemFontOfSize:16];
    [_backGroundV addSubview:_title];
    
    [self addTableView:commentArr];
    
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, self.tableView.bottom);
    CGRect frame = self.frame;
    frame.size.height =  self.tableView.bottom ;
    self.frame = frame;
    
}

-(UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, _title.bottom-5, kScreenWidth-40, 400);
        _tableView = [[UITableView alloc] initWithFrame:frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        return _tableView;
    }
    return _tableView;
}

-(void)addTableView:(NSArray *)array
{
    [_backGroundV addSubview:self.tableView];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    
    if ([User_Default objectForKey:@"downUpDataT"]) {
        if (array.count > 0) {
            [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        }
    }
    
    /*
    typeof(self) weakSelf = self;
    _number = 0;
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.number += 1;
        weakSelf.addDataBlock([NSString stringWithFormat:@"%d",weakSelf.number]);
        [User_Default setObject:@"downUpDataT" forKey:@"downUpDataT"];
        [User_Default synchronize];
    }];
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [User_Default removeObjectForKey:@"downUpDataT"];
        weakSelf.number = 0;
        weakSelf.addDataBlock([NSString stringWithFormat:@"%d",weakSelf.number]);
    }];
     */
}



#pragma  mark - UITableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //self.countNum = _commentArray.count;
    return  _commentArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTaskDetialCommentCell *cell = (NewTaskDetialCommentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cell";
    
    NewTaskDetialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[NewTaskDetialCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    NSArray *subViews = cell.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    _commentModel = _commentArr[indexPath.row];
    if (_commentModel) {
        [cell initUI:_commentModel];
    }
    
    
    
    return  cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
