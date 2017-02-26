//
//  NewtaskDetialsViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewtaskDetialsViewController.h"
#import "NewTaskDetialOneCell.h"
#import "NewTaskDetialTwoCell.h"
#import "NewTaskInforModel.h"
#import "NewTaskCommentModel.h"
#import "NewTaskDataModel.h"
#import "SeaveTaskHeardView.h"
#import "NewTaskDetialCommentCell.h"

@interface NewtaskDetialsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UIView   *bottomView;
    UIButton *encourageButn;
    
    UIView      *editView;
    UITextField *commentText;
    UIButton    *commentButn;
}

@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) NewTaskDataModel  *taskDataModel;
@property (nonatomic,strong) NewTaskInforModel  *taskInforModel;
@property (nonatomic,strong) NSMutableArray *commentList;
@property (nonatomic,assign) NSInteger       pageNum;
@property (nonatomic,copy)   NSString       *studentId;
@property (nonatomic,strong) SeaveTaskHeardView *seaveTaskHeardView;
@property (nonatomic,strong) NewTaskCommentModel *commentModel;

@end

@implementation NewtaskDetialsViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [commentText resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillChangeFrameNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _pageNum = 0;
    [self getNetData_getTaskDetailByTaskId:@"0"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"任务详情"];
    
    [self initUI];
    
    
    //[self getNetData_taskCommentList:@"0"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Hidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)initUI
{
    _commentList = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-48);
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    typeof(self) weakSelf = self;
    [_tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pageNum += 1;
        [weakSelf getNetData_getTaskDetailByTaskId:[NSString stringWithFormat:@"%ld",weakSelf.pageNum]];
    }];
    
    
    [_tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        weakSelf.pageNum = 0;
        [weakSelf getNetData_getTaskDetailByTaskId:@"0"];
    }];
    
    
    [self kAddEditView];
}

-(void)kaddBottomButn:(BOOL)isEncourage
{
    encourageButn = [UIButton buttonWithType:UIButtonTypeCustom];
    encourageButn.frame = CGRectMake(0, kScreenHeight-64-44, kScreenWidth, 44);
    encourageButn.titleLabel.font = [UIFont systemFontOfSize:15];
    encourageButn.hidden = NO;
    if (!isEncourage) {
        encourageButn.enabled = YES;
        encourageButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        [encourageButn setTitle:@"给孩子句鼓励的话吧" forState:UIControlStateNormal];
    }else{
        encourageButn.enabled = NO;
        encourageButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        [encourageButn setTitle:@"已鼓励" forState:UIControlStateNormal];
    }
    
    [encourageButn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:encourageButn];
}

-(void)clickButton
{
    DLog(@"点击“鼓励”");
    [self kAddEditView];
}

-(void)kAddEditView{
    
    //encourageButn.hidden = YES;
    
    editView = [[UIView alloc] init];
    editView.frame = CGRectMake(0, kScreenHeight-64-50, kScreenWidth, 50);
    editView.hidden = NO;
    editView.layer.borderWidth = 0.6;
    editView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    editView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:editView];
    
    commentText = [[UITextField alloc] init];
    //commentText.frame = CGRectMake(5, 8, kScreenWidth-5-65, 34);
    commentText.frame = CGRectMake(10, 8, kScreenWidth-20, 34);
    commentText.layer.borderWidth = 0.6;
    commentText.placeholder = @"  评论";
    commentText.layer.cornerRadius = 17;
    commentText.layer.borderWidth = 0.6;
    commentText.font = [UIFont systemFontOfSize:13];
    commentText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    commentText.delegate = self;
    commentText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [editView addSubview:commentText];
    
    commentButn = [UIButton buttonWithType:UIButtonTypeCustom];
    commentButn.frame = CGRectMake(commentText.width+10, 8, 55, 34);
    commentButn.titleLabel.font = [UIFont systemFontOfSize:15];
    commentButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    commentButn.layer.cornerRadius = 6;
    commentButn.clipsToBounds = YES;
    commentButn.hidden = YES;
    [commentButn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commentButn setTitle:@"发送" forState:UIControlStateNormal];
    [commentButn addTarget:self action:@selector(clickSend) forControlEvents:UIControlEventTouchUpInside];
    [editView addSubview:commentButn];
    
    //[commentText becomeFirstResponder];
}

-(void)clickSend
{
    [self hiddenKey];
    
    if (commentText.text.length > 0) {
        //[self getNetData_taskReplyComment:commentText.text];
    }else{
        [self showSVString:@"评论内容不能为空！"];
    }
    
    commentText.text = @"";
    commentText.placeholder = @"  评论";
}

-(void)hiddenKey
{
    editView.frame = CGRectMake(0, kScreenHeight-64-50, kScreenWidth, 50);
    commentText.frame = CGRectMake(10, 8, kScreenWidth-20, 34);
    [commentText resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hiddenKey];
    return YES;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self hiddenKey];
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewTaskDetialCommentCell *cell = (NewTaskDetialCommentCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *indenifer = @"cell";
    
    NewTaskDetialCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:indenifer];
    if (cell == nil) {
        cell = [[NewTaskDetialCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indenifer];
    }
    
    NSArray *subViews = cell.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    _commentModel = _commentList[indexPath.row];
    if (_commentModel) {
        [cell initUI:_commentModel];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark -- UG_getTaskDetailByTaskId_URL

-(void)getNetData_getTaskDetailByTaskId:(NSString *)page
{
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"taskId"] = _taskId;
    params[@"page"] = page;

    DLog(@"%@?token=%@&taskId=%@",UG_tasknewTaskDetail_URL,kToken,_taskId);
    
    [HttpClientManager postAsyn:UG_tasknewTaskDetail_URL params:params success:^(id json) {
        
        AssistantsService *service = [[AssistantsService alloc] init];
        MsgModel *msg = (MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            
            
            [NewTaskDataModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"taskComment":@"NewTaskCommentModel",
                         };
            }];
            
            _taskDataModel = [NewTaskDataModel mj_objectWithKeyValues:json[@"body"]];
            
            if (_taskDataModel) {
                
                _studentId = _taskInforModel.studentId;
                _taskInforModel = _taskDataModel.taskDetail;
                
                [_seaveTaskHeardView removeFromSuperview];
                [_tableView.tableHeaderView removeFromSuperview];
                _seaveTaskHeardView = [[SeaveTaskHeardView alloc] init];
                _seaveTaskHeardView.frame = [_seaveTaskHeardView initUI:_taskInforModel];
                _tableView.tableHeaderView = _seaveTaskHeardView;
                
                [self.tableView reloadData];
                
                NSArray *commentList = _taskDataModel.taskComment;
                if (commentList) {
                    if ([page isEqualToString:@"0"]) {
                        [_commentList removeAllObjects];
                        [_commentList addObjectsFromArray:commentList];
                        //[User_Default removeObjectForKey:@"downUpDataT"];
                    }else{
                        [_commentList addObjectsFromArray:commentList];
                    }
                    [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
                    [self.tableView footerEndRefreshing];
                    [self.tableView reloadData];
                }

            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];

}



#pragma mark -监听键盘的升降
- (void)keyboard_Show:(NSNotification *)nf {
    //获取键盘的高度
    NSDictionary *info = [nf userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        commentButn.hidden = NO;
        editView.frame = CGRectMake(0, kScreenHeight-64-50-keyboardSize.height, kScreenWidth, 50);
        commentText.frame = CGRectMake(10, 8, kScreenWidth-20-66, 34);
        commentButn.frame = CGRectMake(commentText.rightWith+10, 8, 55, 34);
        
    } completion:^(BOOL finished) {
    }];
}

- (void)keyboard_Hidden:(NSNotification *)nf {
    
    [UIView animateWithDuration:0.25 animations:^{
    } completion:^(BOOL finished) {
        commentButn.hidden = YES;
        editView.frame = CGRectMake(0, kScreenHeight-64-50, kScreenWidth, 50);
        commentText.frame = CGRectMake(10, 8, kScreenWidth-20, 34);
    }];
}



-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
