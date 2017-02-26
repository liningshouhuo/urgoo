//
//  UGLiveVideoDetailThreeCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideoDetailThreeCell.h"

@implementation UGLiveVideoDetailThreeCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return  self;
}

-(void)initUI:(NSArray *)commentArray
{
    _hightOne = 0;
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, 180);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [self.contentView addSubview:_backGroundView];
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(20, 10, _backGroundView.width-60, 16);
    _title.font = [UIFont systemFontOfSize:16];
    _title.text = @"评论:";
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:_title];
    
    _commentArray = [NSArray array];
    _commentArray = commentArray;
    if (_commentArray.count == 0) {
        
        UILabel *note = [[UILabel alloc] init];
        note.frame = CGRectMake(20, _backGroundView.centerY, _backGroundView.width-60, 15);
        note.font = [UIFont systemFontOfSize:12];
        note.text = @"快来第一个评论吧~";
        note.textAlignment = NSTextAlignmentCenter;
        note.textColor = [UIColor colorWithHexString:@"cccccc"];
        [_backGroundView addSubview:note];
        
        _hightOne = note.bottom * 2 - 44;
        
    }else{
       /*
        CGFloat heightt ;
        for (int i = 0; i < commentArr.count; i ++) {
            
            NSString *str = [NSString stringWithFormat:@"%@",commentArr[i]];
            UILabel *comment = [[UILabel alloc] init];
            comment.frame = CGRectMake(20, _title.bottom+5+heightt, _backGroundView.width-60, 15);
            comment.font = [UIFont systemFontOfSize:12];
            comment.textAlignment = NSTextAlignmentCenter;
            [comment heightForLableText:str fontOfSize:12 frame:comment.frame];
            //[comment changLableTextColorToNote:@"：" text:str colorLength:4 color:[UIColor colorWithHexString:@"666666"]];
            comment.textColor = [UIColor colorWithHexString:@"999999"];
            heightt += comment.height+10;
            [_backGroundView addSubview:comment];
        
        }
        */
        _hightOne = 200;
        [self addTableView:commentArray];
        
        
    }
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _hightOne + 20, kScreenWidth, 0.6);
    line.backgroundColor = [UIColor clearColor];
    [_backGroundView addSubview:line];
    
    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, line.bottom );
    CGRect frame = self.frame;
    frame.size.height =  line.bottom + 30;
    self.frame = frame;
        
}

-(UITableView *)tableView
{
    if (!_tableView) {
        CGRect frame = CGRectMake(0, _title.bottom, kScreenWidth, _hightOne + 15);
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return _tableView;
    }
    return _tableView;
}

-(void)addTableView:(NSArray *)array
{
    
   
    [_backGroundView addSubview:self.tableView];
    [self.tableView footerEndRefreshing];
    [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    
    if ([User_Default objectForKey:@"downUpData"]) {
        if (array.count > 0) {
            //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:array.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            [_tableView setContentOffset:CGPointMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        }
    }
    
    typeof(self) weakSelf = self;
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.number += 1;
        weakSelf.addDataBlock([NSString stringWithFormat:@"%d",weakSelf.number]);
        [User_Default setObject:@"downUpData" forKey:@"downUpData"];
        [User_Default synchronize];
    }];
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [User_Default removeObjectForKey:@"downUpData"];
        weakSelf.number = 0;
        weakSelf.addDataBlock([NSString stringWithFormat:@"%d",weakSelf.number]);
    }];
}

#pragma  mark - UITableViewdelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.countNum = _commentArray.count;
    return  _commentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoDetailCommentCell *cell = (VideoDetailCommentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indentifer = @"cell";
   
    VideoDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifer];
    if (cell == nil) {
        cell = [[VideoDetailCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifer];
    }
    
    NSArray *subViews = cell.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    _liveVideoCommentModel = _commentArray[indexPath.row];
    
    if (_liveVideoCommentModel) {
       [cell initUI:_liveVideoCommentModel];
    }
    
    return  cell; 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    //每组尾部视图的高度
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame = CGRectMake(0, 0, kScreenWidth, 20);
    
    UILabel *note = [[UILabel alloc] init];
    note.frame = CGRectMake(0, 0, kScreenWidth, 20);
    if ([User_Default objectForKey:@"downUpData"] && self.countNum == _commentArray.count) {
       note.text  = @"只有那么多了哦";
    }else
    note.text  = @"向上滑动加载更多^_^";
    note.font = [UIFont systemFontOfSize:11];
    note.textColor = [UIColor colorWithHexString:@"999999"];
    note.textAlignment = NSTextAlignmentCenter;
    [view addSubview:note];
    
    return view;
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
