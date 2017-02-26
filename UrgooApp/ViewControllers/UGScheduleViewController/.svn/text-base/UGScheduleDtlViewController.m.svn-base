//
//  UGScheduleDtlViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGScheduleDtlViewController.h"
#import "UGConsultHeadView.h"
#import "Masonry.h"
#import "AdvanceCounselorInfo.h"
#import "AdanceTimeList.h"
#import "MsgModel.h"
#import "UGEvaluationView.h"
#import "UGUderstandSeverViewController.h"
#import "UGChatViewController.h"
#import "UGSchedulingViewController.h"
#import "UGEvaluationViewController.h"
#import "UGAdvanCancleReasonViewController.h"
#import "UGGotovideoHelpViewController.h"
@interface UGScheduleDtlViewController ()<UITextViewDelegate>
@property (strong,nonatomic)UGConsultHeadView * headView;
@property (strong,nonatomic)UIView * stateView;
@property (strong,nonatomic)UILabel * stateLable;
@property (strong,nonatomic)UIView * scheduleTimeView1;
@property (strong,nonatomic)UIView * scheduleTimeView2;
@property (strong,nonatomic)UIView * scheduleTimeView3;
@property (strong,nonatomic)UILabel * timelable;
@property (strong,nonatomic)UILabel * timelable1;
@property (strong,nonatomic)UILabel * timelable2;
@property (strong,nonatomic)UITextView * leaveMessageView;
@property (strong,nonatomic)UIView * cancleAlertView;
@property (strong,nonatomic)UIButton * cancleDtlBtn;
@property (strong,nonatomic)UILabel * count_downlable;
@property (strong,nonatomic)NSTimer * timer;

@property (strong,nonatomic) AdvanceCounselorInfo * advancelModel;
@property (strong,nonatomic) AdanceTimeList * AdanceTimeListmodel;
@property (strong,nonatomic) NSMutableArray * TimeListmodelArray;
@property (strong,nonatomic) UGEvaluationView * evaluationView;
@property (strong,nonatomic) UIView * alretView;
@property (assign,nonatomic) int daojishi;
@property (strong,nonatomic) NSString *  haveComment;
@property (strong,nonatomic) NSString *  comment;
@property (strong,nonatomic) NSString *  star;
@property (copy,nonatomic) NSString * advance;
@property (strong,nonatomic) UIScrollView * scrollView;

@end

@implementation UGScheduleDtlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    [self setCustomTitle:@"预约详情"];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44 - 64)];
     _scrollView.contentSize = CGSizeMake(0, 559);
    //_scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_scrollView];
    [self.view bringSubviewToFront:_scrollView];
  
}

-(NSMutableArray *)TimeListmodelArray{
    
    
    if (_TimeListmodelArray == nil) {
        _TimeListmodelArray = [NSMutableArray array];
    }
    return _TimeListmodelArray;
}
-(void)viewWillAppear:(BOOL)animated{
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
    
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] = kToken;
    params[@"advanceId"] =self.advanceId;
    __weak UGScheduleDtlViewController *weakSelf = self;
    //待确认详情
    if (self.index == 1) {
        
        [HttpClientManager getAsyn:advanceDetailClient params:params success:^(id json) {
            NSLog(@"%@",json);
            _advancelModel = [AdvanceCounselorInfo mj_objectWithKeyValues:json[@"body"][@"advanceDetail"]];
            for (NSDictionary * dict  in  json[@"body"][@"advanceDetailTime"]) {
                AdanceTimeList * TimeListmodel = [AdanceTimeList mj_objectWithKeyValues:dict];
                [weakSelf.TimeListmodelArray addObject:TimeListmodel];
                NSLog(@"%lu",(unsigned long)weakSelf.TimeListmodelArray.count);
            }
            weakSelf.statue = _advancelModel.status;
            [weakSelf initNewUI];
            [weakSelf initBottomUI];
            
        } failure:^(NSError *error) {
            
        }];
        
    }else if(self.index == 2) {
    
    //确认 详情
        [HttpClientManager getAsyn:advanceConfirmeDetailClient params:params success:^(id json) {
            NSLog(@"%@",json);
            _advancelModel = [AdvanceCounselorInfo mj_objectWithKeyValues:json[@"body"][@"advanceDetail"]];
            //[weakSelf.TimeListmodelArray addObject:TimeListmodel];
            _advancelModel = [AdvanceCounselorInfo mj_objectWithKeyValues:json[@"body"][@"advanceDetail"]];
            for (NSDictionary * dict  in  json[@"body"][@"advanceDetailTime"]) {
                AdanceTimeList * model = [AdanceTimeList mj_objectWithKeyValues:dict];
                [weakSelf.TimeListmodelArray addObject:model];
            }
           
            NSLog(@"%lu",(unsigned long)weakSelf.TimeListmodelArray.count);
            //NSLog(@"%@",TimeListmodel.cnName);
            self.daojishi = [_advancelModel.daojishi intValue];
            //self.daojishi = 20;
            [weakSelf initNewUI];
            [weakSelf initBottomUI];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                _timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function) userInfo:nil repeats:YES];
                
                [_timer fire];
                [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
                
                [self setCount_down];
                [self function];

            });
//
            
        } failure:^(NSError *error) {
            
        }];
    
     }else  {
      
      
      
      
      
        NSLog(@"self.index-%d",self.index);
        NSLog(@"self.advanceId-%@",self.advanceId);
        [HttpClientManager getAsyn:advanceDetailClosedClient params:params success:^(id json) {
            
            
            NSLog(@"%@",json);
            _advancelModel = [AdvanceCounselorInfo mj_objectWithKeyValues:json[@"body"][@"advanceDetail"]];
            _haveComment = json[@"body"][@"haveComment"];
            _comment = json[@"body"][@"comment"];
            _star = json[@"body"][@"star"];
            _advance = [NSString stringWithFormat:@"%@", _advancelModel.advanceId];
            
            for (NSDictionary * dict  in  json[@"body"][@"advanceDetailTime"]) {
                AdanceTimeList * TimeListmodel = [AdanceTimeList mj_objectWithKeyValues:dict];
                [weakSelf.TimeListmodelArray addObject:TimeListmodel];
                NSLog(@"%lu",(unsigned long)weakSelf.TimeListmodelArray.count);
            }
            
            weakSelf.statue = _advancelModel.status;
            //weakSelf.statue = @"5";
            [weakSelf initNewUI];
            [weakSelf initBottomUI];
            

            
        } failure:^(NSError *error) {
            
        }];
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
//面消失，进入后台不显示该页面，关闭定时器
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_count_downlable removeFromSuperview];
   [_timer invalidate];
    if (self.TimeListmodelArray) {
        [self.TimeListmodelArray removeAllObjects];
    }

}
-(void)function{
    if (self.daojishi >0) {
        
        self.daojishi -- ;
    }
    [self add_timeCountdown:self.daojishi];
}
-(void)add_timeCountdown: (int )daojishi
{
    int aTimer = daojishi;
    int hourT;
    int minuteT;
    int secondT;
    //NSLog(@"1111111");
    hourT = (int)(aTimer/3600);
    minuteT = (int)(aTimer - hourT*3600)/60;
    secondT = aTimer - hourT*3600 - minuteT*60;
    NSString *str;
    
    int day = (int)daojishi/3600/24;
    
    
    
    if (aTimer == 0){
        str = [NSString stringWithFormat:@"00:00:00"];
       
        DLog(@"倒计时结束,预约时间到了---");
               [_timer invalidate];//结束计时
        
    }else{
        if (day>0) {
            
            
            str = [NSString stringWithFormat:@"%d天", day];
            
            
        }else{
            
            str = [NSString stringWithFormat:@"%0.2d:%0.2d:%0.2d", hourT,minuteT,secondT];
        }
    }
    
 
    
    _count_downlable.text = str;
}
#pragma mark 倒计时UI
-(void)setCount_down{
    UILabel * titleLable = [[UILabel alloc]init];
    titleLable.text = @"约见倒计时:";
    [titleLable setTextColor:[UIColor colorWithHexString:@"#383838"]];
    titleLable.font = [UIFont systemFontOfSize:14];
    titleLable.textAlignment = NSTextAlignmentLeft;
    [_stateView addSubview:titleLable];
    _count_downlable = [[UILabel alloc]init];
    
    [_count_downlable setTextColor:RGB(240, 151, 87)];
    _count_downlable.font = [UIFont systemFontOfSize:14];
    _count_downlable.textAlignment = NSTextAlignmentLeft;
    [_stateView addSubview:_count_downlable];

    [titleLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_stateView.mas_top).offset(10);
        make.right.mas_equalTo(_stateView.mas_right).offset(-150);
        make.size.mas_equalTo(CGSizeMake(78, 14));
    }];
    
    [_count_downlable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_stateView.mas_top).offset(10);
        make.left.mas_equalTo(titleLable.mas_right).offset(3);
        make.size.mas_equalTo(CGSizeMake(100, 14));
    }];

    
}
//倒计时
-(NSString*)timerFireMethod:(NSString *)dateString{
    
    NSString * dateStr = dateString;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:dateStr];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    
    NSDate *today = [NSDate date];
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSCalendarIdentifierGregorian ];
       NSUInteger unitFlags =
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  | NSCalendarUnitDay | NSCalendarUnitMonth  | NSCalendarUnitYear ;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:today  toDate: fromDate options:0];
    int  diffMin  = (int) [cps minute];;
    int diffSec  =(int) [cps second];
    int diffDay  = (int) [cps day];
    int diffHour = (int)[cps hour] + diffDay * 24;
    
     NSString * countdown = [NSString stringWithFormat:@"%0.3d:%0.2d:%0.2d",diffHour,diffMin,diffSec];
   
   
           if (diffSec<0) {
            countdown=[NSString stringWithFormat:@"00:00:00"];
        }
    return countdown;
    
    
}
-(void)initNewUI{
    
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    _headView = [[UGConsultHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 111)];
    _headView.layer.borderWidth = 0.5f;
    _headView.layer.borderColor = [RGB(217, 217, 217) CGColor];

    _headView.advanceInfo = _advancelModel;
      __weak __typeof__(self) weakSelf = self;
    _headView.clickWenHaoBlock = ^(){
        UGGotovideoHelpViewController * vc= [[UGGotovideoHelpViewController alloc]init];
        
        [weakSelf pushToNextViewController:vc];
        
    };
    //_evaluationView.viewRemove = ^(){
        //            [weakSelf.alretView removeFromSuperview];
        //
        //        };

    
    [_scrollView addSubview:_headView];
    //评价详情的UI
    UIView  * evaluation_View = [[UIView alloc]initWithFrame:CGRectMake(0, 128 +100, kScreenWidth, 185)];
    
    evaluation_View.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    evaluation_View.layer.borderWidth = 0.5f;
    evaluation_View.layer.borderColor = [RGB(217, 217, 217) CGColor];

    
    UILabel * lable1 = [[UILabel alloc]init];
    lable1.text = @"对本次视频满意度:";
    lable1.font = [UIFont systemFontOfSize:13];
    lable1.frame = CGRectMake(10, 9, 130, 13);
    lable1.textColor = [UIColor colorWithHexString:@"#252525"];
    lable1.textAlignment = NSTextAlignmentLeft;
    [evaluation_View addSubview:lable1];
    
    int  strNum = [_star intValue];
    for (int i =0; i<5; i++) {
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.2+ i *50, 46, 30, 30)];
        if (i< strNum) {
            imageview.image= [UIImage imageNamed:@"Star_choose"];
        }else {
            
            imageview.image= [UIImage imageNamed:@"Star_no_choose"];
            
        }
        
        
        [evaluation_View addSubview:imageview];
        
    }
    UILabel * lable2 = [[UILabel alloc]init];
    lable2.text = @"对顾问做个评价:";
    lable2.font = [UIFont systemFontOfSize:13];
    lable2.frame = CGRectMake(10, 96, 130, 13);
    lable2.textColor = [UIColor colorWithHexString:@"#252525"];
    lable2.textAlignment = NSTextAlignmentLeft;
    [evaluation_View addSubview:lable2];

    UILabel * evaluationlable =[[UILabel alloc]init];
    evaluationlable.frame =CGRectMake(23, 123, kScreenWidth-23, 15);
    evaluationlable.font = [UIFont systemFontOfSize:13];
    evaluationlable.text = _comment;
    evaluationlable.textColor = [UIColor colorWithHexString:@"#5c5c5c"];
    evaluationlable.numberOfLines = 0;
    evaluationlable.textAlignment = NSTextAlignmentLeft;
    
    [evaluation_View addSubview:evaluationlable];
    
    
    
    UIView * statueView = [[UIView alloc]initWithFrame:CGRectMake(0, 128, kScreenWidth, 90)];
    statueView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    statueView.layer.borderWidth = 0.5f;
    statueView.layer.borderColor = [RGB(217, 217, 217) CGColor];
    [_scrollView addSubview:statueView];
    
    
    UILabel * statue_lable = [[UILabel alloc]init];
    statue_lable.text =_advancelModel.state;
    statue_lable.textAlignment = NSTextAlignmentCenter;
    [statue_lable setHighlightedTextColor:[UIColor colorWithHexString:@"#383838"]];
    // statue_lable.textColor = [UIColor colorWithHexString:@"#383838"];
    statue_lable.font = [UIFont systemFontOfSize:14];
    [statueView addSubview:statue_lable];
    UILabel * statue_lable1 = [[UILabel alloc]init];
    if (self.index == 1) {
        if ([self.type isEqualToString:@"1"]) {
            
            
            statue_lable1.text =@"等待顾问确认接受哦~";
            
        }else if ([self.type isEqualToString:@"2"]){
            
             statue_lable1.text =@"等待您接受预约哦~";
        }
        
    }else if (self.index == 2){
        statue_lable1.text =@"顾问已接受你的预约，请准时与优优联系~";
    }

    statue_lable1.textColor = [UIColor colorWithHexString:@"#383838"];
    statue_lable1.textAlignment = NSTextAlignmentCenter;
    statue_lable1.font = [UIFont systemFontOfSize:12];
    [statueView addSubview:statue_lable1];
    [statue_lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statueView.mas_top).offset(19);
        make.centerX.mas_equalTo(statueView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70, 16));
    }];
    [statue_lable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statue_lable.mas_bottom).offset(14);
        make.centerX.mas_equalTo(statueView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 14));
    }];
    
    
   
  
        //待确认 的UI
    
    CGFloat  stateView_hight = 48 + self.self.TimeListmodelArray.count * 45 ;
        _stateView = [[UIView alloc]initWithFrame:CGRectMake(0, 128 + 100, kScreenWidth, stateView_hight)];
    
    _stateView.layer.borderWidth = 0.5f;
    _stateView.layer.borderColor = [RGB(217, 217, 217) CGColor];
    
//        if (self.TimeListmodelArray.count == 1) {
    if ([_advancelModel.status isEqualToString:@"5"] && [_haveComment isEqualToString:@"1"]) {
    
        _stateView .frame = CGRectMake(0, 420, kScreenWidth, stateView_hight);
        [_scrollView addSubview:evaluation_View];
        _scrollView.contentSize = CGSizeMake(0, 730);
    }
        _stateView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [_scrollView addSubview:_stateView];
     //预约 时间
    
        UILabel * scheduleTime= [[UILabel alloc]init];
        scheduleTime.text = @"预约时间:";
    
        [scheduleTime setHighlightedTextColor:[UIColor colorWithHexString:@"#383838"]];
        scheduleTime.textColor = [UIColor colorWithHexString:@"#383838"];
       scheduleTime.font = [UIFont systemFontOfSize:13];
    
        [_stateView addSubview:scheduleTime];
        for (int i = 0; i< self.TimeListmodelArray.count; i++) {
            AdanceTimeList * model1 = [AdanceTimeList mj_objectWithKeyValues:self.TimeListmodelArray[i]];
          
            UILabel * lable = [[UILabel alloc]init];
            lable.text =[NSString stringWithFormat:@"%@-%@ %@ (美国时间:%@-%@ )",model1.cnStartTime,model1.cnEndTime,model1.advanceDateCn,model1.otherStartTime, model1.otherEndTime];
            
            lable.textColor=[UIColor colorWithHexString:@"#383838"];
            if (kScreenWidth == 320) {
                
                lable.font = [UIFont systemFontOfSize:11];
            }else{
                lable.font = [UIFont systemFontOfSize:13];
            }
            lable.frame = CGRectMake(12, 48 +i *45 , 300, 13);
             [_stateView addSubview:lable];
            if (i <2) {
                
                UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"dotted_line"]];
                imageview.frame = CGRectMake(12, 74  + i * 45, kScreenWidth - 12, 1);
                 [_stateView addSubview:imageview];
            }
            NSString * imagestatus = [NSString stringWithFormat:@"%@",model1.status];
            if ([imagestatus isEqualToString:@"2"]) {
                
                UIImageView * chooseView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth -30, 48 +i *45 , 15, 15)];
                chooseView.image = [UIImage imageNamed:@"pay_select"];
                [_stateView addSubview:chooseView];
                [lable setHighlightedTextColor:[UIColor colorWithHexString:@"#383838"]];
            }else if ([imagestatus isEqualToString:@"1"]){
                lable.textColor = [UIColor colorWithHexString:@"#b7b7b7"];
                
            }
            
            
            
            if ([_advancelModel.status isEqualToString:@"4"] ||[_advancelModel.status isEqualToString:@"3"]) {
                lable.textColor = [UIColor colorWithHexString:@"#b7b7b7"];
                statue_lable1.text = _advancelModel.reason;
            }else if ([_advancelModel.status isEqualToString:@"5"]){
                NSLog(@"%@",_advancelModel.haveComment);
                if ([_haveComment isEqualToString:@"0"]) {
                    
                    statue_lable1.text = @"视频预约已结束，快给顾问一个恩评价吧~";
                }else if ([_haveComment isEqualToString:@"1"]){
                    statue_lable1.text = @"感谢你的评价~";
                }
            }
        }
               [scheduleTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_stateView.mas_top).offset(10);
            make.left.mas_equalTo(_stateView.mas_left).offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        UIView * beizhuView = [[UIView alloc]initWithFrame:CGRectMake(0, _stateView.origin.y +_stateView.size.height +10, kScreenWidth, 111)];
    beizhuView.layer.borderWidth = 0.5f;
    beizhuView.layer.borderColor = [RGB(217, 217, 217) CGColor];
        beizhuView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [_scrollView addSubview:beizhuView];
        UILabel * beizhulable = [[UILabel alloc]initWithFrame:CGRectMake(10, 7, 45, 15)];
        [beizhulable setHighlightedTextColor:[UIColor colorWithHexString:@"#383838"]];
        beizhulable.font = [UIFont systemFontOfSize:13];
        beizhulable.text = @"备注:";
        [beizhuView addSubview:beizhulable];
        UILabel * message_lable =[[UILabel alloc]initWithFrame:CGRectMake(12, 24, 300, 111-34)];
        message_lable.numberOfLines = 0 ;
        message_lable.textColor = [UIColor colorWithHexString:@"#cccccc"];
    
        message_lable.text = _advancelModel.message;
        message_lable.textAlignment = NSTextAlignmentLeft;
        [beizhuView addSubview:message_lable];
    
    
    
        
        
        
        
        
        
        
   
    
    
}
-(void)initBottomUI{
    
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.right.mas_equalTo(self.view.mas_right);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 44));
    }];
    if (self.index ==1 || self.index == 2) {
       
        if ([_advancelModel.daojishi isEqualToString:@"0"]){
            
            bottomView.backgroundColor = [UIColor  colorWithHexString:@"#26bdab"];
            UITapGestureRecognizer * contactRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
            
            [bottomView addGestureRecognizer:contactRecognizer];
            UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact"]];

             [bottomView addSubview:imageview];
            
            UILabel * contactlable = [[UILabel alloc]init];
           
            
            contactlable.font = [UIFont systemFontOfSize:13];
            [contactlable setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
            contactlable.textAlignment = NSTextAlignmentLeft;
              contactlable.text = @"需要帮助";
            [bottomView addSubview:contactlable];

            [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(bottomView.mas_top).offset(13);
                make.left.mas_equalTo(bottomView.mas_left).offset(kScreenWidth * 0.36);
                make.size.mas_equalTo(CGSizeMake(21, 19));
            }];
            [contactlable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(imageview.mas_top).offset(2);
                // make.centerY.mas_equalTo(imageview.centerY);
                make.left.mas_equalTo(imageview.mas_right).offset(10);
                make.size.mas_equalTo(CGSizeMake(77, 14));
            }];

            
        }else{
            
            UIView  * contactView = [[UIView alloc]init];
            contactView.backgroundColor = [UIColor  colorWithHexString:@"#26bdab"];
            UITapGestureRecognizer * contactRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
            
            [contactView addGestureRecognizer:contactRecognizer];
            
            [bottomView addSubview:contactView];
            
            
            UILabel * contactlable = [[UILabel alloc]init];
            UIButton * button = [[UIButton alloc]init];
            
            contactlable.font = [UIFont systemFontOfSize:13];
            [contactlable setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
            contactlable.textAlignment = NSTextAlignmentLeft;
            [contactView addSubview:contactlable];
            //button.titleLabel.text = @"取消预约";
            
            button.backgroundColor = [UIColor whiteColor];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            [button addTarget:self action:@selector(cancleBtn) forControlEvents:UIControlEventTouchUpInside ];
            [button setTitleColor:[UIColor colorWithHexString:@"#5c5c5c"] forState:UIControlStateNormal];
            [bottomView addSubview:button];
            if(self.index == 1){
                if ([self.type isEqualToString:@"1"]) {
                    UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact"]];
                    
                    contactlable.text = @"需要帮助";
                    [button setTitle:@"取消预约" forState: UIControlStateNormal];
                    [contactView addSubview:imageview];
                    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(contactView.mas_top).offset(13);
                        make.left.mas_equalTo(contactView.mas_left).offset(kScreenWidth * 0.22);
                        make.size.mas_equalTo(CGSizeMake(21, 19));
                    }];
                    
                    [contactlable mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(imageview.mas_top).offset(2);
                        // make.centerY.mas_equalTo(imageview.centerY);
                        make.left.mas_equalTo(imageview.mas_right).offset(10);
                        make.size.mas_equalTo(CGSizeMake(77, 14));
                    }];
                    
                }else if ([self.type isEqualToString:@"2"]){
                    
                    contactlable.text = @"接受预约";
                    [button setTitle:@"拒绝" forState: UIControlStateNormal];
                    [contactlable mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(contactView.mas_top).offset(15);
                        // make.centerY.mas_equalTo(imageview.centerY);
                        make.left.mas_equalTo(contactView.mas_left).offset(95);
                        make.size.mas_equalTo(CGSizeMake(77, 14));
                    }];
                    
                }
            }else if (self.index == 2){
                UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact@2x"]];
                
                contactlable.text = @"需要帮助";
                [button setTitle:@"取消预约" forState: UIControlStateNormal];
                [contactView addSubview:imageview];
                [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(contactView.mas_top).offset(13);
                    make.left.mas_equalTo(contactView.mas_left).offset(kScreenWidth * 0.22);
                    make.size.mas_equalTo(CGSizeMake(21, 19));
                }];
                
                [contactlable mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(imageview.mas_top).offset(2);
                    // make.centerY.mas_equalTo(imageview.centerY);
                    make.left.mas_equalTo(imageview.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake(77, 14));
                }];
                
            }
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.view.mas_bottom);
                make.right.mas_equalTo(self.view.mas_right);
                
                make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.3, 44));
            }];
            [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.view.mas_bottom);
                make.left.mas_equalTo(self.view.mas_left);
                
                 make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 44));
            }];
        }
                   }else if (self.index == 100){
        //  预约详情  （进行中）
        
        
        
        
        UIView  * contactView = [[UIView alloc]init];
        contactView.backgroundColor = [UIColor  colorWithHexString:@"#26bdab"];
        UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactView)];
        
        [contactView addGestureRecognizer:recognizer];

        [bottomView addSubview:contactView];
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact@2x"]];
        [contactView addSubview:imageview];
        UILabel * contactlable = [[UILabel alloc]init];
        contactlable.text = @"需要帮助";
        contactlable.font = [UIFont systemFontOfSize:13];
        [contactlable setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
        contactlable.textAlignment = NSTextAlignmentLeft;
        [contactView addSubview:contactlable];
        [contactView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom);
            make.right.mas_equalTo(self.view.mas_right);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth , 44));
        }];

        [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contactView.mas_top).offset(13);
            make.left.mas_equalTo(contactView.mas_left).offset(kScreenWidth * 0.36);
            make.size.mas_equalTo(CGSizeMake(21, 19));
        }];
        [contactlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageview.mas_top).offset(2);
            // make.centerY.mas_equalTo(imageview.centerY);
            make.left.mas_equalTo(imageview.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(77, 14));
        }];
      [_stateView mas_updateConstraints:^(MASConstraintMaker *make) {
          make.top.mas_equalTo(_headView.mas_bottom).offset(33);
          make.left.mas_equalTo(self.view.mas_left);
          make.size.mas_equalTo(CGSizeMake(kScreenWidth, 227));
      }];
        
        [self.view layoutIfNeeded];
        
    }
    
    
    else{
        if ([self.statue isEqualToString:@"3"] || [self.statue isEqualToString:@"4"]) {
            
                UIView  * contactView1 = [[UIView alloc]init];
                contactView1.backgroundColor = [UIColor  whiteColor];
            contactView1.backgroundColor = [UIColor  whiteColor];
            UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactView)];
            
            [contactView1 addGestureRecognizer:recognizer];
            
            //pingjia
//                UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactView)];
//                
//                [contactView1 addGestureRecognizer:recognizer];
            
                [bottomView addSubview:contactView1];
//                UIImageView * imageview1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"now_schedule"]];
//                //[contactView1 addSubview:imageview1];
                UILabel * contactlable1 = [[UILabel alloc]init];
                contactlable1.text = @"马上预约";
                contactlable1.font = [UIFont systemFontOfSize:13];
                [contactlable1 setTextColor:[UIColor colorWithHexString:@"#5c5c5c"]];
                contactlable1.textAlignment = NSTextAlignmentLeft;
                [contactView1 addSubview:contactlable1];
                //dierge
                UIView  * contactView2 = [[UIView alloc]init];
                UITapGestureRecognizer * HXrecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
                
                [contactView2 addGestureRecognizer:HXrecognizer];
                contactView2.backgroundColor = [UIColor  colorWithHexString:@"#26bdab"];
                [bottomView addSubview:contactView2];
                //clickcontactRecognizer
                UIImageView * imageview2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact"]];
                [contactView2 addSubview:imageview2];
                UILabel * contactlable2 = [[UILabel alloc]init];
                contactlable2.text = @"需要帮助";
                contactlable2.font = [UIFont systemFontOfSize:13];
                [contactlable2 setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
                contactlable2.textAlignment = NSTextAlignmentLeft;
                [contactView2 addSubview:contactlable2];
                
                [contactView2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.view.mas_bottom);
                    make.left.mas_equalTo(self.view.mas_left);
                    make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 44));
                }];
//                [imageview1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(contactView1.mas_top).offset(13);
//                    make.left.mas_equalTo(contactView1.mas_left).offset(kScreenWidth * 0.5 * 0.22);
//                    make.size.mas_equalTo(CGSizeMake(21, 19));
//                }];
                [contactlable1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(contactView1.mas_top).offset(12);
                    // make.centerY.mas_equalTo(imageview.centerY);
                    //make.left.mas_equalTo(imageview1.mas_right).offset(10);
                     make.centerX.mas_equalTo(contactView1.centerX);
                    make.size.mas_equalTo(CGSizeMake(77, 14));
                }];
                [contactView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(self.view.mas_bottom);
                    make.right.mas_equalTo(self.view.mas_right);
                    make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.3, 44));
                }];
                [imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(contactView2.mas_top).offset(13);
                    make.left.mas_equalTo(contactView2.mas_left).offset(kScreenWidth * 0.5 * 0.22);
                    make.size.mas_equalTo(CGSizeMake(21, 19));
                }];
                [contactlable2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(imageview2.mas_top).offset(2);
                    // make.centerY.mas_equalTo(imageview.centerY);
                    make.left.mas_equalTo(imageview2.mas_right).offset(10);
                    make.size.mas_equalTo(CGSizeMake(77, 14));
                }];
                
            
        }
        
        else if ([self.statue isEqualToString:@"5"]){
        UIView  * contactView1 = [[UIView alloc]init];
        contactView1.backgroundColor = [UIColor  whiteColor];
            UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactView)];
            
            [contactView1 addGestureRecognizer:recognizer];

        [bottomView addSubview:contactView1];
       
        UILabel * contactlable1 = [[UILabel alloc]init];
            if([_haveComment isEqualToString:@"1"]){
                
                contactlable1.text = @"再次预约";
            }else if ([_haveComment isEqualToString:@"0"]){
                
                //评价
                contactlable1.text = @"立即评价";
                            }
            

            
        contactlable1.font = [UIFont systemFontOfSize:13];
        //[contactlable1 setTextColor:[UIColor colorWithHexString:@"#ff9148"]];
        contactlable1.textAlignment = NSTextAlignmentLeft;
        [contactView1 addSubview:contactlable1];
        //dierge
        UIView  * contactView2 = [[UIView alloc]init];
             UITapGestureRecognizer * employRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
            [contactView2 addGestureRecognizer:employRecognizer];
        contactView2.backgroundColor = [UIColor  colorWithHexString:@"#26bdab"];
        [bottomView addSubview:contactView2];
        UIImageView * imageview2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"schedule_contact"]];
        [contactView2 addSubview:imageview2];
        UILabel * contactlable2 = [[UILabel alloc]init];
        contactlable2.text = @"需要帮助";
        contactlable2.font = [UIFont systemFontOfSize:13];
        [contactlable2 setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
        contactlable2.textAlignment = NSTextAlignmentLeft;
        [contactView2 addSubview:contactlable2];
        
        [contactView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.7, 44));
        }];
            
            
        [contactlable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contactView1.mas_top).offset(13);
           make.centerX.mas_equalTo(contactView1.centerX);
//            make.left.mas_equalTo(imageview1.mas_right).offset(5);
            make.size.mas_equalTo(CGSizeMake(77, 14));
        }];
        [contactView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom);
            make.right.mas_equalTo(self.view.mas_right);
            make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.3, 44));
        }];
        [imageview2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contactView2.mas_top).offset(13);
            make.left.mas_equalTo(contactView2.mas_left).offset(kScreenWidth * 0.5 * 0.22);
            make.size.mas_equalTo(CGSizeMake(21, 19));
        }];
        [contactlable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imageview2.mas_top).offset(2);
            // make.centerY.mas_equalTo(imageview.centerY);
            make.left.mas_equalTo(imageview2.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(77, 14));
        }];
        
        
    }

    }

}
#pragma mark 立即联系
-(void)clickcontactRecognizer{
    //接受重新预约
    if ([self.type isEqualToString:@"2"]) {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"token"]= kToken;
        params[@"advanceId"] = _advancelModel.advanceId;
        [HttpClientManager postAsyn:reAdvanceAccept params:params success:^(id json) {
            NSLog(@"%@",json);
            NSString * str = json[@"header"][@"code"];
         if([str isEqualToString:@"200"]){
             [self showSVSuccessWithStatus:@"重新预约成功"];
     }
        } failure:^(NSError *error) {
            NSLog(@"cs");
        }];
    }else{
        
        UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
        vc.kHxStr = serviceId;
        //            [vc setTitle:<#(NSString * _Nullable)#>]
        //保存环信ID，获取头像&昵称
        [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
}
#pragma mark 取消预约按钮
-(void)cancleBtn{
    if ([self.type isEqualToString:@"2"]) {
        //重新预约  拒绝
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"token"]= kToken;
        params[@"advanceId"] = _advancelModel.advanceId;
        [HttpClientManager postAsyn:reAdvanceCancel params:params success:^(id json) {
            NSString * str = json[@"header"][@"code"];
            if([str isEqualToString:@"200"]){
                [self showSVSuccessWithStatus:@"取消成功"];
                [self.navigationController  popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];

    }else{
        
        UGAdvanCancleReasonViewController * vc = [[UGAdvanCancleReasonViewController alloc]init];
        
        vc.advanceId = self.advanceId;
        [self pushToNextViewController:vc];
    
    }
}
-(void)dissmissBackView{
    
    [_cancleAlertView removeFromSuperview];
    
    
    
}
-(void)clickCancleBtn:(UIButton *)sender{
    if (_cancleDtlBtn ==sender) {
        
    }else{
        
        sender.backgroundColor = RGB(38, 189, 171);
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancleDtlBtn.backgroundColor = [UIColor whiteColor];
        _cancleDtlBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [_cancleDtlBtn setTitleColor: [UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal];
        _cancleDtlBtn.layer.masksToBounds = YES;
    }
    
    
    _cancleDtlBtn = sender;
    
    
}
-(void)clickBottomBtn{
    
    [_cancleAlertView removeFromSuperview];
    NSLog(@"dsadasd");
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString * str = _cancleDtlBtn.titleLabel.text;
    params[@"token"] = kToken;
    params[@"advanceId"] =self.advanceId;
    params[@"reason"] =str;
    __weak UGScheduleDtlViewController *weakSelf = self;

    [HttpClientManager getAsyn:cancelAdvanceClient params:params success:^(id json) {
        MsgModel * msgmodel = [MsgModel mj_objectWithKeyValues:json[@"header"]];
        NSLog(@"%@",msgmodel.code);
        if ([msgmodel.code isEqualToString:@"200"]) {
            [weakSelf showSVSuccessWithStatus:msgmodel.message];
           
            [self.navigationController popViewControllerAnimated:YES];
        }else if ([msgmodel.code isEqualToString:@"400"]){
            [weakSelf showSVSuccessWithStatus:msgmodel.message];
        }
      
    } failure:^(NSError *error) {
        [weakSelf showSVSuccessWithStatus:@"wangluo "];
    }];
    

}
#pragma mark 立即聘用 评价
-(void)clickEmployView{
    NSString * urlStr = [NSString stringWithFormat:@"%@counselorId=%@",GotounderstandService,_advancelModel.counselorId];
    
    UGUderstandSeverViewController *vc = [[UGUderstandSeverViewController alloc]init];
    vc.urlStr = urlStr;
    [self pushToNextViewController:vc];
}
-(void)clickcontactView{
    if([self.statue isEqualToString:@"3"] || [self.statue isEqualToString:@"4"]){
        UGSchedulingViewController * vc = [[UGSchedulingViewController alloc]init];
        vc.counselorId = _advancelModel.counselorId;
        vc.hidesBottomBarWhenPushed =YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        NSLog(@"用户取消，顾问取消");
    }else if ([self.statue isEqualToString:@"5"]){
        if([_haveComment isEqualToString:@"1"]){
            
            UGSchedulingViewController * vc = [[UGSchedulingViewController alloc]init];
            vc.counselorId = _advancelModel.counselorId;
            vc.hidesBottomBarWhenPushed =YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
        }else if ([_haveComment isEqualToString:@"0"]){
            
            //评价
            UGEvaluationViewController * vc = [[UGEvaluationViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            NSLog(@"%@",_advanceId);
            NSLog(@"%@",_advance);
            //NSLog((@"%@",_advancelModel.advanceId);
            vc.advanceId =self.advance ;
            NSLog(@"%@", vc.advanceId);
            [self pushToNextViewController:vc];
        }
        
        
        
        
        
        
        
        
//        __weak UGScheduleDtlViewController *weakSelf = self;
//        _alretView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        _alretView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
//        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_alretView];
//        
//        
//
//        _evaluationView = [[UGEvaluationView alloc]initWithFrame:CGRectMake(52, 60, 272, 329)];
//        _evaluationView.advanceId = _advancelModel.advanceId;
//        [_alretView addSubview:_evaluationView];
//        
//        _evaluationView.viewRemove = ^(){
//            [weakSelf.alretView removeFromSuperview];
//            
//        };
       // = ^(){
    }
   
    
}
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
