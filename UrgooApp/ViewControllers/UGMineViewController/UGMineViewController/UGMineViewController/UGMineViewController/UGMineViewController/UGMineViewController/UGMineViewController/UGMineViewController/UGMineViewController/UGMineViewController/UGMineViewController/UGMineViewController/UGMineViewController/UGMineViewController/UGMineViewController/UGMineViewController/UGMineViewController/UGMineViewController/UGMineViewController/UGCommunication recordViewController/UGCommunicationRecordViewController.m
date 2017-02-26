//
//  UGCommunicationRecordViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCommunicationRecordViewController.h"
#import "UGMessageCell.h"




@interface UGCommunicationRecordViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)NSMutableArray *dataArr;

//searchBar
@property(strong,nonatomic)UISearchBar *searchBar;
@property(strong,nonatomic)NSMutableArray *searchArr;

@end

@implementation UGCommunicationRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"聊天记录"];
    
    [self initUI];
}
-(void)initUI
{
    _dataArr = [NSMutableArray arrayWithObjects:@"1",@"12",@"2",@"14",@"22",@"123",@"4",@"6",@"5",@"7",@"8",@"9",nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49-64) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:self.tableView];
    
    
    _searchArr = [NSMutableArray array];
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
 
    //http://blog.csdn.net/forestml2008/article/details/32914915
    for (UIView *view in self.searchBar.subviews) {
//        // for before iOS7.0
//        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            [view removeFromSuperview];
//            break;
//        }
         //for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
//    _searchBar.searchBarStyle = UISearchBarIconResultsList;
//    _searchBar.placeholder = @"Please input some words";
//    _searchBar.delegate = self;
//    self.searchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc]init];
//    _tableView.tableHeaderView = _searchBar;
    
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"communication_nav_icon_search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
}
//#pragma mark - searchAction
//-(void)searchAction
//{
//    DLog(@"searchAction");
//}
#pragma mark -tableView delegate&dataSource
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    
//    if (tableView!=_tableView) {
//        return 1;
//    }
//    
//    return 1;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView!=_tableView) {
        [_searchArr removeAllObjects];
        for (NSString *str in _dataArr) {//有了model之后用model
            NSRange  range = [str rangeOfString:_searchBar.text];
            if (range.location!=NSNotFound) {
                [_searchArr addObject:str];
            }
        }
    }
    
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView!=_tableView) {
        static NSString *str = @"str";
        UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        DLog(@"--search--%@",_searchArr);
        cell.textLabel.text = _searchArr[indexPath.row];
        return cell;
    }
    
    UGMessageCell *cell  = [UGMessageCell messageTableViewCellWithTableView:tableView];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


//-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    //重新请求---添加数据---刷新--
//    DLog(@"searchBar textDidChange");
////    [self.searchDisplayController.searchResultsTableView reloadData];
//}
//-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
//{
//    DLog(@"searchBarTextDidBeginEditing");
//}
//-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
//{
//    DLog(@"searchBarTextDidEndEditing");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
