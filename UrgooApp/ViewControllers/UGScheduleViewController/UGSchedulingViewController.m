//
//  UGSchedulingViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSchedulingViewController.h"
#import "UGMyScheduleViewController.h"
#import "UGConsultHeadView.h"
#import "Masonry.h"
#import "UGPickerView.h"
#import "UGscheduCollectionViewCell.h"
#import "AdvanceCounselorInfo.h"
#import "AdvanceDateList.h"
#import "AdanceTimeList.h"
#import "MsgModel.h"
#import "UGDateCollectionViewCell.h"
#import "UGCloseCollectionViewCell.h"
#import "UGProfileViewController.h"
#import "UGGotovideoHelpViewController.h"
#import "UGScheduleDtlViewController.h"
#import "UGChatViewController.h"

@interface UGSchedulingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>
@property (strong,nonatomic)UGConsultHeadView * consultHeadView;
@property (strong,nonatomic)UIView * dateView;

@property (strong,nonatomic)UILabel * datelable;
@property (strong,nonatomic)UIButton *  chooseDatebutton;
@property (strong,nonatomic)UILabel * lable1;
@property (strong,nonatomic)UILabel * lable2;
@property (strong,nonatomic)UIScrollView * scrollView;
@property (strong,nonatomic)UICollectionView * collectionView;
@property (strong,nonatomic)UICollectionView * datecollectionView;
@property (strong,nonatomic)UGPickerView * pickerView;
@property (strong,nonatomic)UIView *  dateAlertView;
@property (strong,nonatomic)NSMutableArray * pickerArray;
@property (strong,nonatomic)UIView * leaveMessage;
@property (strong,nonatomic) UIView *accessoryView;
@property (strong,nonatomic) UITextView * leaveMessageView;
@property (strong,nonatomic) UIView *schedule_View;
@property (strong,nonatomic) UIButton * messageBtn;
@property (strong,nonatomic) NSString * collectionIndex;
@property (strong,nonatomic) NSArray * ArrayM;
@property (strong,nonatomic) AdvanceCounselorInfo * headModel;
@property (strong,nonatomic) NSMutableArray  * listArray;
@property (strong,nonatomic) AdvanceDateList * dateListModel;
@property (strong,nonatomic) AdanceTimeList * timeListModel;
@property (strong,nonatomic) NSString * timerlistindex1;
@property (strong,nonatomic) NSString * timerlistindex2;
@property (strong,nonatomic) NSString * timerlistindex3;
@property (strong,nonatomic) NSString * advanceDate;
@property (strong,nonatomic) NSMutableArray  * timerListArrayT;
@property (strong,nonatomic) NSMutableArray * indexArray;
@property (assign,nonatomic) int  timelistindex1;
@property (assign,nonatomic) int  timelistindex2;
@property (assign,nonatomic) int  timelistindex3;
@property (assign,nonatomic) NSIndexPath * indexItem;
@property (strong,nonatomic) NSString * message;
@property (strong,nonatomic) NSMutableArray * notificationArray;
@property (strong,nonatomic) NSMutableArray * index_Str1;
@property (strong,nonatomic) NSMutableArray * index_Str2;
@property (strong,nonatomic) NSMutableArray * index_Str3;
@property (strong,nonatomic) NSMutableArray * index_Str4;
@property (strong,nonatomic) NSMutableArray * index_Str5;
@property (strong,nonatomic) NSMutableArray * index_Str6;
@property (strong,nonatomic) NSMutableArray * index_Str7;
@property (assign,nonatomic) int  intbottonindex ;
@property (assign,nonatomic)  int addbottonindex;
@property (strong,nonatomic)  NSMutableDictionary * itemindexdict;
@property (strong,nonatomic)  NSMutableDictionary * index_dict1;
@property (strong,nonatomic)  NSMutableDictionary * index_dict2;
@property (strong,nonatomic)  NSMutableDictionary * index_dict3;
@property (strong,nonatomic)  NSMutableDictionary * index_dict4;
@property (strong,nonatomic)  NSMutableDictionary * index_dict5;
@property (strong,nonatomic)  NSMutableDictionary * index_dict6;
@property (strong,nonatomic)  NSMutableDictionary * index_dict7;
@property (strong,nonatomic)  NSMutableArray * itemArray1;
@property (strong,nonatomic)  NSMutableArray * itemArray2;
@property (strong,nonatomic)  NSMutableArray * itemArray3;
@property (strong,nonatomic)  NSMutableArray *  ListNewArray;
//判断是那一周
@property (strong,nonatomic) NSString * weekDate;
//判断弹框UI
@property (strong,nonatomic)  NSMutableArray * totle_indexArray;
@property (strong,nonatomic)  NSMutableArray * lastTest_array;
@property (strong,nonatomic)  NSMutableArray * lastTest_array1;
@property (strong,nonatomic)  NSMutableArray * lastTest_array2;
@property (strong,nonatomic)  NSMutableArray * lastTest_array3;
@property (strong,nonatomic)  NSMutableArray * lastTest_array4;
//保存数据的数组
@property (strong,nonatomic) NSMutableArray * saveDateArray;
@property (strong,nonatomic) UIView * alretView;
@property (strong,nonatomic) NSTimer * evaluationTime;
@property (strong,nonatomic) NSDictionary * groupArray;
//占位lable
@property (strong,nonatomic) UILabel * placeholderStr;
@property (strong,nonatomic) UITextView * beuzhuTextView;
@property (strong,nonatomic) UIScrollView * eescrollView;
 @end

@implementation UGSchedulingViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getScheduleList];
    [self setCustomTitle:@"预约"];
    _scrollView = [[UIScrollView alloc]init];
    [self needrightAction:YES];
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    _scrollView.contentSize = CGSizeMake(0, 800 - 170);
    _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 44 - 64);
    
    [self.view addSubview:_scrollView];
    
    
    
    
    //dianji cell的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhiw:) name:@"buttonIndexArraynotice" object:nil];
    //点击时间按钮的 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yl_clickdatebtn:) name:@"yl_clickdatebtn" object:nil];

    _itemindexdict = [NSMutableDictionary dictionary];
    _index_dict1 = [NSMutableDictionary dictionary];
    _index_dict2 = [NSMutableDictionary dictionary];
    _index_dict3 = [NSMutableDictionary dictionary];
    _index_dict4 = [NSMutableDictionary dictionary];
    _index_dict5 = [NSMutableDictionary dictionary];
    _index_dict6 = [NSMutableDictionary dictionary];
    _index_dict7 = [NSMutableDictionary dictionary];
    
    
}
-(void)needrightAction:(BOOL)isNeed
{
    if (isNeed) {
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithTitle:@"需要帮助" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
        
        rightItem.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = rightItem;
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName, nil] forState:UIControlStateNormal];
       // rightItem.tintColor = [UIColor whiteColor];
//        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] init];
    }
}
-(void)rightAction{
    
    UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
    vc.kHxStr = serviceId;
    //            [vc setTitle:<#(NSString * _Nullable)#>]
    //保存环信ID，获取头像&昵称
    [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    
    
    
    
}
-(UIView *)alretView{
    if (_alretView == nil) {
        _alretView = [[UIView alloc]init];
    }
    
    return _alretView;
    
}
-(NSMutableArray *)lastTest_array{
    if (_lastTest_array == nil) {
        _lastTest_array = [NSMutableArray array];
        
    }
    
    return _lastTest_array;
}
-(NSMutableArray *)lastTest_array1{
    if (_lastTest_array1 == nil) {
        _lastTest_array1 = [NSMutableArray array];
        
    }
    
    return _lastTest_array1;
}

-(NSMutableArray *)lastTest_array2{
    if (_lastTest_array2 == nil) {
        _lastTest_array2 = [NSMutableArray array];
        
    }
    
    return _lastTest_array2;
}

-(NSMutableArray *)lastTest_array3{
    if (_lastTest_array3 == nil) {
        _lastTest_array3 = [NSMutableArray array];
        
    }
    
    return _lastTest_array3;
}

-(NSMutableArray *)lastTest_array4{
    if (_lastTest_array4 == nil) {
        _lastTest_array4 = [NSMutableArray array];
        
    }
    
    return _lastTest_array4;
}


//点击通知
-(void)tongzhiw:(NSNotification *)notification{
   //  NSLog(@"%lu",(unsigned long)self.lastTest_array.count);
    NSString * indexSection= [NSString stringWithFormat:@"%@",notification.userInfo[@"cellindex"]];
    NSArray *indexRow = [NSArray arrayWithArray:notification.userInfo[@"button_array"]];
    NSString * weekdatecell =[NSString stringWithFormat:@"%@",notification.userInfo[@"dateWeek"]];
    NSLog(@"%@",weekdatecell);
    if ([weekdatecell isEqualToString:@"1"]) {
        if ([indexSection isEqualToString:@"0"]) {
            if (_index_Str1.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str1];
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                if (_index_Str1.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str1];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str1];
                }
                
                
            }else{
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];

                [self.lastTest_array1 addObject:_index_Str1];
            }
        }else if ([indexSection isEqualToString:@"1"]) {
            if (_index_Str2.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str2];
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                if (_index_Str2.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str2];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str2];
                    
                }
                
            }else{
                
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                [self.lastTest_array1 addObject:_index_Str2];
            }
            
        }else if ([indexSection isEqualToString:@"2"]) {
            if (_index_Str3.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str3];
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                if (_index_Str3.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str3];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str3];
                    
                }
                
            }else{
                
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                [self.lastTest_array1 addObject:_index_Str3];
            }
            
        }else if ([indexSection isEqualToString:@"3"]) {
            if (_index_Str4.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str4];
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                if (_index_Str4.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str4];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str4];
                }
                
                
                
            }else{
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                [self.lastTest_array1 addObject:_index_Str4];
            }
            
            
        }else if ([indexSection isEqualToString:@"4"]) {
            if (_index_Str5.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str5];
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                if (_index_Str5.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str5];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str5];
                }
                
                
                
            }else{
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                [self.lastTest_array1 addObject:_index_Str5];
            }
            
            
        }else if ([indexSection isEqualToString:@"5"]) {
            if (_index_Str6.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str6];
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                if (_index_Str6.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str6];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str6];
                }
                
                
                
            }else{
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                
                [self.lastTest_array1 addObject:_index_Str6];
            }
            
        }else if ([indexSection isEqualToString:@"6"]) {
            if (_index_Str7.count > 0 ) {
                [self.lastTest_array1 removeObject:_index_Str7];
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];

                if (_index_Str7.count == 2) {
                    [self.lastTest_array1 removeObject:_index_Str7];
                }else{
                    
                    [self.lastTest_array1 addObject:_index_Str7];
                }
                
                
                
            }else{
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                [self.lastTest_array1 addObject:_index_Str7];
            }
            
            
        }

    }else if ([weekdatecell isEqualToString:@"2"]){
        if ([indexSection isEqualToString:@"0"]) {
            if (_index_Str1.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str1];
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                if (_index_Str1.count == 2) {
                    [self.lastTest_array2 removeObject:_index_Str1];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str1];
                }
                
                
            }else{
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                [self.lastTest_array2 addObject:_index_Str1];
            }
        }else if ([indexSection isEqualToString:@"1"]) {
            if (_index_Str2.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str2];
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                if (_index_Str2.count == 2) {
                    [self.lastTest_array2 removeObject:_index_Str2];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str2];
                    
                }
                
            }else{
                
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                [self.lastTest_array2 addObject:_index_Str2];
            }
            
        }else if ([indexSection isEqualToString:@"2"]) {
            if (_index_Str3.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str3];
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                if (_index_Str3.count == 2) {
                    [self.lastTest_array2 removeObject:_index_Str3];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str3];
                    
                }
                
            }else{
                
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                [self.lastTest_array2 addObject:_index_Str3];
            }
            
        }else if ([indexSection isEqualToString:@"3"]) {
            if (_index_Str4.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str4];
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                if (_index_Str4.count == 2) {
                    [_lastTest_array2 removeObject:_index_Str4];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str4];
                }
                
                
                
            }else{
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                [self.lastTest_array2 addObject:_index_Str4];
            }
            
            
        }else if ([indexSection isEqualToString:@"4"]) {
            if (_index_Str5.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str5];
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                if (_index_Str5.count == 2) {
                    [_lastTest_array2 removeObject:_index_Str5];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str5];
                }
                
                
                
            }else{
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                [self.lastTest_array2 addObject:_index_Str5];
            }
            
            
        }else if ([indexSection isEqualToString:@"5"]) {
            if (_index_Str6.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str6];
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                if (_index_Str6.count == 2) {
                    [_lastTest_array2 removeObject:_index_Str6];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str6];
                }
                
                
                
            }else{
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                
                [self.lastTest_array2 addObject:_index_Str6];
            }
            
        }else if ([indexSection isEqualToString:@"6"]) {
            if (_index_Str7.count > 0 ) {
                [self.lastTest_array2 removeObject:_index_Str7];
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                
                if (_index_Str7.count == 2) {
                    [_lastTest_array2 removeObject:_index_Str7];
                }else{
                    
                    [self.lastTest_array2 addObject:_index_Str7];
                }
                
                
                
            }else{
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                [self.lastTest_array2 addObject:_index_Str7];
            }
            
            
        }
        

        
    }else if ([weekdatecell isEqualToString:@"3"]){
        if ([indexSection isEqualToString:@"0"]) {
            if (_index_Str1.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str1];
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                if (_index_Str1.count == 2) {
                    [self.lastTest_array3 removeObject:_index_Str1];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str1];
                }
                
                
            }else{
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                [self.lastTest_array3 addObject:_index_Str1];
            }
        }else if ([indexSection isEqualToString:@"1"]) {
            if (_index_Str2.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str2];
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                if (_index_Str2.count == 2) {
                    [self.lastTest_array3 removeObject:_index_Str2];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str2];
                    
                }
                
            }else{
                
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                [self.lastTest_array3 addObject:_index_Str2];
            }
            
        }else if ([indexSection isEqualToString:@"2"]) {
            if (_index_Str3.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str3];
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                if (_index_Str3.count == 2) {
                    [self.lastTest_array3 removeObject:_index_Str3];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str3];
                    NSLog(@"%@",self.lastTest_array3);
                }
                
            }else{
                
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                [self.lastTest_array3 addObject:_index_Str3];
            }
            
        }else if ([indexSection isEqualToString:@"3"]) {
            if (_index_Str4.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str4];
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                if (_index_Str4.count == 2) {
                    [_lastTest_array3 removeObject:_index_Str4];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str4];
                }
                
                
                
            }else{
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                [self.lastTest_array3 addObject:_index_Str4];
            }
            
            
        }else if ([indexSection isEqualToString:@"4"]) {
            if (_index_Str5.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str5];
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                if (_index_Str5.count == 2) {
                    [_lastTest_array3 removeObject:_index_Str5];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str5];
                }
                
                
                
            }else{
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                [self.lastTest_array3 addObject:_index_Str5];
            }
            
            
        }else if ([indexSection isEqualToString:@"5"]) {
            if (_index_Str6.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str6];
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                if (_index_Str6.count == 2) {
                    [_lastTest_array3 removeObject:_index_Str6];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str6];
                }
                
                
                
            }else{
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                
                [self.lastTest_array3 addObject:_index_Str6];
            }
            
        }else if ([indexSection isEqualToString:@"6"]) {
            if (_index_Str7.count > 0 ) {
                [self.lastTest_array3 removeObject:_index_Str7];
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                
                if (_index_Str7.count == 2) {
                    [_lastTest_array3 removeObject:_index_Str7];
                }else{
                    
                    [self.lastTest_array3 addObject:_index_Str7];
                }
                
                
                
            }else{
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                [self.lastTest_array3 addObject:_index_Str7];
            }
            
            
        }
        

        
    }else if ([weekdatecell isEqualToString:@"4"]){
        if ([indexSection isEqualToString:@"0"]) {
            if (_index_Str1.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str1];
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                if (_index_Str1.count == 2) {
                    [self.lastTest_array4 removeObject:_index_Str1];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str1];
                }
                
                
            }else{
                
                _index_Str1 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str1 addObject:@"0"];
                
                [_index_Str1 addObjectsFromArray:indexRow];
                
                [self.lastTest_array4 addObject:_index_Str1];
            }
        }else if ([indexSection isEqualToString:@"1"]) {
            if (_index_Str2.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str2];
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                if (_index_Str2.count == 2) {
                    [self.lastTest_array4 removeObject:_index_Str2];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str2];
                    
                }
                
            }else{
                
                _index_Str2 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str2 addObject:@"1"];
                
                [_index_Str2 addObjectsFromArray:indexRow];
                [self.lastTest_array4 addObject:_index_Str2];
            }
            
        }else if ([indexSection isEqualToString:@"2"]) {
            if (_index_Str3.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str3];
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                if (_index_Str3.count == 2) {
                    [self.lastTest_array4 removeObject:_index_Str3];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str3];
                    
                }
                
            }else{
                
                _index_Str3 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str3 addObject:@"2"];
                
                [_index_Str3 addObjectsFromArray:indexRow];
                [self.lastTest_array4 addObject:_index_Str3];
            }
            
        }else if ([indexSection isEqualToString:@"3"]) {
            if (_index_Str4.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str4];
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                if (_index_Str4.count == 2) {
                    [_lastTest_array4 removeObject:_index_Str4];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str4];
                }
                
                
                
            }else{
                _index_Str4 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str4 addObject:@"3"];
                
                [_index_Str4 addObjectsFromArray:indexRow];
                [self.lastTest_array4 addObject:_index_Str4];
            }
            
            
        }else if ([indexSection isEqualToString:@"4"]) {
            if (_index_Str5.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str5];
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                if (_index_Str5.count == 2) {
                    [_lastTest_array4 removeObject:_index_Str5];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str5];
                }
                
                
                
            }else{
                _index_Str5 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str5 addObject:@"4"];
                
                [_index_Str5 addObjectsFromArray:indexRow];
                [self.lastTest_array4 addObject:_index_Str5];
            }
            
            
        }else if ([indexSection isEqualToString:@"5"]) {
            if (_index_Str6.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str6];
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                if (_index_Str6.count == 2) {
                    [_lastTest_array4 removeObject:_index_Str6];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str6];
                }
                
                
                
            }else{
                _index_Str6 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str6 addObject:@"5"];
                
                [_index_Str6 addObjectsFromArray:indexRow];
                
                [self.lastTest_array4 addObject:_index_Str6];
            }
            
        }else if ([indexSection isEqualToString:@"6"]) {
            if (_index_Str7.count > 0 ) {
                [self.lastTest_array4 removeObject:_index_Str7];
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                
                if (_index_Str7.count == 2) {
                    [_lastTest_array4 removeObject:_index_Str7];
                }else{
                    
                    [self.lastTest_array4 addObject:_index_Str7];
                }
                
                
                
            }else{
                _index_Str7 =[NSMutableArray arrayWithObject:weekdatecell];
                [_index_Str7 addObject:@"6"];
                
                [_index_Str7 addObjectsFromArray:indexRow];
                [self.lastTest_array4 addObject:_index_Str7];
            }
            
            
        }
        

            }
    if (self.lastTest_array1.count > 0) {
       [self.lastTest_array removeObject:self.lastTest_array1];
        
        [self.lastTest_array addObject:self.lastTest_array1];
    
    }
    if (self.lastTest_array2.count > 0){
        [self.lastTest_array removeObject:self.lastTest_array2];
        
        [self.lastTest_array addObject:self.lastTest_array2];
    }
    if (self.lastTest_array3.count > 0){
        [self.lastTest_array removeObject:self.lastTest_array3];
        
        [self.lastTest_array addObject:self.lastTest_array3];
    }
    if(self.lastTest_array4.count>0){
        [self.lastTest_array removeObject:self.lastTest_array4];
        
        [self.lastTest_array addObject:self.lastTest_array4];
    }

    //数组简化处理
    if (self.lastTest_array.count >0) {
        
        NSMutableArray * test = [NSMutableArray array];
        _saveDateArray = [NSMutableArray array];
        NSArray * array1 = [NSArray arrayWithArray:self.lastTest_array[0]];
        [test addObjectsFromArray:array1];
        if (self.lastTest_array.count >1) {
            NSArray * array2 = [NSArray arrayWithArray:self.lastTest_array[1]];
            
            [test addObjectsFromArray:array2];
        }
        if (self.lastTest_array.count >2) {
            NSArray * array3 = [NSArray arrayWithArray:self.lastTest_array[2]];
            [test addObjectsFromArray:array3];
        }
        if (self.lastTest_array.count >3) {
            NSArray * array4 = [NSArray arrayWithArray:self.lastTest_array[3]];
            [test addObjectsFromArray:array4];
        }
        [_saveDateArray addObjectsFromArray:test];
        
        NSLog(@" [test addObjectsFromArray:array1];=====%@",_saveDateArray);
    }

    //判断次数
    if (_saveDateArray.count >0) {
        if (_saveDateArray.count >3) {
            [self showSVErrorString:@"您最多只能选择三个时间段"];
        }else{
            if (_saveDateArray.count == 1) {
                NSArray * array = _saveDateArray[0];
                if (array.count >5) {
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }
            }else if (_saveDateArray.count==2){
                NSArray * array = _saveDateArray[0];
                NSArray * array1 =_saveDateArray[1];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                int intstr = [str intValue];
                int intstr1 = [str1 intValue];
                int addint = intstr + intstr1 ;
                if (addint >7) {
                     [self showSVErrorString:@"您最多只能选择三个时间段"];
                }
                
                
                
            }else if (_saveDateArray.count == 3){
                NSArray * array = _saveDateArray[0];
                NSArray * array1 = _saveDateArray[1];
                NSArray * array2 = _saveDateArray[2];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                NSString * str2 = [NSString stringWithFormat:@"%lu",(unsigned long)array2.count];
                int intstr = [str intValue];
                 int intstr1 = [str1 intValue];
                 int intstr2 = [str2 intValue];
                int addint = intstr + intstr1 + intstr2;
                NSLog(@"%d",addint);
                if (addint ==9) {
                    
                }else{
                     [self showSVErrorString:@"您最多只能选择三个时间段"];
                }
                      }
            
        }
    }
       //[self.lastTest_array addObject:notification.userInfo[@"button_array"]];
    
    //NSLog(@"_lastTest_array== %@",self.lastTest_array);
    
}
-(NSMutableArray *)totle_indexArray{
    _totle_indexArray = [NSMutableArray array];
    if (self.itemArray2.count >0) {
        if (self.itemArray2.count == 1) {
            NSArray * totlindex = [NSArray arrayWithArray:self.itemArray2[0]];
            [_totle_indexArray addObjectsFromArray:totlindex];
            [_totle_indexArray removeLastObject];
        }else if (self.itemArray2.count == 2){
             NSArray * totlindex = [NSArray arrayWithArray:self.itemArray2[0]];
             NSArray * totlindex1 = [NSArray arrayWithArray:self.itemArray2[1]];
            
            [_totle_indexArray addObjectsFromArray:totlindex];
            [_totle_indexArray addObjectsFromArray:totlindex1];
            [_totle_indexArray removeLastObject];
            [_totle_indexArray removeLastObject];
        }else if (self.itemArray2.count == 3){
            
            NSArray * totlindex = [NSArray arrayWithArray:self.itemArray2[0]];
            NSArray * totlindex1 = [NSArray arrayWithArray:self.itemArray2[1]];
            NSArray * totlindex2 = [NSArray arrayWithArray:self.itemArray2[2]];
            [_totle_indexArray addObjectsFromArray:totlindex];
            [_totle_indexArray addObjectsFromArray:totlindex1];
            [_totle_indexArray addObjectsFromArray:totlindex2];
            [_totle_indexArray removeLastObject];
            [_totle_indexArray removeLastObject];
            [_totle_indexArray removeLastObject];
            
        }
    }
    
    return _totle_indexArray;
}
-(UGPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView= [[UGPickerView alloc]initWithFrame:CGRectZero andTitleArr:self.pickerArray];
     }
    
    return _pickerView;
    
    
}

-(NSMutableArray *)itemArray2{
      _itemArray2 = [NSMutableArray arrayWithArray:self.lastTest_array];
       return _itemArray2;
}
-(NSMutableArray *)pickerArray{
    if (_pickerArray ==nil) {
        _pickerArray = [NSMutableArray arrayWithObjects:@"gubh",@"cdxcd'",@"'csdcdc",@"csccxcx", nil];
    }
    
    return _pickerArray;
    
}
-(NSMutableArray *)indexArray{
    if (_indexArray ==nil) {
        _indexArray = [NSMutableArray array];
    }
    
    return _indexArray;
    
}

#pragma mark 网络 求求 获取 顾问预约时间
-(void)getScheduleList{
     [SVProgressHUD show];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString * str =self.counselorId;
    params[@"token"] = kToken;
    params[@"counselorId"] = str ;
    [HttpClientManager getAsyn:advanceInfoClient params:params success:^(id json) {
        NSLog(@"%@",json);
        _headModel = [AdvanceCounselorInfo mj_objectWithKeyValues:json[@"body"][@"advanceCounselorInfo"]];
        _listArray = [NSMutableArray arrayWithArray: json[@"body"][@"advanceDateList"][@"1"]];
       
        _groupArray = [NSDictionary dictionaryWithDictionary:json[@"body"][@"advanceDateList"]];
        _ListNewArray = [NSMutableArray arrayWithArray:_groupArray[@"1"]];
        _weekDate = @"1";
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
      [self initUI];
          } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
        
    }];
    
 
}
#pragma mark 发送预约信息
-(void)sendScheduleMessage{
        // 预约详情 结束
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
                params[@"token"] = kToken;
                params[@"advanceId"] = @"15" ;
               //params[@"reason"] = @"titlr";
            //    params[@"comment"] = @"ttttttttrrrrrrrr";/001/001/advance/advanceDetailListClient
                [HttpClientManager postAsyn:@"http://139.129.164.163:8081/001/001/advance/advanceDetailListClient" params:params success:^(id json) {
                  
                } failure:^(NSError *error) {
                     NSLog(@"%@",error);
                }];
    
    
}
-(void)initUI{
    //_scrollView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    //头视图
    _consultHeadView = [[UGConsultHeadView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, 111)];
    _consultHeadView.layer.borderWidth = 0.5f;
    _consultHeadView.layer.borderColor = [RGB(217, 217, 217) CGColor];
    _consultHeadView.advanceInfo = _headModel;
     __weak __typeof__(self) weakSelf = self;
    _consultHeadView.clickWenHaoBlock = ^(){
        UGGotovideoHelpViewController * vc= [[UGGotovideoHelpViewController alloc]init];
        
        [weakSelf pushToNextViewController:vc];
        
    };

    NSLog(@"--------------------%@",_consultHeadView.advanceInfo.cnName);
    [_scrollView addSubview:_consultHeadView];
    [self set_newDateViewUI];
    [self choose_dateViewUI];
    [self setCommentsUI];
    //键盘升降
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Hidden:) name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark 备注
-(void)setCommentsUI{
    UIView * beizhuView = [[UIView alloc]init];
    beizhuView.layer.borderWidth = 0.5f;
    beizhuView.layer.borderColor = [RGB(217, 217, 217) CGColor];

    beizhuView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_scrollView addSubview:beizhuView];
    UILabel * beizhuLable = [[UILabel alloc]init];
    beizhuLable.text = @"备注:";
    beizhuLable.textColor = [UIColor colorWithHexString:@"#383838"];
    beizhuLable.font = [UIFont systemFontOfSize:13];
    beizhuLable.textAlignment = NSTextAlignmentLeft;
    
    [beizhuView addSubview:beizhuLable];
    
     _beuzhuTextView = [[UITextView alloc] init];
    _beuzhuTextView.delegate = self;
    _beuzhuTextView.layer.borderWidth = 0.5;
    _beuzhuTextView.layer.borderColor = RGB(227, 227, 227).CGColor;
    //_leaveMessage.backgroundColor = [UIColor redColor];
    [beizhuView addSubview:_beuzhuTextView];
    
    _placeholderStr = [[UILabel alloc]init];
    _placeholderStr.text = @"有什么想对顾问说的吗";
    _placeholderStr.font = [UIFont systemFontOfSize:13];
    _placeholderStr.textColor = [UIColor colorWithHexString:@"#b7b7b7"];
    [beizhuView addSubview:_placeholderStr];
    
    [_placeholderStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beizhuLable.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(150, 14));
        make.left.mas_equalTo(beizhuView.mas_left).offset(10);
    }];

    
    [_beuzhuTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beizhuLable.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 20, 80));
        make.left.mas_equalTo(beizhuView.mas_left).offset(10);
    }];
    

    
    
    
    
    [beizhuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(beizhuView.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(45, 15));
        make.left.mas_equalTo(beizhuView.mas_left).offset(10);
    }];

    
    
    
    
    
    
    
    [beizhuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_collectionView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(375, 122));
        make.left.mas_equalTo(_scrollView.mas_left);
    }];
    
    
    
    
    
    
}


//日期选择
#pragma mark 日期选择
-(void)set_newDateViewUI{
    //背景
    _dateView = [[UIView alloc]init];
    _dateView.layer.borderWidth = 0.5f;
    _dateView.layer.borderColor = [RGB(217, 217, 217) CGColor];

    [_scrollView addSubview:_dateView];
    
    _dateView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    //选择时间
    _datelable =[[UILabel alloc]init];
    _datelable.text =@"选择日期:(最多3个)";
    [_dateView setTintColor:[UIColor colorWithHexString:@"#383838"]];
    _datelable.font = [UIFont systemFontOfSize:14];
    [_dateView addSubview:_datelable];
 /// 周一到周日
    UIView * weekView= [[ UIView alloc]init];
    weekView.backgroundColor = [UIColor colorWithHexString:@"#f8f9f9"];
    [_dateView addSubview:weekView];
    //for  循环
     NSArray * datearray2 = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    for (int i =0; i<_listArray.count; i++) {
        int space = 7;
        CGFloat width = (kScreenWidth - 56)/7;
        UILabel * weekLable =[[UILabel alloc]initWithFrame:CGRectMake(i * kScreenWidth/7 +10, 11, 23, 11)];
        weekLable.text = datearray2[i];
        weekLable.textColor = [UIColor colorWithHexString:@"#cdcccc"];
        weekLable.font =[UIFont systemFontOfSize:11];
        [weekView addSubview:weekLable];
        
        
        
        
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(space * (i+1) +width *i, 48, width, 45)];
        button.tag = 10 +i;
        [button setTitleColor:[UIColor whiteColor] forState:  UIControlStateSelected ];
//        [button setBackgroundImage:[self createImageWithColor:RGB(38, 189, 171)] forState:UIControlStateSelected];
//        [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#f6f6f6"]] forState:UIControlStateNormal];
        //[button setTitle:datearray1[i] forState:UIControlStateNormal];
        ///button.titleLabel.font = [UIFont systemFontOfSize:9];
        //[button setTintColor:[UIColor colorWithHexString:@"#383838"]];
//        [button addTarget:self action:@selector(clickDatebutton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        
        
        
        //默认第一个选中
        if (button.tag == 10) {
            
            button.selected = YES;
            button.tintColor = [UIColor whiteColor];
            //[_dateView addSubview:button];
        
               }
    
    
    }
  //collectionView
    UICollectionViewFlowLayout *  layout1 = [[UICollectionViewFlowLayout alloc]init];
    layout1.itemSize = CGSizeMake(kScreenWidth , 35);
    layout1.minimumLineSpacing = 0;
    layout1.minimumInteritemSpacing = 0;
    layout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _datecollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout1];
    [_datecollectionView registerClass:[UGDateCollectionViewCell class] forCellWithReuseIdentifier:@"datecolectioncell"];
    _datecollectionView.dataSource =self;
    _datecollectionView.delegate=self;
    _datecollectionView.pagingEnabled = YES;
    _datecollectionView.showsVerticalScrollIndicator = NO;
    _datecollectionView.showsHorizontalScrollIndicator = NO;
    _datecollectionView.bounces = NO;
    _datecollectionView.backgroundColor = [UIColor redColor];
    [_dateView addSubview:_datecollectionView];
    
    
    [_datecollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_dateView.mas_top).offset(91);
       
        make.left.mas_equalTo(_dateView.mas_left);
        make.right.mas_equalTo(_dateView.mas_right);
        make.height.mas_equalTo(35);
    }];

    
    
    
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_consultHeadView.mas_bottom).offset(10);
        make.left.mas_equalTo(_scrollView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 165));
        
    }];
    
    [_datelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_dateView.mas_centerX);
        make.top.mas_equalTo(_dateView.mas_top).offset(13);
        make.size.mas_equalTo(CGSizeMake(130, 14));
    }];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_dateView.mas_left);
        make.top.mas_equalTo(_dateView.mas_top).offset(45);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 31));
    }];

   
    
}
-(void)set_dateviewUI{
    //选择日期
    _dateView = [[UIView alloc]init];
    [_scrollView addSubview:_dateView];
    _dateView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_consultHeadView.mas_bottom).offset(10);
        make.left.mas_equalTo(_scrollView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 108));
    }];
    _datelable =[[UILabel alloc]init];
    _datelable.text =@"选择日期:(最多3个)";
    [_dateView setTintColor:[UIColor colorWithHexString:@"#383838"]];
    _datelable.font = [UIFont systemFontOfSize:14];
    [_dateView addSubview:_datelable];
    //线
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#9d9d9d"];
    
    [_dateView addSubview:lineView];
    NSMutableArray * datearray1 = [NSMutableArray array];
     NSMutableArray * datearray2 = [NSMutableArray array];
      for (NSDictionary * dict in _listArray) {
        _dateListModel = [AdvanceDateList mj_objectWithKeyValues:dict];
        
        [datearray1 addObject:_dateListModel.date];
        [datearray2 addObject:_dateListModel.weekName];
    
    }
    //NSArray * datearray1 = @[@"5月7日",@"5月8日",@"5月9日",@"5月10日",@"5月11日",@"5月12日",@"5月13日"];
    // NSArray * datearray2 = @[@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日"];
    for (int i =0; i<_listArray.count; i++) {
          int space = 7;
        CGFloat width = (kScreenWidth - 56)/7;
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(space * (i+1) +width *i, 48, width, 45)];
        button.tag = 10 +i;
        [button setTitleColor:[UIColor whiteColor] forState:  UIControlStateSelected ];
        [button setBackgroundImage:[self createImageWithColor:RGB(38, 189, 171)] forState:UIControlStateSelected];
        [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#f6f6f6"]] forState:UIControlStateNormal];
        //[button setTitle:datearray1[i] forState:UIControlStateNormal];
        ///button.titleLabel.font = [UIFont systemFontOfSize:9];
        //[button setTintColor:[UIColor colorWithHexString:@"#383838"]];
        [button addTarget:self action:@selector(clickDatebutton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor colorWithHexString:@"#f6f6f6"];
        UILabel * lable1 =[[UILabel alloc]init];
        lable1.frame = CGRectMake(3, 10, 39, 10);
        lable1.text = datearray1[i];
        lable1.tag = 110 +i;
        lable1.font = [UIFont systemFontOfSize:9.69];
        if(kScreenWidth == 320){
             lable1.font = [UIFont systemFontOfSize:8];
        }
          
        [lable1 setTextColor:[UIColor colorWithHexString:@"#383838"]];
        lable1.textAlignment =   NSTextAlignmentLeft ;
        [button addSubview:lable1];
        UILabel * lable2 =[[UILabel alloc]init];
        lable2.frame = CGRectMake(3, 25, 39, 10);
        lable2.text = datearray2[i];
        lable2.tag = 210 +i;
        lable2.font = [UIFont systemFontOfSize:9.69];
        lable2.textAlignment =   NSTextAlignmentCenter ;
        if(kScreenWidth == 320){
            lable2.font = [UIFont systemFontOfSize:8];
            lable2.textAlignment =   NSTextAlignmentLeft ;
        }

        [lable1 setTextColor:[UIColor colorWithHexString:@"#383838"]];
        [button addSubview:lable2];
        //默认第一个选中
        if (button.tag == 10) {
            
            button.selected = YES;
             button.tintColor = [UIColor whiteColor];
            if (lable1.tag == 110 && lable2.tag == 210) {
                
                [lable1 setTextColor:[UIColor whiteColor]];
                [lable2 setTextColor:[UIColor whiteColor]];
            }
           
        }
        [_dateView addSubview:button];
    
    }
    [_datelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_dateView.mas_centerX);
        make.top.mas_equalTo(_dateView.mas_top).offset(13);
        make.size.mas_equalTo(CGSizeMake(57, 14));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_datelable.mas_bottom).offset(10);
        make.left.mas_equalTo(_dateView.mas_left);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 0.5));
    }];
}

-(void)clickDatebutton:(UIButton *)sender{
    
   
        for (NSInteger i =210; i<217; i++) {
            UILabel *tmpBtn  = (UILabel *)[_scrollView viewWithTag:i];
            [tmpBtn setTextColor:[UIColor colorWithHexString:@"#383838"]];
            //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            
        }
        for (NSInteger i =110; i<117; i++) {
            UILabel *tmpBtn  = (UILabel *)[_scrollView viewWithTag:i];
            [tmpBtn setTextColor: [UIColor colorWithHexString:@"#383838"]];
            //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
            
        }
    for (NSInteger i=998; i<1001; i++) {
        UIButton *tmpBtn = (UIButton *)[_scrollView viewWithTag: i];
        //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        tmpBtn.selected = NO;
    }
    sender.selected = YES;
   
   
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


        NSInteger i = sender.tag + 100;
         NSInteger z = sender.tag + 200;
        UILabel * tmplable1 = (UILabel * )[_scrollView viewWithTag:i];
        [tmplable1 setTextColor:[UIColor whiteColor]];
        UILabel * tmplable2 = (UILabel * )[_scrollView viewWithTag:z];
        [tmplable2 setTextColor:[UIColor whiteColor]];
        [_collectionView setContentOffset:CGPointMake(kScreenWidth * (sender.tag -10), 0)];
    
    
}
//选择时间；
-(void)choose_dateViewUI{
    
    UIView * scheduleview = [[UIView alloc]init];
    UITapGestureRecognizer * Scheduleview_recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(starButtonClicked:)];
    
    [scheduleview addGestureRecognizer:Scheduleview_recognizer];
    
    UILabel * lable = [[UILabel alloc]init];
    lable.text = @"立即预约";
    lable.font = [UIFont systemFontOfSize:14];
    [lable setTextColor:[UIColor whiteColor]];
    [scheduleview addSubview:lable];
    scheduleview.backgroundColor = RGB(38, 189, 171);
    [self.view addSubview:scheduleview];
    [scheduleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view .mas_bottom);
        make.left.mas_equalTo(self.view .mas_left);
        make.right.mas_equalTo(self.view .mas_right);
        make.height.mas_equalTo(44);
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scheduleview.mas_top).offset(15);
        make.centerX.mas_equalTo(self.view .mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 14));
    }];
    UICollectionViewFlowLayout *  layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth ,150);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.layer.borderWidth = 0.5f;
    _collectionView.layer.borderColor = [RGB(217, 217, 217) CGColor];

    [_collectionView registerClass:[UGscheduCollectionViewCell class] forCellWithReuseIdentifier:@"colectioncell"];
    [_collectionView registerClass:[UGCloseCollectionViewCell class] forCellWithReuseIdentifier:@"close_shdeule"];
    _collectionView.dataSource =self;
    _collectionView.delegate=self;
    _collectionView.pagingEnabled = YES;
     _collectionView.scrollEnabled =NO;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_collectionView];
    
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scrollView.mas_top).offset(302);
//        make.bottom.mas_equalTo(_scrollView.mas_bottom).offset(-44);
        make.left.mas_equalTo(_scrollView.mas_left);
//        make.right.mas_equalTo(_scrollView.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth,  150));
    }];
    
}
#pragma mark 代理方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _collectionView) {
        return 7;
    }else if (collectionView == _datecollectionView){
        
        return 4;
    }
    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView ==_collectionView) {
        
        AdvanceDateList * advandatelist = [AdvanceDateList mj_objectWithKeyValues: _ListNewArray[indexPath.row]];
        if ([advandatelist.busyDay isEqualToString:@"green"]) {
            
            UGscheduCollectionViewCell *  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colectioncell" forIndexPath:indexPath];
            
            if (!cell) {
                cell  = [[UGscheduCollectionViewCell alloc]initWithFrame:CGRectZero];
                
            }
            // NSLog(@"_itemindexdict =====%@",_itemindexdict);
            
            
            
            cell.cellIndex = indexPath.row;
            cell.dateListmodel = [AdvanceDateList mj_objectWithKeyValues: _ListNewArray[indexPath.row]];
            _advanceDate = cell.dateListmodel.advanceDate;
            
            cell.dateWeek = _weekDate;
            // NSLog(@"%@",self.itemArray2);
            cell.indexpathArray = _saveDateArray;
            
            
            
            _indexItem = indexPath;
            
            // cell.addbuttonIndex = self.addbottonindex;
            // NSLog(@"%d",self.addbottonindex);
            _collectionIndex = [NSString stringWithFormat:@"点击的是第%ld",(long)indexPath.row];
            // cell.testlable = str ;
            
            return cell;
        }else{
            UGCloseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"close_shdeule" forIndexPath:indexPath];
            if (!cell) {
                cell  = [[UGCloseCollectionViewCell alloc]initWithFrame:CGRectZero];
            }
            
            //cell.backgroundColor = [UIColor blueColor];
            return cell;
        }
        
    }else if (collectionView ==_datecollectionView){
        
        UGDateCollectionViewCell *  cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"datecolectioncell" forIndexPath:indexPath];
        
        if (!cell) {
            cell  = [[UGDateCollectionViewCell alloc]initWithFrame:CGRectZero];
        }
        cell.contentView.backgroundColor = [UIColor whiteColor];
        NSInteger  indepathrow =  indexPath.row  + 1;
        
        NSString * indepathrowstr = [NSString stringWithFormat:@"%ld",(long)indepathrow];
        
        cell.tagindex =indexPath.row + 1;
         cell.indexpathArray = [_groupArray objectForKey:indepathrowstr];
        
        return cell;
        
        
    }
    return nil;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _collectionView) {
        
        NSInteger index = scrollView.contentOffset.x/kScreenWidth;
        NSString * index_str = [NSString stringWithFormat:@"%ld",(long)index];
        NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:index_str,@"index_str", nil];
        //创建一个消息对象
        NSNotification * collectionNotice = [NSNotification notificationWithName:@"yl_collectionView" object:self userInfo:dict];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:collectionNotice];

        
        
        
        
        
//        for (NSInteger i =210; i<217; i++) {
//            UILabel *tmpBtn  = (UILabel *)[_scrollView viewWithTag:i];
//            [tmpBtn setTextColor:[UIColor colorWithHexString:@"#383838"]];
//            //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//            
//        }
//        for (NSInteger i =110; i<117; i++) {
//            UILabel *tmpBtn  = (UILabel *)[_scrollView viewWithTag:i];
//            [tmpBtn setTextColor: [UIColor colorWithHexString:@"#383838"]];
//            //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//            
//        }
//        
//        for (NSInteger i =10; i<17; i++) {
//            UIButton *tmpBtn  = (UIButton *)[_scrollView viewWithTag:i];
//            tmpBtn.selected = NO;
//            //tmpBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//            
//        }
//        UILabel * tmplable1 = (UILabel * )[_scrollView viewWithTag:110+index];
//        [tmplable1 setTextColor:[UIColor whiteColor]];
//        UILabel * tmplable2 = (UILabel * )[self.view viewWithTag:210+index];
//        [tmplable2 setTextColor:[UIColor whiteColor]];
//        _chooseDatebutton = (UIButton *)[self.view viewWithTag:10+index];
//        _chooseDatebutton.selected = YES;
//        //selectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_scrollView setContentOffset:CGPointMake(index*kScreenWidth, 0) animated:YES];
        
    }else{
         NSInteger index = scrollView.contentOffset.x/kScreenWidth;
       
        //[_listArray removeAllObjects];
        if (index == 1) {
            _weekDate = @"2";
            _ListNewArray = [NSMutableArray arrayWithArray:_groupArray[@"2"]];
             [_collectionView setContentSize:CGSizeMake(0, 0)];
            [_collectionView reloadData];
            NSLog(@"%lu",(unsigned long)_lastTest_array.count);
            
        }else if (index == 2){
             _weekDate = @"3";
            _ListNewArray = [NSMutableArray arrayWithArray:_groupArray[@"3"]];
            [_collectionView setContentSize:CGSizeMake(0, 0)];
            [_collectionView reloadData];
             NSLog(@"%lu",(unsigned long)_lastTest_array.count);

        }else if (index == 3){
             _weekDate = @"4";
              _ListNewArray = [NSMutableArray arrayWithArray:_groupArray[@"4"]];
             [_collectionView setContentSize:CGSizeMake(0, 0)];
            [_collectionView reloadData];
             NSLog(@"%lu",(unsigned long)_lastTest_array.count);
        }else if (index == 0){
            _weekDate = @"1";
            _ListNewArray = [NSMutableArray arrayWithArray:_groupArray[@"1"]];
             [_collectionView setContentSize:CGSizeMake(0, 0)];
            [_collectionView reloadData];
             NSLog(@"%lu",(unsigned long)_lastTest_array.count);
        }
        
    }
    
    
    
    
}

#pragma mark 点击时间按钮
-(void)yl_clickdatebtn:(NSNotification *)notification{
    NSString * indexSection= [NSString stringWithFormat:@"%@",notification.userInfo[@"button_indexstr"]];
    
    NSInteger index = [indexSection intValue];
    
    [_collectionView setContentOffset:CGPointMake(kScreenWidth * index, 0)];
    
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





- (void)tongzhi:(NSNotification *)notification{
    NSString * bottonindex = notification.userInfo[@"bottonindex"];
    NSLog(@"bottonindex---======%@",bottonindex);
  _intbottonindex = [bottonindex intValue];
   
    self.addbottonindex += _intbottonindex;
    NSString * addbottonindex = [NSString stringWithFormat:@"%d",self.addbottonindex];
    NSDictionary * yandict =[[NSDictionary alloc]initWithObjectsAndKeys:addbottonindex,@"addbottonindex", nil];
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"yansendbtnindex" object:self userInfo:yandict];
    if (self.addbottonindex >3) {
        NSLog(@"最多三个");
    }else{
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        _index_Str1 = [NSMutableArray array];
        _index_Str2 = [NSMutableArray array];
        _index_Str3 = [NSMutableArray array];
        _index_Str4 = [NSMutableArray array];
        _index_Str5 = [NSMutableArray array];
        _index_Str6 = [NSMutableArray array];
        _index_Str7 = [NSMutableArray array];
        _notificationArray = [NSMutableArray array];
        for (NSString *str  in [notification.userInfo allValues]) {
            [_notificationArray addObject:str];
            
        }
        
        NSLog(@"_notificationArray.count- %lu",(unsigned long)_notificationArray.count);
        if (_notificationArray.count ==3) {
            if (notification.userInfo[@"selsect"]) {
                _timerlistindex1= notification.userInfo[@"selsect"];
                _timelistindex1 = [_timerlistindex1 intValue];
                [self.indexArray removeObject:_timerlistindex1];
                
            }else{
                
                NSString * indexStr = notification.userInfo[@"cellIndex"][0];
                int indexstr = [indexStr intValue];
                [self.indexArray addObject:indexStr];
                _timerlistindex1= notification.userInfo[@"indexone"];
                _timelistindex1 = [_timerlistindex1 intValue];
                
                
               
                if (indexstr ==0) {
                    [_index_Str1 addObject:_timerlistindex1];
                }else if (indexstr==1){
                    [_index_Str2 addObject:_timerlistindex1];
                }else if (indexstr==2){
                    [_index_Str3 addObject:_timerlistindex1];
                }else if (indexstr==3){
                    [_index_Str4 addObject:_timerlistindex1];
                }else if (indexstr==4){
                    [_index_Str5 addObject:_timerlistindex1];
                }else if (indexstr==5){
                    [_index_Str6 addObject:_timerlistindex1];
                }else if (indexstr==6){
                    [_index_Str7 addObject:_timerlistindex1];
                }
                
                
                
                
                
            }
        }else if (_notificationArray.count ==4){
            
            NSString * indexStr = notification.userInfo[@"cellIndex"][0];
            int indexstr = [indexStr intValue];
            
            [self.indexArray addObject:indexStr];
            _timerlistindex1= notification.userInfo[@"indexone"];
            _timerlistindex2= notification.userInfo[@"indextwo"];
            _timelistindex1 = [_timerlistindex1 intValue];
            _timelistindex2 = [_timerlistindex2 intValue];
            
            if (indexstr ==0) {
                [_index_Str1 addObject:_timerlistindex1];
                [_index_Str1 addObject:_timerlistindex2];
            }else if (indexstr==1){
                [_index_Str2 addObject:_timerlistindex1];
                [_index_Str2 addObject:_timerlistindex2];
            }else if (indexstr==2){
                [_index_Str3 addObject:_timerlistindex1];
                [_index_Str3 addObject:_timerlistindex2];
            }else if (indexstr==3){
                [_index_Str4 addObject:_timerlistindex1];
                [_index_Str4 addObject:_timerlistindex2];
            }else if (indexstr==4){
                [_index_Str5 addObject:_timerlistindex1];
                [_index_Str5 addObject:_timerlistindex2];
            }else if (indexstr==5){
                [_index_Str6 addObject:_timerlistindex1];
                [_index_Str6 addObject:_timerlistindex2];
            }else if (indexstr==6){
                [_index_Str7 addObject:_timerlistindex1];
                [_index_Str7 addObject:_timerlistindex2];
            }
            
            
            
        }else if (_notificationArray.count ==5){
            
            NSString * indexStr = notification.userInfo[@"cellIndex"][0];
            int indexstr = [indexStr intValue];
            [self.indexArray addObject:notification.userInfo[@"cellIndex"][0]];
            _timerlistindex1= notification.userInfo[@"indexone"];
            _timerlistindex2= notification.userInfo[@"indextwo"];
            _timerlistindex3= notification.userInfo[@"indexthere"];
            _timelistindex1 = [_timerlistindex1 intValue];
            _timelistindex2 = [_timerlistindex2 intValue];
            _timelistindex3 = [_timerlistindex3 intValue];
            
            if (indexstr ==0) {
                [_index_Str1 addObject:_timerlistindex1];
                [_index_Str1 addObject:_timerlistindex2];
                [_index_Str1 addObject:_timerlistindex3];
            }else if (indexstr==1){
                [_index_Str2 addObject:_timerlistindex1];
                [_index_Str2 addObject:_timerlistindex2];
                [_index_Str2 addObject:_timerlistindex3];
            }else if (indexstr==2){
                [_index_Str3 addObject:_timerlistindex1];
                [_index_Str3 addObject:_timerlistindex2];
                [_index_Str3 addObject:_timerlistindex3];
            }else if (indexstr==3){
                [_index_Str4 addObject:_timerlistindex1];
                [_index_Str4 addObject:_timerlistindex2];
                [_index_Str4 addObject:_timerlistindex3];
            }else if (indexstr==4){
                [_index_Str5 addObject:_timerlistindex1];
                [_index_Str5 addObject:_timerlistindex2];
                [_index_Str5 addObject:_timerlistindex3];
            }else if (indexstr==5){
                [_index_Str6 addObject:_timerlistindex1];
                [_index_Str6 addObject:_timerlistindex2];
                [_index_Str6 addObject:_timerlistindex3];
            }else if (indexstr==6){
                [_index_Str7 addObject:_timerlistindex1];
                [_index_Str7 addObject:_timerlistindex2];
                [_index_Str7 addObject:_timerlistindex3];
            }
            
        }
        
        NSLog(@"self.indexArray---%@",self.indexArray);
       
        for (NSNumber *number in self.indexArray) {
            [_itemindexdict setObject:number forKey:number];
        }
        NSLog(@"dict allValues---%@",[_itemindexdict allValues]);
        
        
        ////////
        
               if (_index_Str1.count >0) {
            
            for (NSNumber *number in self.index_Str1) {
                [_index_dict1 setObject:number forKey:number];
            }
            NSLog(@"dict1 ======allValues---%@",[_index_dict1 allValues]);
        }
        //
        if (_index_Str2.count >0) {
            
            for (NSNumber *number in self.index_Str2) {
                [_index_dict2 setObject:number forKey:number];
            }
            NSLog(@"dict2 allValues---%@",[_index_dict2 allValues]);
        }
        //
        if (_index_Str3.count >0) {
            
            for (NSNumber *number in self.index_Str3) {
                [_index_dict3 setObject:number forKey:number];
            }
            NSLog(@"dict3 allValues---%@",[_index_dict3 allValues]);
        }
        //
        if (_index_Str4.count >0) {
            
            for (NSNumber *number in self.index_Str4) {
                [_index_dict4 setObject:number forKey:number];
            }
            NSLog(@"dict4 allValues---%@",[_index_dict4 allValues]);
        }
        //
        if (_index_Str5.count >0) {
            
            for (NSNumber *number in self.index_Str5) {
                [_index_dict5 setObject:number forKey:number];
            }
            NSLog(@"dict5 allValues---%@",[_index_dict5 allValues]);
        }
        //
        if (_index_Str6.count >0) {
            
            for (NSNumber *number in self.index_Str6) {
                [_index_dict6 setObject:number forKey:number];
            }
            NSLog(@"dict6 allValues---%@",[_index_dict6 allValues]);
        }
        //
        if (_index_Str7.count >0) {
            
            for (NSNumber *number in self.index_Str7) {
                [_index_dict7 setObject:number forKey:number];
            }
            NSLog(@"dict7 allValues---%@",[_index_dict7 allValues]);
        }
        
    }
    
}
#pragma mark 确认弹框
-(void)clickScheduleview{
    if (self.lastTest_array.count >0) {
        if (self.lastTest_array.count >3) {
            [self showSVErrorString:@"您最多只能选择三个时间段"];
        }else{
            if (self.lastTest_array.count == 1) {
                NSArray * array = self.lastTest_array[0];
                if (array.count >4) {
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }else{
                    [self clickSchedule];
                }
            }else if (self.lastTest_array.count==2){
                NSArray * array = self.lastTest_array[0];
                NSArray * array1 = self.lastTest_array[1];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                int intstr = [str intValue];
                int intstr1 = [str1 intValue];
                int addint = intstr + intstr1 ;
                if (addint >5) {
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }else{
                     [self clickSchedule];
                }
                
                
                
            }else if (self.lastTest_array.count == 3){
                NSArray * array = self.lastTest_array[0];
                NSArray * array1 = self.lastTest_array[1];
                NSArray * array2 = self.lastTest_array[2];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                NSString * str2 = [NSString stringWithFormat:@"%lu",(unsigned long)array2.count];
                int intstr = [str intValue];
                int intstr1 = [str1 intValue];
                int intstr2 = [str2 intValue];
                int addint = intstr + intstr1 + intstr2;
                if (addint ==6) {
                    //[self clickSchedule];
                }else{
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }

            }
            
        }
    }else{
        
          [self showSVErrorString:@"您至少选择一个时间段"];
        
    }

}
-(void)clickSchedule{
    
    
    _dateAlertView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    _schedule_View = [[UIView alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTap)];
    [_schedule_View addGestureRecognizer:tap];

    _schedule_View.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [_dateAlertView addSubview:_schedule_View];
    if (kScreenWidth ==320) {
        if(self.totle_indexArray.count > 0){
            if (self.totle_indexArray.count == 1) {
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(30);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-30);
                    make.height.mas_equalTo(367);
                }];

            }else if (self.totle_indexArray.count == 2){
                
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(30);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-30);
                    make.height.mas_equalTo(426);
                }];
            }else if(self.totle_indexArray.count == 3){
                
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(30);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-30);
                    make.height.mas_equalTo(485);
                }];

                
            }
            
        }

    }else{
        if (self.totle_indexArray.count >0) {
            NSLog(@"%@",self.totle_indexArray);
            if (self.totle_indexArray.count == 1) {
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(52);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-52);
                    make.height.mas_equalTo(367);
                }];

            }else if (self.totle_indexArray.count == 2){
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(52);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-52);
                    make.height.mas_equalTo(426);
                }];

            }else if (self.totle_indexArray.count == 3){
                
                [_schedule_View mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(_dateAlertView.mas_top).offset(66);
                    make.left.mas_equalTo(_dateAlertView.mas_left).offset(52);
                    make.right.mas_equalTo(_dateAlertView.mas_right).offset(-52);
                    make.height.mas_equalTo(485);
                }];
            }
        }
        
    }
    UILabel * sheduleconfirm = [[UILabel alloc]init];
    sheduleconfirm.text = @"视频预约确认";
    sheduleconfirm.font = [UIFont systemFontOfSize:16];
    [sheduleconfirm setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    sheduleconfirm.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:sheduleconfirm];
    UIButton * cancleBtn = [[UIButton alloc]init];
    
    [cancleBtn setImage:[UIImage imageNamed:@"schedule_cancle_btn" ] forState:UIControlStateNormal];
    //[cancleBtn addTarget:self action:@selector(clickCancleBtn)  forControlEvents:UIControlEventTouchUpInside];
    UIView * clrearView = [[UIView alloc] init];
    clrearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickCancleBtn)];

    [clrearView addGestureRecognizer:tapRecognizer];
    [_schedule_View addSubview:clrearView];
    [_schedule_View addSubview:cancleBtn];
    [_schedule_View insertSubview:clrearView aboveSubview:cancleBtn];
    //[_scrollView  insertSubview:clrearView aboveSubview:cancleBtn];
    UILabel * scheduleConsult = [[UILabel alloc]init];
    scheduleConsult.text = @"预约顾问:";
    scheduleConsult.font = [UIFont systemFontOfSize:14];
    [scheduleConsult setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    scheduleConsult.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:scheduleConsult];
    //预约日期
    UILabel * scheduledate = [[UILabel alloc]init];
    scheduledate.text = @"预约日期:";
    scheduledate.font = [UIFont systemFontOfSize:14];
    [scheduledate setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    scheduledate.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:scheduledate];
    UILabel * nameText = [[UILabel alloc]init];
    nameText.text = _headModel.cnName;
    nameText.font = [UIFont systemFontOfSize:14];
    [nameText setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    nameText.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:nameText];
    //第一个
    UILabel * dateLableText = [[UILabel alloc]init];
     UILabel * USAtimeLableText = [[UILabel alloc]init];
    UILabel * timeLableText = [[UILabel alloc]init];
    if (self.itemArray2.count > 0) {
        
            NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[0]];
            int indexpath_M = [indexitem_M[0] intValue];
            int timeindex = [indexitem_M[1] intValue] - 10;
            dateLableText.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
        
        USAtimeLableText.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];

     
        timeLableText.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
    }
    
    dateLableText.font = [UIFont systemFontOfSize:13];
    [dateLableText setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    dateLableText.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:dateLableText];
    NSLog(@"%d",_timelistindex1);
    timeLableText.font = [UIFont systemFontOfSize:13];
    [timeLableText setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    timeLableText.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:timeLableText];
   
    
    USAtimeLableText.font = [UIFont systemFontOfSize:11];
    [USAtimeLableText setTextColor:[UIColor colorWithHexString:@"#b0b3b3"]];
    timeLableText.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:USAtimeLableText];
    //第二个
    //riqi
    UILabel * dateLableText2 = [[UILabel alloc]init];
    UILabel * timeLableText2 = [[UILabel alloc]init];
    UILabel * USAtimeLableText2 = [[UILabel alloc]init];
    if (self.itemArray2.count > 0) {
        if (self.itemArray2.count == 1) {
            
            NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[0]];
           
                
                if (indexitem_M.count == 3) {
                    
                    int indexpath_M = [indexitem_M[0] intValue];
                    int timeindex = [indexitem_M[2] intValue] -10;
                    
                    dateLableText2.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                    USAtimeLableText2.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
                    
                    //            dateLableText.text =[NSString stringWithFormat:@"%@ %@",_listArray[0]][@"date"],_listArray[_indexItem.row][@"weekName"]];
                    
                    timeLableText2.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                }else if (indexitem_M.count == 4){
                    int indexpath_M = [indexitem_M[0] intValue];
                    int timeindex = [indexitem_M[2] intValue] -10;
                    
                    dateLableText2.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                    USAtimeLableText2.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
                    
                    //            dateLableText.text =[NSString stringWithFormat:@"%@ %@",_listArray[0]][@"date"],_listArray[_indexItem.row][@"weekName"]];
                    
                    timeLableText2.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                }
         
        }else if (self.itemArray2.count == 2){
            NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[0]];
            NSArray * indexitem_M1 = [NSArray arrayWithArray:self.itemArray2[1]];
            if (indexitem_M.count == 2) {
                  int indexpath_M = [indexitem_M1[0] intValue];
                
                 int timeindex = [indexitem_M1[1] intValue] -10;
                NSLog(@"%d",timeindex);
                NSLog(@"%@",_listArray[indexpath_M][@"timeList"][timeindex]);
                 dateLableText2.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                 timeLableText2.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                USAtimeLableText2.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
                
                //            dateLableText.text =[NSString stringWithFormat:@"%@ %@",_listArray[0]][@"date"],_listArray[_indexItem.row][@"weekName"]];
                
                
                NSLog(@"%@",timeLableText2.text);
            }else if (indexitem_M.count == 3){
                 int indexpath_M = [indexitem_M[0] intValue];
                 int timeindex = [indexitem_M[2] intValue]-10;
                
                dateLableText2.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                 timeLableText2.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                USAtimeLableText2.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];


            }
            
        }else if (self.itemArray2.count == 3){
             NSArray * indexitem_M1 = [NSArray arrayWithArray:self.itemArray2[1]];
             int indexpath_M = [indexitem_M1[0] intValue];
            int timeindex = [indexitem_M1[1] intValue]-10;
            
            dateLableText2.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
             timeLableText2.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
            USAtimeLableText2.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
        }
        
        
    }

    
    dateLableText2.font = [UIFont systemFontOfSize:13];
    [dateLableText2 setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    dateLableText2.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:dateLableText2];
    
   
    timeLableText2.font = [UIFont systemFontOfSize:13];
    [timeLableText2 setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    timeLableText2.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:timeLableText2];
       USAtimeLableText2.font = [UIFont systemFontOfSize:11];
    [USAtimeLableText2 setTextColor:[UIColor colorWithHexString:@"#b0b3b3"]];
    USAtimeLableText2.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:USAtimeLableText2];
    //第三个
    UILabel * dateLableText3 = [[UILabel alloc]init];
    UILabel * timeLableText3 = [[UILabel alloc]init];
    UILabel * USAtimeLableText3 = [[UILabel alloc]init];
    if (self.itemArray2.count >0) {
        if (self.itemArray2.count == 1) {
              NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[0]];
            if (indexitem_M.count >3) {
                
                int indexpath_M = [indexitem_M[0] intValue];
                int timeindex = [indexitem_M[3] intValue] -10;
                dateLableText3.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                timeLableText3.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                USAtimeLableText3.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
            }
        }else if (self.itemArray2.count == 2){
            NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[0]];
            NSArray * indexitem_M1 = [NSArray arrayWithArray:self.itemArray2[1]];
            if (indexitem_M.count == 2) {
                int indexpath_M = [indexitem_M1[0] intValue];
                int timeindex;
                if (indexitem_M1.count>2){
                    
                timeindex = [indexitem_M1[2] intValue] - 10;
                    dateLableText3.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                    timeLableText3.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                    USAtimeLableText3.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
                    
                }
            
            }else if (indexitem_M.count == 3){
                int indexpath_M = [indexitem_M1[0] intValue];
                int timeindex = [indexitem_M1[1] intValue] -10;
                dateLableText3.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
                timeLableText3.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];
                USAtimeLableText3.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];            }
            
        }else if (self.itemArray2.count == 3){
            NSArray * indexitem_M = [NSArray arrayWithArray:self.itemArray2[2]];
            int indexpath_M = [indexitem_M[0] intValue];
            int timeindex = [indexitem_M[1] intValue] -10;
            dateLableText3.text = [NSString stringWithFormat:@"%@ %@",_listArray[indexpath_M][@"date"],_listArray[indexpath_M][@"weekName"]];
            timeLableText3.text =[NSString stringWithFormat:@"%@-%@",_listArray[indexpath_M][@"timeList"][timeindex][@"cnStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"cnEndTime"]];

             USAtimeLableText3.text = [NSString stringWithFormat:@"(美国时间 %@-%@)",_listArray[indexpath_M][@"timeList"][timeindex][@"otherStartTime"],_listArray[indexpath_M][@"timeList"][timeindex][@"otherEndTime"]];
        }
    
    
    }
   
    dateLableText3.font = [UIFont systemFontOfSize:13];
    [dateLableText3 setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    dateLableText3.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:dateLableText3];
    
    
    timeLableText3.font = [UIFont systemFontOfSize:13];
    [timeLableText3 setTextColor:[UIColor colorWithHexString:@"#26bdab"]];
    timeLableText3.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:timeLableText3];
       USAtimeLableText3.font = [UIFont systemFontOfSize:11];
    [USAtimeLableText3 setTextColor:[UIColor colorWithHexString:@"#b0b3b3"]];
    USAtimeLableText3.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:USAtimeLableText3];
    
   //留言
    UILabel * leaveMessage = [[UILabel alloc]init];
    leaveMessage.text = @"留言:";
    leaveMessage.font = [UIFont systemFontOfSize:14];
    [leaveMessage setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    leaveMessage.textAlignment =  NSTextAlignmentLeft;
    [_schedule_View addSubview:leaveMessage];
    //输入框
    UIView *boundView = [[UIView alloc] init];
    boundView.backgroundColor = [UIColor clearColor];
    boundView.layer.borderWidth = 0.5;
    boundView.layer.cornerRadius = 2;
    boundView.layer.borderColor = RGB(227, 227, 227).CGColor;
   // [_schedule_View addSubview:boundView];
    UIImageView *triangleImageV = [[UIImageView alloc] init];
    triangleImageV.image = [UIImage imageNamed:@"Schedule_triangle"];
    //[boundView addSubview:triangleImageV];
    _leaveMessage = [[UIView alloc]init];
    _leaveMessage.backgroundColor = [UIColor clearColor];
    NSArray * leaveMessageArray =@[@"初次沟通",@"考试规则",@"课外活动",@"选校指导",@"文书指导",@"例行会面"];
    for (int i = 0;i< leaveMessageArray.count; i++) {
        //NSString * strtag = [NSString stringWithFormat:@"%@",_consultCanArray[i][@"lableId"]];
        NSInteger index = i % 2;
        NSInteger page = i / 2;
        CGFloat width = 70;
        CGFloat widthSpace = 7;
        CGFloat hight = 20;
        CGFloat hightSpace = 8;
        UIButton * messageBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        ;
       // NSInteger k = [strtag integerValue];
        messageBtn.tag =i +10;
        messageBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        messageBtn.layer.borderWidth = 0.5f;
        messageBtn.layer.cornerRadius = 7;
        messageBtn.clipsToBounds = YES;
        messageBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        messageBtn.backgroundColor = [UIColor clearColor];
        [messageBtn setTitle:leaveMessageArray[i] forState:UIControlStateNormal];
        [messageBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal];
        [messageBtn addTarget:self action:@selector(clickMessageBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        messageBtn.frame = CGRectMake( index *(width + widthSpace), page*(
                                                                              hight + hightSpace )                      , width, hight);
        //messageBtn.frame = CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        [_leaveMessage addSubview:messageBtn];
        
    }
    

    [_schedule_View addSubview:_leaveMessage];
    _leaveMessageView = [[UITextView alloc] init];
    _leaveMessageView.delegate = self;
    _leaveMessageView.layer.borderWidth = 0.5;
    _leaveMessageView.layer.borderColor = RGB(227, 227, 227).CGColor;
    [_schedule_View addSubview:_leaveMessageView];
    UIButton * confirBtn = [[UIButton alloc]init];
    [confirBtn setTitle:@"确认" forState:UIControlStateNormal];
    confirBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [confirBtn setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
    confirBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [confirBtn addTarget:self action:@selector(click_sendconfirmBtn) forControlEvents: UIControlEventTouchUpInside];
    [_schedule_View addSubview:confirBtn];


    //[view addSubview:self.pickerView];
    [sheduleconfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_schedule_View.mas_top).offset(15);
        make.centerX.mas_equalTo(_schedule_View.mas_centerX);
      
        make.size.mas_equalTo(CGSizeMake(97, 16));
    }];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sheduleconfirm.mas_top);
        make.right.mas_equalTo(_schedule_View.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12, 13));
    }];
    [clrearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancleBtn.mas_top).offset(-10);
        make.right.mas_equalTo(_schedule_View.mas_right);
        make.size.mas_equalTo(CGSizeMake(32, 33));
    }];

    [scheduleConsult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_schedule_View.mas_top).offset(50);
        make.left.mas_equalTo(_schedule_View.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(71, 14));
        
    }];
    [scheduledate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scheduleConsult.mas_bottom).offset(13);
        make.left.mas_equalTo(_schedule_View.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(71, 14));
        
    }];
    [nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scheduleConsult.mas_top);
        make.left.mas_equalTo(scheduleConsult.mas_right);
        make.size.mas_equalTo(CGSizeMake(95, 14));
    }];
    
    [dateLableText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(scheduledate.mas_top);
        make.left.mas_equalTo(scheduledate.mas_right);
        make.size.mas_equalTo(CGSizeMake(95, 13));
    }];
    [timeLableText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(dateLableText.mas_bottom).offset(7);
        make.left.mas_equalTo(scheduledate.mas_right);
        make.size.mas_equalTo(CGSizeMake(90, 13));
    }];
    [USAtimeLableText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLableText.mas_bottom).offset(7);
        make.left.mas_equalTo(scheduledate.mas_right);
        make.size.mas_equalTo(CGSizeMake(125, 11));
    }];
//    [dateLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(USAtimeLableText2.mas_bottom).offset(10);
//        make.left.mas_equalTo(scheduledate.mas_right);
//        make.size.mas_equalTo(CGSizeMake(95, 13));
//    }];
//    [timeLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(dateLableText3.mas_bottom).offset(7);
//        make.left.mas_equalTo(scheduledate.mas_right);
//        make.size.mas_equalTo(CGSizeMake(90, 13));
//    }];
//    [USAtimeLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(timeLableText3.mas_bottom).offset(7);
//        make.left.mas_equalTo(scheduledate.mas_right);
//        make.size.mas_equalTo(CGSizeMake(125, 11));
//    }];
    if (self.totle_indexArray.count>0) {
        if (self.totle_indexArray.count == 1) {
            
            [leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_schedule_View.mas_bottom).offset(-228);
                make.left.mas_equalTo(_schedule_View.mas_left).offset(20);
                make.size.mas_equalTo(CGSizeMake(33, 14));
            }];
            [dateLableText2 removeFromSuperview];
             [timeLableText2 removeFromSuperview];
             [USAtimeLableText2 removeFromSuperview];
            [dateLableText3 removeFromSuperview];
            [timeLableText3 removeFromSuperview];
            [USAtimeLableText3 removeFromSuperview];
            
        }else if (self.totle_indexArray.count == 2){
            [leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_schedule_View.mas_bottom).offset(-218);
                make.left.mas_equalTo(_schedule_View.mas_left).offset(20);
                make.size.mas_equalTo(CGSizeMake(33, 14));
            }];
            [dateLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(USAtimeLableText.mas_bottom).offset(10);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(95, 13));
            }];
            [timeLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(dateLableText2.mas_bottom).offset(7);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(90, 13));
            }];
            [USAtimeLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(timeLableText2.mas_bottom).offset(7);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(125, 11));
            }];
            [dateLableText3 removeFromSuperview];
            [timeLableText3 removeFromSuperview];
            [USAtimeLableText3 removeFromSuperview];


        }else if (self.totle_indexArray.count == 3){
            [leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_schedule_View.mas_bottom).offset(-218);
                make.left.mas_equalTo(_schedule_View.mas_left).offset(20);
                make.size.mas_equalTo(CGSizeMake(33, 14));
            }];

            [dateLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(USAtimeLableText.mas_bottom).offset(10);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(95, 13));
            }];
            [timeLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(dateLableText2.mas_bottom).offset(7);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(90, 13));
            }];
            [USAtimeLableText2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(timeLableText2.mas_bottom).offset(7);
                make.left.mas_equalTo(scheduledate.mas_right);
                make.size.mas_equalTo(CGSizeMake(125, 11));
            }];

                [dateLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(USAtimeLableText2.mas_bottom).offset(10);
                    make.left.mas_equalTo(scheduledate.mas_right);
                    make.size.mas_equalTo(CGSizeMake(95, 13));
                }];
                [timeLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(dateLableText3.mas_bottom).offset(7);
                    make.left.mas_equalTo(scheduledate.mas_right);
                    make.size.mas_equalTo(CGSizeMake(90, 13));
                }];
                [USAtimeLableText3 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(timeLableText3.mas_bottom).offset(7);
                    make.left.mas_equalTo(scheduledate.mas_right);
                    make.size.mas_equalTo(CGSizeMake(125, 11));
                }];

        }
    }
    
       [_leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leaveMessage.mas_top);
        
        make.left.mas_equalTo(leaveMessage.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(157, 77));
    }];
    [_leaveMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_leaveMessage.mas_bottom).offset(12);
        make.left.mas_equalTo(_schedule_View.mas_left).offset(26);
        make.right.mas_equalTo(_schedule_View.mas_right).offset(-26);
        make.height.mas_equalTo(72);
    }];
    [confirBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_schedule_View.mas_bottom);
        make.left.mas_equalTo(_schedule_View.mas_left);
        make.right.mas_equalTo(_schedule_View.mas_right);
        make.height.mas_equalTo(36);
    }];
           _dateAlertView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
     [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_dateAlertView];
   
    
    //_dateView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    // [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_dateView];

}
-(void)clickCancleBtn{
    
    [_dateAlertView removeFromSuperview];
    
}
- (void)createTimeInputView {
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    topView.backgroundColor = [UIColor colorWithHexString:@"26bdab"];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(0, 10, 50, 20);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(hiddenInputView) forControlEvents:UIControlEventTouchUpInside];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:cancleBtn];
    
    UIButton *suerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    suerBtn.frame = CGRectMake(kScreenWidth-50, 10, 50, 20);
    [suerBtn addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [suerBtn setTitle:@"确定" forState:UIControlStateNormal];
    suerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [topView addSubview:suerBtn];
    
    NSArray *pickViewTimeArr = @[@"初次沟通了解"
                                 ,@"初次沟通了解1"
                                 ,@"初次沟通了解2"
                                 ,@"初次沟通了解3"
                                 ];
    _accessoryView = topView;
    _pickerView = [[UGPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 140) andTitleArr:nil];
    _pickerView.titleArray = pickViewTimeArr;
    
   // _datapickView = [[UGDataPickView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 140)];
}
-(void)sureButtonClick{
   
    //NSInteger row = [_pickerView.pv selectedRowInComponent:0];
    //_leaveMessage.text = _pickerView.titleArray[row];
    [_leaveMessage resignFirstResponder];
   

}
-(void)hiddenInputView{
     [_leaveMessage resignFirstResponder];
    _pickerView.hidden = YES;
}
//防止短时间内重复点击 时间0.5
- (void)starButtonClicked:(id)sender
{
    //先将未到时间执行前的任务取消。
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(click_sendconfirmBtn) object:sender];
    [self performSelector:@selector(click_sendconfirmBtn) withObject:sender afterDelay:0.5f];
}


#pragma mark 发送预约网络请求
- (void)click_sendconfirmBtn{
    
    __weak UGSchedulingViewController *weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = self.counselorId ;
   
    params[@"message"] = _beuzhuTextView.text;
    
    
  //  _groupArray   _saveDateArray
    
    
    if (_saveDateArray.count > 0) {
        //
        if (_saveDateArray.count >3) {
            [self showSVErrorString:@"您最多只能选择三个时间段"];
        }else{
            
            if (_saveDateArray.count == 1) {
                
                NSArray * array = _saveDateArray[0];
                 if (array.count >5) {
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                 }else{
                     NSArray * itemArrayM = [NSArray arrayWithArray:_saveDateArray[0]];
                     //int indexpath = [itemArrayM[0] intValue] ;
                     NSArray * dayindexArray = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM[0] ]];
                     int dayindex = [itemArrayM[1] intValue];
                     AdvanceDateList * model = [AdvanceDateList mj_objectWithKeyValues:dayindexArray[dayindex]];
                    
                     
                     if (itemArrayM.count == 3) {
                    //  修改 到这里   advanced   将  ID  改为   advanced； todo
                         int advanceIdint = [itemArrayM[2] intValue] - 10;
                       
                         AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                         
                         NSString * advanceId = timeListModel.advanceTimeId;
                         
                         NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId];
                         params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                         
                     }else if (itemArrayM.count == 4){
                         int advanceIdint = [itemArrayM[2] intValue]-10;
                         AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                         
                         NSString * advanceId = timeListModel.advanceTimeId;
                        
                         
                         
                         
                         int advanceIdint1= [itemArrayM[3] intValue]-10;
                         
                         AdanceTimeList * timeListModel1 = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint1]];
                         
                         NSString * advanceId1 = timeListModel1.advanceTimeId;

                       
                         
                         NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model.advanceDate,advanceId1];
                         
                         params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                         
                     }else if (itemArrayM.count == 5){
                         int advanceIdint = [itemArrayM[2] intValue]-10;
                         AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                         
                         NSString * advanceId = timeListModel.advanceTimeId;

                         
                         
                         int advanceIdint1= [itemArrayM[3] intValue]-10;
                         AdanceTimeList * timeListModel1 = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint1]];
                         
                         NSString * advanceId1 = timeListModel1.advanceTimeId;
                         
                         
                         
                         
                         

                         int advanceIdint2= [itemArrayM[4] intValue]-10;
                         AdanceTimeList * timeListModel2 = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint2]];
                         
                         NSString * advanceId2 = timeListModel2.advanceTimeId;
                         NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model.advanceDate,advanceId1,model.advanceDate,advanceId2];
                         
                         params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                     }

                     
                     NSLog(@"params ---------- %@",params);
                     
                     NSLog(@"dsd");
                     [SVProgressHUD show];
                     [HttpClientManager getAsyn:addAdvanceClient params:params success:^(id json) {
                         [SVProgressHUD dismiss];
                         MsgModel * model = [MsgModel mj_objectWithKeyValues:json[@"header"]];
                         if ([model.code isEqualToString:@"200"]) {
                             
                             [self successSchedule];
                             
                             
                             //[weakSelf showSVSuccessWithStatus:@"发送成功"];
                         }else if ([model.code isEqualToString:@"400"]){
                             
                             [weakSelf showSVErrorString:model.message];
                             
                         }else if ([model.code isEqualToString:@"405"]){
                             [SVProgressHUD dismiss];
                             [weakSelf showSVErrorString:model.message];
                             
                         }
                         
                         
                     } failure:^(NSError *error) {
                         
                         [weakSelf showSVErrorString:@"请检查您的网络"];
                         // [self successSchedule];
                         
                     }];
                     
 
                     
                 }
            }else if (_saveDateArray.count==2){
                NSArray * array = _saveDateArray[0];
                NSArray * array1 =_saveDateArray[1];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                int intstr = [str intValue];
                int intstr1 = [str1 intValue];
                int addint = intstr + intstr1 ;
                if (addint >7) {
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }else{
                  // _saveDateArray.count==2
                    
                    //点击两个不同
                    NSArray * itemArrayM = [NSArray arrayWithArray:_saveDateArray[0]];
                    NSArray * itemArrayM1 = [NSArray arrayWithArray:_saveDateArray[1]];
                    NSArray * dayindexArray = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM[0] ]];
                    int dayindex = [itemArrayM[1] intValue];
                    AdvanceDateList * model = [AdvanceDateList mj_objectWithKeyValues:dayindexArray[dayindex]];
                    NSArray * dayindexArray1 = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM1[0] ]];
                    int dayindex1 = [itemArrayM1[1] intValue];
                    AdvanceDateList * model1 = [AdvanceDateList mj_objectWithKeyValues:dayindexArray1[dayindex1]];
                    if (itemArrayM.count==3) {
                        if (itemArrayM1.count == 3) {
                            int advanceIdint = [itemArrayM[2] intValue]-10;
                            AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                            
                            NSString * advanceId = timeListModel.advanceTimeId;
                            int advanceIdint1= [itemArrayM1[2] intValue]-10;
                            AdanceTimeList * timeListModel1 = [AdanceTimeList mj_objectWithKeyValues:model1.timeList[advanceIdint1]];
                            
                            NSString * advanceId1 = timeListModel1.advanceTimeId;
                            
                            
                            NSLog(@"advanceId==%@----advanceId==%@",advanceId,advanceId1);
                            NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model1.advanceDate,advanceId1];
                            params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                        }else if (itemArrayM1.count == 4){
                            
                            int advanceIdint = [itemArrayM[2] intValue] -10;
                            AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                            
                            NSString * advanceId = timeListModel.advanceTimeId;
                            
                            int advanceIdint1= [itemArrayM1[2] intValue] -10 ;
                            AdanceTimeList * timeListModel1 = [AdanceTimeList mj_objectWithKeyValues:model1.timeList[advanceIdint1]];
                            
                            NSString * advanceId1 = timeListModel1.advanceTimeId;

                            int advanceIdint2= [itemArrayM1[3] intValue] -10;
                            AdanceTimeList * timeListModel2 = [AdanceTimeList mj_objectWithKeyValues:model1.timeList[advanceIdint2]];
                            
                            NSString * advanceId2 = timeListModel2.advanceTimeId;

                            
                            
                            
                            
                            NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model1.advanceDate,advanceId1,model1.advanceDate,advanceId2];
                            
                            params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                        }
                        
                        
                        
                        
                    }else if (itemArrayM.count ==4){
                        
                        int advanceIdint = [itemArrayM[2] intValue]-10;
                        AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                        
                        NSString * advanceId = timeListModel.advanceTimeId;

                        int advanceIdint1= [itemArrayM[3] intValue]-10;
                        AdanceTimeList * timeListModel1 = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint1]];
                        
                        NSString * advanceId1 = timeListModel1.advanceTimeId;
                        int advanceIdint2= [itemArrayM1[2] intValue]-10;
                        AdanceTimeList * timeListModel2 = [AdanceTimeList mj_objectWithKeyValues:model1.timeList[advanceIdint2]];
                        
                        NSString * advanceId2 = timeListModel2.advanceTimeId;
                        
                        
                        NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model.advanceDate,advanceId1,model1.advanceDate,advanceId2];
                        params[@"advanceDateTimeJson"] = advanceDateTimeJson;
                    }
                    
                    
                    NSLog(@"params ---------- %@",params);
                    
                    NSLog(@"dsd");
                    [SVProgressHUD show];
                    [HttpClientManager getAsyn:addAdvanceClient params:params success:^(id json) {
                        [SVProgressHUD dismiss];
                        MsgModel * model = [MsgModel mj_objectWithKeyValues:json[@"header"]];
                        if ([model.code isEqualToString:@"200"]) {
                            
                            [self successSchedule];
                            
                            
                            //[weakSelf showSVSuccessWithStatus:@"发送成功"];
                        }else if ([model.code isEqualToString:@"400"]){
                            
                            [weakSelf showSVErrorString:model.message];
                            
                        }else if ([model.code isEqualToString:@"405"]){
                            
                            [weakSelf showSVErrorString:model.message];
                            
                        }
                        
                        
                    } failure:^(NSError *error) {
                        [SVProgressHUD dismiss];
                        [weakSelf showSVErrorString:@"请检查您的网络"];
                        // [self successSchedule];
                        
                    }];
                    

                    
                }
                
                
                
            }else if (_saveDateArray.count == 3){
                NSArray * array = _saveDateArray[0];
                NSArray * array1 = _saveDateArray[1];
                NSArray * array2 = _saveDateArray[2];
                NSString * str = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
                NSString * str1 = [NSString stringWithFormat:@"%lu",(unsigned long)array1.count];
                NSString * str2 = [NSString stringWithFormat:@"%lu",(unsigned long)array2.count];
                int intstr = [str intValue];
                int intstr1 = [str1 intValue];
                int intstr2 = [str2 intValue];
                int addint = intstr + intstr1 + intstr2;
                NSLog(@"%d",addint);
                if (addint ==9) {
                    //三个
                    NSArray * itemArrayM = [NSArray arrayWithArray:_saveDateArray[0]];
                    NSArray * itemArrayM1 = [NSArray arrayWithArray:_saveDateArray[1]];
                    NSArray * itemArrayM2 = [NSArray arrayWithArray:_saveDateArray[2]];
                    NSArray * dayindexArray = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM[0] ]];
                    int dayindex = [itemArrayM[1] intValue];
                    AdvanceDateList * model = [AdvanceDateList mj_objectWithKeyValues:dayindexArray[dayindex]];
                    
                    
                    NSArray * dayindexArray1 = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM1[0] ]];
                    int dayindex1= [itemArrayM1[1] intValue];
                    AdvanceDateList * model1 = [AdvanceDateList mj_objectWithKeyValues:dayindexArray1[dayindex1]];
                    
                    
                    
                    NSArray * dayindexArray2 = [NSArray arrayWithArray:[_groupArray objectForKey:itemArrayM2[0] ]];
                    int dayindex2 = [itemArrayM2[1] intValue];
                    AdvanceDateList * model2 = [AdvanceDateList mj_objectWithKeyValues:dayindexArray2[dayindex2]];
                    
                    
                    
                    int advanceIdint = [itemArrayM[2] intValue]-10;
                    AdanceTimeList * timeListModel = [AdanceTimeList mj_objectWithKeyValues:model.timeList[advanceIdint]];
                    
                    NSString * advanceId = timeListModel.advanceTimeId;
                    int advanceIdint1= [itemArrayM1[2] intValue]-10;
                    
                    AdanceTimeList * timeListModel1= [AdanceTimeList mj_objectWithKeyValues:model1.timeList[advanceIdint1]];
                    
                    NSString * advanceId1 = timeListModel1.advanceTimeId;

                  
                    int advanceIdint2= [itemArrayM2[2] intValue]-10;
                    AdanceTimeList * timeListModel2= [AdanceTimeList mj_objectWithKeyValues:model2.timeList[advanceIdint2]];
                    
                    NSString * advanceId2 = timeListModel2.advanceTimeId;
                    
                    NSString * advanceDateTimeJson = [NSString stringWithFormat:@"{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@},{advanceDate=%@,advanceTimeId=%@}",model.advanceDate,advanceId,model1.advanceDate,advanceId1,model2.advanceDate,advanceId2];
                    params[@"advanceDateTimeJson"] = advanceDateTimeJson;
 
                    
                    
                    NSLog(@"params ---------- %@",params);
                    
                    NSLog(@"dsd");
                    [SVProgressHUD show];
                    [HttpClientManager getAsyn:addAdvanceClient params:params success:^(id json) {
                        [SVProgressHUD dismiss];
                        MsgModel * model = [MsgModel mj_objectWithKeyValues:json[@"header"]];
                        if ([model.code isEqualToString:@"200"]) {
                            
                            [self successSchedule];
                            
                            
                            //[weakSelf showSVSuccessWithStatus:@"发送成功"];
                        }else if ([model.code isEqualToString:@"400"]){
                            
                            [weakSelf showSVErrorString:model.message];
                            
                        }else if ([model.code isEqualToString:@"405"]){
                            
                            [weakSelf showSVErrorString:model.message];
                            
                        }
                        
                        
                    } failure:^(NSError *error) {
                        [SVProgressHUD dismiss];
                        [weakSelf showSVErrorString:@"请检查您的网络"];
                        // [self successSchedule];
                        
                    }];
                    
 
                    
                    
                    
                }else{
                    [self showSVErrorString:@"您最多只能选择三个时间段"];
                }
            }
            
            
         
            
        }

        
        
        
        
        
        
        //
        
        
        
        
        
        
        
        
        
        
        
        
    }else{
        
      [self showSVErrorString:@"请至少选择一个时间段"];
    }
    
    
    
    
    
    //[_dateAlertView removeFromSuperview];
    
    

    
    
}
#pragma mark 预约成功评价框
-(void)successSchedule{
    
   
    self.alretView.frame=CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.alretView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:self.alretView];
    //背景
    UIView * backview = [[UIView alloc]init];
    backview.layer.cornerRadius = 6.0f;
    backview.backgroundColor = [UIColor whiteColor];
    [self.alretView addSubview:backview];
    //tupian
    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alert_calendaralert"]];
    
    [backview addSubview:imageview];
    //lable
    
    UILabel * lable1 = [[UILabel alloc]init];
    lable1.text = @"预约成功";
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.font = [UIFont systemFontOfSize:18];
    lable1.textColor = [UIColor colorWithHexString:@"#535353"];
    [backview addSubview:lable1];
    UILabel * lable2 = [[UILabel alloc]init];
    lable2.text = @"等待顾问确认";
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.font = [UIFont systemFontOfSize:18];
    lable2.textColor = [UIColor colorWithHexString:@"#535353"];
    [backview addSubview:lable2];
    
    UILabel * lable3 = [[UILabel alloc]init];
    lable3.text = @"完善资料可提高预约成功率哦~";
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.font = [UIFont systemFontOfSize:16];
    lable3.textColor = [UIColor colorWithHexString:@"#bfbfbf"];
    [backview addSubview:lable3];
    
    UIButton * button= [[UIButton alloc]init];
    [button setTitle:@"去完善资料" forState:0];
    
    [button setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:0];
    [button addTarget:self action:@selector(gotoprofile) forControlEvents:UIControlEventTouchUpInside  ];
    //button.backgroundColor = [UIColor redColor];
    [backview addSubview:button];
    //取消按钮
    
    UIButton * cancleBtn = [[UIButton alloc]init];
    
    [cancleBtn setImage:[UIImage imageNamed:@"schedule_cancle_btn" ] forState:UIControlStateNormal];
    //[cancleBtn addTarget:self action:@selector(clickCancleBtn)  forControlEvents:UIControlEventTouchUpInside];
    UIView * clrearView = [[UIView alloc] init];
    clrearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *success_tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(success_clickCancleBtn)];
    
    [clrearView addGestureRecognizer:success_tapRecognizer];
    [backview addSubview:clrearView];
    [backview addSubview:cancleBtn];
    [backview insertSubview:clrearView aboveSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backview.mas_top).offset(16);
        make.right.mas_equalTo(backview.mas_right).offset(-16);
        make.size.mas_equalTo(CGSizeMake(15, 16));
    }];
    [clrearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancleBtn.mas_top).offset(-10);
        make.right.mas_equalTo(backview.mas_right);
        make.size.mas_equalTo(CGSizeMake(32, 33));
    }];
    

    
    
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alretView.mas_top).offset(kScreenHeight * 0.2);
        make.centerX.mas_equalTo(self.alretView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(285, 352));
         }];
    
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backview.mas_top).offset(27);
        make.centerX.mas_equalTo(backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    [lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageview.mas_bottom).offset(27);
        make.centerX.mas_equalTo(backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    [lable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable1.mas_bottom);
        make.centerX.mas_equalTo(backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(140, 20));
    }];
    [lable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lable2.mas_bottom).offset(5);
        make.centerX.mas_equalTo(backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(230, 20));
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(backview.mas_bottom).offset(-30);
        make.centerX.mas_equalTo(backview.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 17));
    }];


    

    
    
}
//预约成功 后点击X
-(void)success_clickCancleBtn{
    
    
    
    [self.alretView removeFromSuperview];
    
    UGMyScheduleViewController * vc = [[UGMyScheduleViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    
    
    [self.navigationController pushViewController:vc animated:YES];

    
    
    
}
//点击 完善资料
-(void)gotoprofile{
    
    
    //NSLog(@"个人资料");
    [self.alretView removeFromSuperview];
    UGProfileViewController *vc  =[[UGProfileViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self pushToNextViewController:vc];
    
    
}
//
-(void)click_conBtn{
    [self.alretView removeFromSuperview];
    
    UGMyScheduleViewController * vc = [[UGMyScheduleViewController alloc]init];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
-(void)clickTap{
    [_leaveMessageView resignFirstResponder];
    [_scrollView endEditing:YES];
    [self hiddenInputView];
}
#pragma mark 留言按钮
-(void)clickMessageBtn:(UIButton *)sender{
    
    if (_messageBtn ==sender) {
        
    }else{
        
        sender.backgroundColor = RGB(38, 189, 171);
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _message=sender.titleLabel.text;
        _messageBtn.backgroundColor = [UIColor whiteColor];
        _messageBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [_messageBtn setTitleColor: [UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal];
        _messageBtn.layer.masksToBounds = YES;
    }
    
    
    _messageBtn = sender;
    

}
//- (void)textViewDidBeginEditing:(UITextView *)textView{
//    
//    
//    NSLog(@"进入编辑模式");
//    if (kScreenWidth ==320) {
//        [_schedule_View mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_dateAlertView.mas_top).offset(-70);
//            
//            make.left.mas_equalTo(_dateAlertView.mas_left).offset(30);
//            make.right.mas_equalTo(_dateAlertView.mas_right).offset(-30);
//            make.height.mas_equalTo(375);
//        }];
//        
//    }else{
//        
//        
//        [_schedule_View mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_dateAlertView.mas_top);
//            
//            make.left.mas_equalTo(_dateAlertView.mas_left).offset(52);
//            make.right.mas_equalTo(_dateAlertView.mas_right).offset(-52);
//            make.height.mas_equalTo(375);
//        }];
//    }
//    [_dateAlertView layoutIfNeeded];
//    
//}
- (void)keyboard_Show:(NSNotification *)nf {
    //获取键盘的高度
    NSDictionary *info = [nf userInfo];
    
   [UIView animateWithDuration:0.25 animations:^{
       _scrollView.frame = CGRectMake(0, -200,  kScreenWidth, kScreenHeight- 44 - 64);
        //_scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 44 - 64);
       
   } completion:^(BOOL finished) {
       
   }];
        
        
        
      
  
    
}
- (void)keyboard_Hidden:(NSNotification *)nf {
    
    
    [UIView animateWithDuration:0.25 animations:^{
        //_scrollView.frame = CGRectMake(0, -200,  kScreenWidth, kScreenHeight- 44 - 64);
        _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight- 44 - 64);
        
    } completion:^(BOOL finished) {
        
    }];

    
    
    
     }

#pragma mark  TextVIew daili
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];//按回车取消第一相应者
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.placeholderStr.alpha = 0;//开始编辑时
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{//将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        self.placeholderStr.alpha = 1;
    }
    return YES;
}


#pragma mark pickerVIew 代理方法
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return 1;
//}
//
//// returns the # of rows in each component..
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    
//    return self.pickerArray.count;
//    
//}
//- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    NSString * str = [self.pickerArray objectAtIndex:row];
//    return str;
//    
//    
//    
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
