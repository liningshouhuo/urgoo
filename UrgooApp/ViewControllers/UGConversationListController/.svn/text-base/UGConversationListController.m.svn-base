//
//  UGConversationListController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGConversationListController.h"


#import "UGChatViewController.h"
#import "UGMessageHeadView.h"
#import "UGAssistantViewController.h"
#import "HttpClientManager.h"
#import "AssistantsModel.h"
#import "AppDelegate.h"

//#import "ChatViewController.h"
//#import "EMSearchBar.h"
//#import "EMSearchDisplayController.h"
//#import "RobotManager.h"
//#import "RobotChatViewController.h"
//#import "UserProfileManager.h"
//#import "RealtimeSearchUtil.h"

//@implementation EMConversation (search)
////根据用户昵称,环信机器人名称,群名称进行搜索
//- (NSString*)showName
//{
//    if (self.type == EMConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:self.conversationId]) {
//            return [[RobotManager sharedInstance] getRobotNickWithUsername:self.conversationId];
//        }
//        return [[UserProfileManager sharedInstance] getNickNameWithUsername:self.conversationId];
//    } else if (self.type == EMConversationTypeGroupChat) {
//        if ([self.ext objectForKey:@"subject"] || [self.ext objectForKey:@"isPublic"]) {
//            return [self.ext objectForKey:@"subject"];
//        }
//    }
//    return self.conversationId;
//}
//
//@end



@interface UGConversationListController ()<EaseConversationListViewControllerDelegate, EaseConversationListViewControllerDataSource>
{
    AssistantsModel * model;
}
//,UISearchDisplayDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIView *networkStateView;
//@property (nonatomic, strong) EMSearchBar           *searchBar;
//@property (strong, nonatomic) EMSearchDisplayController *searchController;

@property(nonatomic,strong)UGMessageHeadView *headView;

@property(nonatomic,strong)UILabel *noteLable;

@end

@implementation UGConversationListController

-(void)loadRequest{
   
        
       NSString * str = OrderStatus;
    
    NSLog(@"%@",str);
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"token"] = kToken;//gfaPvUV+GxQ=
        //params[@"termType"] =@"2";
        NSLog(@"%@",kToken);
        // MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
        [HttpClientManager getAsyn:UG_USER_SELECT_ORDER_INFO   params:params success:^(id resultData) {
            
           // AssistantsService * assistantsService=[[AssistantsService alloc] init];
            MsgModel *msg=[MsgModel mj_objectWithKeyValues:resultData[@"header"]];
            
            if ([msg.code isEqualToString:@"200"]){
                model = [AssistantsModel mj_objectWithKeyValues:resultData[@"body"]];
                
                NSString * Orderstr =  resultData[@"body"][@"status"];
                if ([Orderstr isEqualToString:@"1"]) {
                    [[AppDelegate sharedappDelegate] showTabBar];

                                   }
                if ([Orderstr isEqualToString:@"(null)"]) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }else{
                    //token
                    [[NSUserDefaults standardUserDefaults] setObject:Orderstr forKey:@"OrderStatus"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                
                
                
                
                
            }else if ([msg.code isEqualToString:@"400"]){
                //[weakSelf showSVString:msg.message];
                
                
                NSLog(@"11111111---------");
            }
            
            
            
            
        } failure:^(NSError *error) {
            // [weakSelf showSVErrorString:@"Network request failed, please try again later"];
            NSLog(@"没有网络");
            
            
        }];
        
        
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    
    [self setCustomTitle:@"消息"];
    
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self tableViewDidTriggerHeaderRefresh];
    
//    [self.view addSubview:self.searchBar];
//    self.tableView.frame = CGRectMake(0, self.searchBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.searchBar.frame.size.height);
    
      self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    
    
    __weak UGConversationListController *weakSelf = self;
    _headView =[[UGMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 113)];
    _headView.block = ^(){
        DLog(@"消息页面的头试图被点击了");
        UGAssistantViewController *vc =[[UGAssistantViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableHeaderView = _headView;
    
    
    
    [self networkStateView];
    
//    [self searchController];
    
    [self removeEmptyConversationsFromDB];
    
 
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _noteLable.text = @"";
}

#pragma mark -消息的判断
-(void)is_Information{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"termType"] = @"2";
    
    [HttpClientManager postAsyn:UG_informationCount_URL params:params success:^(id json) {
        if (json) {
            DLog(@"是否有消息数据:%@",json);
            id obj = json[@"body"][@"count"];
            if (![obj isEqual:@"0"]) {
                [_headView is_hideMark:NO];
            }else{
                [_headView is_hideMark:YES];
            }
        }
    } failure:^(NSError *error) {
        DLog(@"出错：%@",error);
    }];
}


- (void)viewWillAppear:(BOOL)animated
{
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
    
    
    [super viewWillAppear:animated];
    [self refresh];
    //add201604010930
    //点击聊天界面，要刷新
    [self refreshDataSource];
    [[AppDelegate sharedappDelegate].tabbar setupUnreadMessageCount];
    [self is_Information];
     //[self loadRequest];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.type == EMConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            [needRemoveConversations addObject:conversation];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EMClient sharedClient].chatManager deleteConversations:needRemoveConversations deleteMessages:YES];
    }
}

#pragma mark - getter
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = NSLocalizedString(@"network.disconnection", @"Network disconnection");
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

//- (UISearchBar *)searchBar
//{
//    if (!_searchBar) {
//        _searchBar = [[EMSearchBar alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, 44)];
//        _searchBar.delegate = self;
//        _searchBar.placeholder = NSLocalizedString(@"search", @"Search");
//        _searchBar.backgroundColor = [UIColor colorWithRed:0.747 green:0.756 blue:0.751 alpha:1.000];
//    }
//    
//    return _searchBar;
//}

//- (EMSearchDisplayController *)searchController
//{
//    if (_searchController == nil) {
//        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
//        _searchController.delegate = self;
//        _searchController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//        _searchController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
//        
//        __weak ConversationListController *weakSelf = self;
//        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
//            NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
//            EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            
//            // Configure the cell...
//            if (cell == nil) {
//                cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//            }
//            
//            id<IConversationModel> model = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
//            cell.model = model;
//            
//            cell.detailLabel.text = [weakSelf conversationListViewController:weakSelf latestMessageTitleForConversationModel:model];
//            cell.timeLabel.text = [weakSelf conversationListViewController:weakSelf latestMessageTimeForConversationModel:model];
//            return cell;
//        }];
//        
//        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
//            return [EaseConversationCell cellHeightWithModel:nil];
//        }];
//        
//        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView, NSIndexPath *indexPath) {
//            [tableView deselectRowAtIndexPath:indexPath animated:YES];
//            [weakSelf.searchController.searchBar endEditing:YES];
//            id<IConversationModel> model = [weakSelf.searchController.resultsSource objectAtIndex:indexPath.row];
//            EMConversation *conversation = model.conversation;
//            ChatViewController *chatController;
//            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//                chatController = [[RobotChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//            }else {
//                chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = [conversation showName];
//            }
//            [weakSelf.navigationController pushViewController:chatController animated:YES];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
//            [weakSelf.tableView reloadData];
//        }];
//    }
//    
//    return _searchController;
//}

#pragma mark - EaseConversationListViewControllerDelegate

- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    
//    DLog(@"conversationModel---%@",conversationModel.title);
    
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        
//        DLog(@"EMConversation--%@--%d",conversation.conversationId,conversation.type);
        
//        if (conversation) {
//            if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//                RobotChatViewController *chatController = [[RobotChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
//                chatController.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//                [self.navigationController pushViewController:chatController animated:YES];
            
//            } else {
                //UGChatViewController *chatController = [[UGChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];
        //只考虑单聊的界面
        UGChatViewController *chatController = [[UGChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:conversation.type];

        //add201604091043--根据消息是从哪里来的来给头像赋值
        chatController.kHxStr = conversation.conversationId;
        
        [[NSUserDefaults standardUserDefaults] setObject:conversation.conversationId forKey:@"chatOther_conversationId"];//userHxCode
        [[NSUserDefaults standardUserDefaults] synchronize];
        [chatController setCustomTitle:conversationModel.title];
        chatController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
//            }
    }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];
        [self.tableView reloadData];
//    }
}

#pragma mark - EaseConversationListViewControllerDataSource

- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation
{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat) {
//        if ([[RobotManager sharedInstance] isRobotWithUsername:conversation.conversationId]) {
//            model.title = [[RobotManager sharedInstance] getRobotNickWithUsername:conversation.conversationId];
//        } else {
//            UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:conversation.conversationId];
//            if (profileEntity) {
//                model.title = profileEntity.nickname == nil ? profileEntity.username : profileEntity.nickname;
//                model.avatarURLPath = profileEntity.imageUrl;
//            }
//        }
  
        //头像&昵称的处理
        if ([conversation.conversationId isEqual:@"n34V526nb19"]) {//判断是客服n34V526nb19
            model.title = @"Service";
            model.avatarImage =  [UIImage imageNamed:@"hx_icon_mr"];
        }else{//不是客服
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"token"] = kToken;
            params[@"userHxCodeString"] = conversation.conversationId;
            params[@"termType"] = @"2";
            DLog(@"%@",params);
            [HttpClientManager getAsyn:kHeadImage_Nick_Url params:params success:^(id json) {
                if (json) {
                    NSString *nickName;
                    DLog(@"头像&昵称的处理:%@",json);
                    NSArray *userInfoList = json[@"body"][@"userInfoList"];
                    if (userInfoList.count != 0) {//获取到信息
                        NSString *headImageUrl = userInfoList[0][@"userIcon"];
                        //NSString *nickName = userInfoList[0][@"enName"];
                        if (userInfoList[0][@"enName"]) {
                            nickName = userInfoList[0][@"enName"];
                        }else{
                            nickName = userInfoList[0][@"nickName"];
                        }
                        if (headImageUrl.length != 0) {//有头像
                            if ( [StringHelper isUserIconContainHttp:headImageUrl]) {
                                model.avatarURLPath = headImageUrl;
                            }else{
                                headImageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,headImageUrl];
                                model.avatarURLPath = headImageUrl;
                            }
                        }else{
                            model.avatarImage = [UIImage imageNamed:@"urgoo_default_useravatar"];
                        }
                        if (nickName.length != 0) {//有昵称
                            model.title = nickName;
                            
                        }else{
                            model.title = conversation.conversationId;
                        }
                    }
                    [self.tableView reloadData];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }

        
    } else if (model.conversation.type == EMConversationTypeGroupChat) {
        NSString *imageName = @"groupPublicHeader";
        if (![conversation.ext objectForKey:@"subject"])
        {
            NSArray *groupArray = [[EMClient sharedClient].groupManager getAllGroups];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.conversationId]) {
                    NSMutableDictionary *ext = [NSMutableDictionary dictionaryWithDictionary:conversation.ext];
                    [ext setObject:group.subject forKey:@"subject"];
                    [ext setObject:[NSNumber numberWithBool:group.isPublic] forKey:@"isPublic"];
                    conversation.ext = ext;
                    break;
                }
            }
        }
        model.title = [conversation.ext objectForKey:@"subject"];
        imageName = [[conversation.ext objectForKey:@"isPublic"] boolValue] ? @"groupPublicHeader" : @"groupPrivateHeader";
        model.avatarImage = [UIImage imageNamed:imageName];
    }
    return model;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
      latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                // 表情映射。
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
                if ([lastMessage.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
                    latestMessageTitle = @"[动画表情]";
                }
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    
    return latestMessageTitle;
}

- (NSString *)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
       latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    _noteLable.text = @"";
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        latestMessageTime = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    
    return latestMessageTime;
}

#pragma mark - UISearchBarDelegate

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
//{
//    [searchBar setShowsCancelButton:YES animated:YES];
//    
//    return YES;
//}
//
//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    __weak typeof(self) weakSelf = self;
//    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.dataArray searchText:(NSString *)searchText collationStringSelector:@selector(title) resultBlock:^(NSArray *results) {
//        if (results) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.searchController.resultsSource removeAllObjects];
//                [weakSelf.searchController.resultsSource addObjectsFromArray:results];
//                [weakSelf.searchController.searchResultsTableView reloadData];
//            });
//        }
//    }];
//}

//- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
//{
//    return YES;
//}
//
//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
//{
//    [searchBar resignFirstResponder];
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
//{
//    searchBar.text = @"";
//    [[RealtimeSearchUtil currentUtil] realtimeSearchStop];
//    [searchBar resignFirstResponder];
//    [searchBar setShowsCancelButton:NO animated:YES];
//}

#pragma mark - public

-(void)refresh
{
    [self refreshAndSortView];
}

-(void)refreshDataSource
{
    [self tableViewDidTriggerHeaderRefresh];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
    
}

- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == EMConnectionDisconnected) {
        self.tableView.tableHeaderView = _networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}



@end
