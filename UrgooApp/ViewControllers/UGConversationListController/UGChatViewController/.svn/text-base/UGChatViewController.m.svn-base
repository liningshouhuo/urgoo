//
//  UGChatViewController.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGChatViewController.h"

#import "UGScheduleDtlViewController.h"
//#import "ChatGroupDetailViewController.h"
//#import "ChatroomDetailViewController.h"
//#import "UserProfileViewController.h"
#import "UGUserProfileTableViewController.h"
//#import "UserProfileManager.h"
//#import "ContactListSelectViewController.h"
//#import "ChatDemoHelper.h"
#import "UGProfileViewController.h"
#import "ChatHelper.h"
#import "UGSchedulingViewController.h"
#import "Masonry.h"
#import "AccountModel.h"
#import "IsAdvanceRelation.h"

@interface UGChatViewController ()<UIAlertViewDelegate, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource,EMClientDelegate,UITextViewDelegate,UIActionSheetDelegate>
{
    UIMenuItem *_copyMenuItem;
    UIMenuItem *_deleteMenuItem;
    UIMenuItem *_transpondMenuItem;
    UIView    * _scheduleView;
    UIView * voidView;
    UIView * voiceView;
    UIView * USATimeView;
    UIView * _alretView;
   
}

@property (nonatomic) BOOL isPlayingAudio;

@property (nonatomic) NSMutableDictionary *emotionDic;
@property (assign,nonatomic) int  daojishi;
@property (strong,nonatomic) NSString * isAdvanceRelation;
@property (strong,nonatomic) NSString * notime;
@property (strong,nonatomic) NSTimer * timer;
@property (strong,nonatomic) UILabel * titleLable;
@property (strong,nonatomic) NSString * counselorId;
@property (strong,nonatomic) NSString * advanceId;
@property (strong,nonatomic) UIView * EvaluationView;
@property (strong,nonatomic) UIView * alretView;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) UIView    * scheduleView;
@property (assign,nonatomic) int textnum;
@property (strong,nonatomic) UITextView * leaveMessageView;
@property (strong,nonatomic) NSString * btnString;
@property (strong,nonatomic) UIButton * evluationBtn;
@property (strong,nonatomic) IsAdvanceRelation * Relationmodel;
@end

@implementation UGChatViewController

//查询是否有预约关系
-(void)isHaveSchedule{
      [SVProgressHUD show];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"hxCode"] = self.kHxStr;
    NSLog(@"%@",self.kHxStr);
    [HttpClientManager getAsyn:UG_isAdvanceRelation_URL params:params success:^(id json) {
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            NSLog(@"3333");
            NSLog(@"%@",json);
            
            _Relationmodel =[IsAdvanceRelation mj_objectWithKeyValues:json[@"body"][@"isAdvanceRelation"]];
            _daojishi = [_Relationmodel.daojishi intValue];
            
            
            _isAdvanceRelation =[NSString stringWithFormat:@"%@",_Relationmodel.isAdvanceRelation];
            _notime = [NSString stringWithFormat:@"%@",_Relationmodel.notime];
            _counselorId = _Relationmodel.counselorId;
            _advanceId = _Relationmodel.advanceId;
            NSLog(@"%@",self.advanceId);
            _status = _Relationmodel.status;
            
            _type  = _Relationmodel.type;
            //_isAdvanceRelation = @"0";
            if ([_kHxStr isEqualToString:@"ydc2001"]) {
                
            }else{
                
                [self needRightAction];
                
            }
            
            //        if ([_isAdvanceRelation isEqualToString:@"1"]) {
            //
            //            if ([_status isEqualToString:@"2"]) {
            //
            //
            //                _timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(function) userInfo:nil repeats:YES];
            //
            //                [_timer fire];
            //                [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            //                [self setScheduleUI];
            //                [self function];
            //            }
            //
            //     }
            //是否有预约 API接口有改动 model变动
            NSString *show = [NSString stringWithFormat:@"%@",json[@"body"][@"isAdvanceRelation"][@"show"]] ;
            if ([show isEqualToString:@"1"]) {
                [self getMeetingNumid];
            }
            
            //显示时间
            //[self isTimeNoteShow];
            
        }else if ([msg.code isEqualToString:@"400"]) {
            
            
            
            
            
        }
        
        
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *error) {
          [SVProgressHUD dismiss];
    }];
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    [_timer invalidate];
   
    
}

-(void)function{
    if (self.daojishi >0) {
        
        self.daojishi -=1 ;
    }
    //[self add_timeCountdown:self.daojishi];
    NSString * timeStr = [self add_timeCountdown:self.daojishi];;
    NSString * str= [NSString stringWithFormat:@"预约倒计时:%@",timeStr];
    
    NSMutableAttributedString *titleLablestr=[[NSMutableAttributedString alloc]initWithString:str];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[titleLablestr string]rangeOfString:@"预约倒计时:"];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#383838"] range:range1];
    
    NSRange range2=[[titleLablestr string]rangeOfString:timeStr];
    [titleLablestr addAttribute:NSForegroundColorAttributeName value:RGB(242, 163, 106) range:range2];
    _titleLable.attributedText = titleLablestr;
    if (kScreenWidth == 320) {
        _titleLable.font = [UIFont systemFontOfSize:12];
    }

}
-(NSString * )add_timeCountdown: (int )daojishi
{
    int aTimer = daojishi;
    int hourT;
    int minuteT;
    int secondT;
    
    hourT = (int)(aTimer/3600);
    minuteT = (int)(aTimer - hourT*3600)/60;
    secondT = aTimer - hourT*3600 - minuteT*60;
    NSString *str;
    
    
    int day = (int)daojishi/3600/24;
    if (aTimer == 0){
        str = [NSString stringWithFormat:@"00:00:00"];
        UITapGestureRecognizer *sendVideo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendVideo)];
        
        
        [voidView addGestureRecognizer:sendVideo];
        voidView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        
        UITapGestureRecognizer *sendVoice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sendVoice)];
        
        
        [voiceView addGestureRecognizer:sendVoice];

        voiceView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [_timer invalidate];//结束计时
        
    }else{
        
        if (day>0) {
            
            
            str = [NSString stringWithFormat:@"%d天", day];
            
            
        }else{
            
            str = [NSString stringWithFormat:@"%0.2d:%0.2d:%0.2d", hourT,minuteT,secondT];
        }

    }
    
    
    return str;
   
}

#pragma mark 视频结束后立即评价
-(void)pop_commentView{
    [self test];
}

-(void)dismiss{
    [SVProgressHUD dismiss];
}
-(void)dismiss1{
    [SVProgressHUD dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self isHaveSchedule];
     
    //对结束视频的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(test) name:@"EMCallEndReasonHangup_comment" object:nil];
    //键盘升降
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Show) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Hidden) name:UIKeyboardWillHideNotification object:nil];
    

    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    
    [self get_Nick];
    
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"chat_sender_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
    
    NSArray *array = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"chat_sender_audio_playing_full"], [UIImage imageNamed:@"chat_sender_audio_playing_000"], [UIImage imageNamed:@"chat_sender_audio_playing_001"], [UIImage imageNamed:@"chat_sender_audio_playing_002"], [UIImage imageNamed:@"chat_sender_audio_playing_003"], nil];
    [[EaseBaseMessageCell appearance] setSendMessageVoiceAnimationImages:array];
    NSArray * array1 = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"chat_receiver_audio_playing_full"],[UIImage imageNamed:@"chat_receiver_audio_playing000"], [UIImage imageNamed:@"chat_receiver_audio_playing001"], [UIImage imageNamed:@"chat_receiver_audio_playing002"], [UIImage imageNamed:@"chat_receiver_audio_playing003"],nil];
    [[EaseBaseMessageCell appearance] setRecvMessageVoiceAnimationImages:array1];
    
    [[EaseBaseMessageCell appearance] setAvatarSize:40.f];
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];
    
    [[EaseChatBarMoreView appearance] setMoreViewBackgroundColor:[UIColor colorWithRed:240 / 255.0 green:242 / 255.0 blue:247 / 255.0 alpha:1.0]];
    
    [self _setupBarButtonItem];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteAllMessages:) name:KNOTIFICATIONNAME_DELETEALLMESSAGE object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitGroup) name:@"ExitGroup" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(insertCallMessage:) name:@"insertCallMessage" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callOutWithChatter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleCallNotification:) name:@"callControllerClose" object:nil];
    
    //通过会话管理者获取已收发消息
    [self tableViewDidTriggerHeaderRefresh];
    
    
    
    
    //[self setScheduleUI];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    
    //*********zoom 的视频button*******
   // [self button_addVideo];
    
}//isAdvanceRelation
#pragma mark 设置预约按钮
-(void)needRightAction{
    
    [self needTwoRightAction];
    
    
    
    
    
    
    
    
}

-(void)needTwoRightAction
{
    UIButton *Ubao = [UIButton buttonWithType:UIButtonTypeCustom];
    Ubao.frame = CGRectMake(0, 0, 25, 30);
    Ubao.titleLabel.font = [UIFont systemFontOfSize:9];
    //Ubao.layer.borderWidth = 0.6;
    [Ubao setTitle:@"优优" forState:UIControlStateNormal];
    [Ubao setImage:[UIImage imageNamed:@"advanceUbao_icon"] forState:UIControlStateNormal];
    [Ubao setTitleEdgeInsets:UIEdgeInsetsMake(12, -15, 0, 0)];
    [Ubao setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 15, 0)];
    [Ubao addTarget:self action:@selector(click_RightBtnUbao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *UbaoItem = [[UIBarButtonItem alloc] initWithCustomView:Ubao];
    
    UIButton *advance = [UIButton buttonWithType:UIButtonTypeCustom];
    advance.frame = CGRectMake(0, 0, 25, 30);
    advance.titleLabel.font = [UIFont systemFontOfSize:9];
    //advance.layer.borderWidth = 0.6;
    [advance setTitle:@"预约" forState:UIControlStateNormal];
    [advance setImage:[UIImage imageNamed:@"advanceTime_icon"] forState:UIControlStateNormal];
    [advance setTitleEdgeInsets:UIEdgeInsetsMake(12, -15, 0, 0)];
    [advance setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 15, 0)];
    [advance addTarget:self action:@selector(clickRightBtn_lastTest) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIBarButtonItem *AdvanceItem = [[UIBarButtonItem alloc] initWithCustomView:advance];
    
    self.navigationItem.rightBarButtonItems = @[AdvanceItem,UbaoItem];
}

-(void)click_RightBtnUbao
{
    UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
    vc.kHxStr = serviceId;
    [vc setCustomTitle:ServiecName];
    
    //保存环信ID，获取头像&昵称
    [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
    [[NSUserDefaults standardUserDefaults] synchronize];
    //点击客服回到列表（有预约关系）
    [User_Default setObject:@"1" forKey:@"advanceUbao"];
    [User_Default synchronize];
    
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
// 键盘 升降
-(void)keyboard_Show{
    if(kScreenWidth==320){
        _EvaluationView.frame = CGRectMake(24, -80, 272, 329);
    }else{
        _EvaluationView.frame = CGRectMake(52, -30, 272, 329);
    }
    
}
-(void)keyboard_Hidden{
    if(kScreenWidth==320){
        _EvaluationView.frame = CGRectMake(24, 30, 272, 329);
    }else{
        _EvaluationView.frame = CGRectMake(52, 60, 272, 329);
    }

}
#pragma mark 设置预约UI
-(void)setScheduleUI{
    self.tableView.frame = CGRectMake(0, 65, kScreenWidth, kScreenHeight - 68 -44  );
    _scheduleView = [[UIView alloc]init];
    _scheduleView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    _scheduleView.frame = CGRectMake(0, 0, kScreenWidth, 47);
    [self.view addSubview:_scheduleView];
    _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:13];
    [_scheduleView addSubview:_titleLable];
    voidView = [[UIView alloc]init];
    voidView.layer.cornerRadius =4;
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"viode_schdeule"]];
    imageView.frame = CGRectMake(11, 7, 20, 12);
    UILabel * voideLable = [[UILabel alloc]init];
    voideLable.backgroundColor = [UIColor clearColor];
    
    voideLable.text = @"发起视频";
    voideLable.textAlignment = NSTextAlignmentLeft;
    voideLable.font = [UIFont systemFontOfSize:12];
    [voideLable setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
    [voidView addSubview:imageView];
    [voidView addSubview:voideLable];
    
    voidView.backgroundColor = [UIColor colorWithHexString:@"#c7c7c7"];
    
    [_scheduleView addSubview:voidView];
//    voiceView = [[UIView alloc]init];
//    voiceView.layer.cornerRadius = 4;
//    
//    UIImageView *imageView1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"voice_schedule"]];
//    imageView1.frame = CGRectMake(11, 7, 17, 14);
//    UILabel * voiceLable = [[UILabel alloc]init];
//    voiceLable.text = @"发起语音";
//    voiceLable.textAlignment = NSTextAlignmentLeft;
//    voiceLable.font = [UIFont systemFontOfSize:12];
//    
//    voiceLable.backgroundColor = [UIColor clearColor];
//    [voiceLable setTextColor:[UIColor colorWithHexString:@"#ffffff"]];
//    [voiceView addSubview:voiceLable];
//
//    [voiceView addSubview:imageView1];
//
//    voiceView.backgroundColor = [UIColor colorWithHexString:@"#c7c7c7"];
   // [_scheduleView addSubview:voiceView];
    
    //美国时间
    USATimeView = [[UIView alloc]init];
    USATimeView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    //USATimeView.backgroundColor = [UIColor redColor];
    UIImageView * timeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"USA_timeschedule"]];
    //lable
    NSString * downTime = @"02:15";
    UILabel * titleTimeLable = [[UILabel alloc]init];
    NSString * time_USA = [NSString stringWithFormat:@"美国时间:%@",downTime];
    
    
    titleTimeLable.text = time_USA;
    [titleTimeLable setTextColor:[UIColor colorWithHexString:@"#383838"]];
       titleTimeLable.font = [UIFont systemFontOfSize:12];
    [USATimeView addSubview:titleTimeLable];

    [USATimeView addSubview:timeView];
    //[_scheduleView addSubview:USATimeView];
    
//    [USATimeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(voidView.mas_bottom).offset(7);
//        make.left.mas_equalTo(_scheduleView.mas_left);
//        make.right.mas_equalTo(_scheduleView.mas_right);
//        make.bottom.mas_equalTo(_scheduleView.mas_bottom);
//    }];
    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(USATimeView.mas_top).offset(3);
        make.left.mas_equalTo(USATimeView.mas_left).offset(kScreenWidth * 0.30);
        make.size.mas_equalTo(CGSizeMake(17, 17));
       
    }];
//    //USA
//    [titleTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(USATimeView.mas_top).offset(6);
//        make.left.mas_equalTo(timeView.mas_right).offset(10);
//        make.size.mas_equalTo(CGSizeMake(110, 12));
//        
//    }];
    //头上的
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleView.mas_top).offset(16);
        make.left.mas_equalTo(_scheduleView.mas_left).offset(7);
        make.size.mas_equalTo(CGSizeMake(145, 13));
    }];
//    [voiceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_scheduleView.mas_top).offset(9);
//        make.right.mas_equalTo(_scheduleView.mas_right).offset(-5);
//        make.size.mas_equalTo(CGSizeMake(90, 27));
//    }];
    [voidView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleView.mas_top).offset(9);
         make.right.mas_equalTo(_scheduleView.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(90, 27));
    }];
    [voideLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(voidView.mas_top).offset(8);
        make.left.mas_equalTo(voidView.mas_left).offset(34);
        make.size.mas_equalTo(CGSizeMake(49, 12));
    }];
//    [voiceLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(voiceView.mas_top).offset(8);
//        make.left.mas_equalTo(voiceView.mas_left).offset(32);
//        make.size.mas_equalTo(CGSizeMake(49, 12));
//    }];
}
#pragma mark 跳出的预约界面
-(void)clickRightBtn_lastTest{
    
    if ([_isAdvanceRelation isEqualToString:@"1"]) {
        [self clickRightBtnDtl];
        
    }else if ([_isAdvanceRelation isEqualToString:@"0"]){
        [self clickRightBtn];

    }

    
}


-(void)clickRightBtnDtl{
    
           UGScheduleDtlViewController * vc = [[UGScheduleDtlViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        vc.index = [_status intValue];
        vc.advanceId = _advanceId;
        if ([_status isEqualToString:@"1"]) {
            
            vc.type = _type;
        }
        
        [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}
-(void)clickRightBtn{
    //if ([_notime isEqualToString:@"1"]){
        
        UGSchedulingViewController * vc = [[UGSchedulingViewController alloc]init];
        vc.counselorId = _counselorId;
        vc.advanceId = _advanceId;
        vc.indexType = _status;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    
   // } else   {
        //[SVProgressHUD showInfoWithStatus:@"该顾问没有可供预约的时间"];
        //[self performSelector:@selector(dissmiss) withObject:nil afterDelay:2];
    //}
}
-(void)dissmiss{
    
    [SVProgressHUD dismiss];
    
}

#pragma mark - 获取昵称
-(void)get_Nick{
    //头像&昵称的处理
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"userHxCodeString"] = _kHxStr;
    params[@"termType"] = @"2";
    
    [HttpClientManager getAsyn:kHeadImage_Nick_Url params:params success:^(id json) {
        if (json) {
            NSArray *userInfoList = json[@"body"][@"userInfoList"];
            if (userInfoList.count != 0) {//获取到信息
                NSString *nickName = userInfoList[0][@"enName"];
                if (nickName.length != 0) {//有昵称
                    self.navigationItem.title = nickName;
                }else{
                    self.navigationItem.title = _kHxStr;
                }
            }else{
                self.navigationItem.title = _kHxStr;
            }
        }else{
            self.navigationItem.title = _kHxStr;
        }
        
    } failure:^(NSError *error) {
        self.navigationItem.title = _kHxStr;
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    if (self.conversation.type == EMConversationTypeChatRoom)
    {
        //退出聊天室，删除会话
        NSString *chatter = [self.conversation.conversationId copy];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = nil;
            [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
            if (error !=nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Leave chatroom '%@' failed [%@]", chatter, error.errorDescription] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alertView show];
                });
            }
        });
    }
    
    [[EMClient sharedClient] removeDelegate:self];
}
#pragma mark 语音视频
-(void)sendVoice{
    //语音
    // 隐藏键盘
     voiceView.backgroundColor = [UIColor colorWithHexString:@"#c7c7c7"];
    [self performSelector:@selector(voiceViewchange) withObject:nil afterDelay:0.1];

    [self.chatToolbar endEditing:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:@{@"chatter":self.conversation.conversationId, @"type":[NSNumber numberWithInt:0]}];
}
-(void)sendVideo{
    voidView.backgroundColor = [UIColor colorWithHexString:@"#c7c7c7"];
    
    [self performSelector:@selector(voidViewchange) withObject:nil afterDelay:0.1];
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"advanceId"] = _advanceId;
    [HttpClientManager postAsyn:startAdvance params:params success:^(id json) {
        NSLog(@"%@",json);
        
    } failure:^(NSError *error) {
        
    }];
    //视频
    // 隐藏键盘
    [self.chatToolbar endEditing:YES];
    [self rightButton_Action];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:@{@"chatter":self.conversation.conversationId, @"type":[NSNumber numberWithInt:1]}];
    
}
-(void)voidViewchange{
    voidView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
}
-(void)voiceViewchange{
    voiceView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.conversation.type == EMConversationTypeGroupChat) {
        if ([[self.conversation.ext objectForKey:@"subject"] length])
        {
            self.title = [self.conversation.ext objectForKey:@"subject"];
        }
    }
    
//    [self isHaveSchedule];
   
}

#pragma mark - setup subviews

- (void)_setupBarButtonItem
{
//    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [backButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [self.navigationItem setLeftBarButtonItem:backItem];
    //add201603291412  优化界面
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    //单聊
    if (self.conversation.type == EMConversationTypeChat) {
        //add201604091708屏蔽到删除按钮
//        UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
//        [clearButton setTitle:@"Del" forState:UIControlStateNormal];
//        [clearButton setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
//        [clearButton addTarget:self action:@selector(deleteAllMessages:) forControlEvents:UIControlEventTouchUpInside];
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:clearButton];
    }
    else{//群聊
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
        [detailButton setImage:[UIImage imageNamed:@"group_detail"] forState:UIControlStateNormal];
        [detailButton addTarget:self action:@selector(showGroupDetailAction) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:detailButton];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.cancelButtonIndex != buttonIndex) {
        self.messageTimeIntervalTag = -1;
        [self.conversation deleteAllMessages];
        [self.dataArray removeAllObjects];
        [self.messsagesSource removeAllObjects];
        
        [self.tableView reloadData];
    }
}

#pragma mark - EaseMessageViewControllerDelegate

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   canLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self _showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
    }
    return YES;
}

#pragma mark - 点击头像
- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
    //__weak typeof(self) weakSelf = self;
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    //params[@"userHxCodeString"] = [NSString stringWithFormat:@"%@,%@",chatOther_Id,userHxCode];
    params[@"userHxCodeString"] = messageModel.message.from;
    params[@"termType"] = @"1";
    params[@"token"] = kToken;
    
    [HttpClientManager postAsyn:kHeadImage_Nick_Url params:params success:^(id resultData) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:resultData[@"header"]];
        
        DLog(@"resultData--->%@",resultData);
        if ([msg.code isEqualToString:@"200"]) {
            
            NSArray *UserInfoListModelArr = [UserInfoListModel mj_objectArrayWithKeyValuesArray:resultData[@"body"][@"userInfoList"]];
            
            for (UserInfoListModel *model in UserInfoListModelArr) {
                if ([model.roleTyp isEqual:@"1"]) {
                    //顾问
                    UGUserProfileTableViewController *userprofile = [[UGUserProfileTableViewController alloc] init];
                    userprofile.userId = model.userId;
                    userprofile.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:userprofile animated:YES];
                    
                }else if ([model.roleTyp isEqual:@"2"]){
//                   // 家长
                    UGProfileViewController *vc = [[UGProfileViewController alloc]init];
//                    vc.roleType = model.roleTyp;
//                    vc.userId = model.userId;
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            
        }
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - EaseMessageViewControllerDataSource

- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
   // model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
    
    
    
    
    DLog(@"message.from-->%@", model.message.from);
    
    //    DLog(@"kUserHxCode---->%@",kUserHxCode);
    
    DLog(@"ChatVC%@",[NSString stringWithFormat:@"%@%@",kHeadImageUrl,kUserHxCode]);
    
/*
    NSData *data=[[NSData alloc] init];
    
 
    //add201604091043--根据消息是从哪里来的来给头像赋值
    //    //当聊天的对象等于自己
    if ([model.message.from isEqualToString:kUserHxCode]) {
        
        data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHeadImageUrl,kUserHxCode]]];
        if (data) {
            model.avatarImage=[UIImage imageWithData:data];
        }else{
            model.failImageName = @"imageDownloadFail";

        }
        //model.avatarURLPath=[NSString stringWithFormat:@"%@%@",kHeadImageUrl,kUserHxCode];
    }else{
        
         data=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kHeadImageUrl,_kHxStr]]];
        if (data) {
            model.avatarImage=[UIImage imageWithData:data];
        }else{
            model.failImageName = @"imageDownloadFail";

        }
        //model.avatarURLPath=[NSString stringWithFormat:@"%@%@",kHeadImageUrl,_kHxStr];
    }
*/
    
    
    
    //    UserProfileEntity *profileEntity = [[UserProfileManager sharedInstance] getUserProfileByUsername:model.nickname];
    //    if (profileEntity) {
    //        model.avatarURLPath = profileEntity.imageUrl;
    //        model.nickname = profileEntity.nickname;
    //    }
        return model;
}

- (NSArray*)emotionFormessageViewController:(EaseMessageViewController *)viewController
{
    NSMutableArray *emotions = [NSMutableArray array];
    for (NSString *name in [EaseEmoji allEmoji]) {
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:name emotionThumbnail:name emotionOriginal:name emotionOriginalURL:@"" emotionType:EMEmotionDefault];
        [emotions addObject:emotion];
    }
    EaseEmotion *temp = [emotions objectAtIndex:0];
    EaseEmotionManager *managerDefault = [[EaseEmotionManager alloc] initWithType:EMEmotionDefault emotionRow:3 emotionCol:7 emotions:emotions tagImage:[UIImage imageNamed:temp.emotionId]];
    
    NSMutableArray *emotionGifs = [NSMutableArray array];
    _emotionDic = [NSMutableDictionary dictionary];
    NSArray *names = @[@"icon_002",@"icon_007",@"icon_010",@"icon_012",@"icon_013",@"icon_018",@"icon_019",@"icon_020",@"icon_021",@"icon_022",@"icon_024",@"icon_027",@"icon_029",@"icon_030",@"icon_035",@"icon_040"];
    int index = 0;
    for (NSString *name in names) {
        index++;
        EaseEmotion *emotion = [[EaseEmotion alloc] initWithName:[NSString stringWithFormat:@"[示例%d]",index] emotionId:[NSString stringWithFormat:@"em%d",(1000 + index)] emotionThumbnail:[NSString stringWithFormat:@"%@_cover",name] emotionOriginal:[NSString stringWithFormat:@"%@",name] emotionOriginalURL:@"" emotionType:EMEmotionGif];
        [emotionGifs addObject:emotion];
        [_emotionDic setObject:emotion forKey:[NSString stringWithFormat:@"em%d",(1000 + index)]];
    }
    EaseEmotionManager *managerGif= [[EaseEmotionManager alloc] initWithType:EMEmotionGif emotionRow:2 emotionCol:4 emotions:emotionGifs tagImage:[UIImage imageNamed:@"icon_002_cover"]];
    
    return @[managerDefault,managerGif];
}

- (BOOL)isEmotionMessageFormessageViewController:(EaseMessageViewController *)viewController
                                    messageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    if ([messageModel.message.ext objectForKey:MESSAGE_ATTR_IS_BIG_EXPRESSION]) {
        return YES;
    }
    return flag;
}

- (EaseEmotion*)emotionURLFormessageViewController:(EaseMessageViewController *)viewController
                                      messageModel:(id<IMessageModel>)messageModel
{
    NSString *emotionId = [messageModel.message.ext objectForKey:MESSAGE_ATTR_EXPRESSION_ID];
    EaseEmotion *emotion = [_emotionDic objectForKey:emotionId];
    if (emotion == nil) {
        emotion = [[EaseEmotion alloc] initWithName:@"" emotionId:emotionId emotionThumbnail:@"" emotionOriginal:@"" emotionOriginalURL:@"" emotionType:EMEmotionGif];
    }
    return emotion;
}

- (NSDictionary*)emotionExtFormessageViewController:(EaseMessageViewController *)viewController
                                        easeEmotion:(EaseEmotion*)easeEmotion
{
    return @{MESSAGE_ATTR_EXPRESSION_ID:easeEmotion.emotionId,MESSAGE_ATTR_IS_BIG_EXPRESSION:@(YES)};
}

#pragma mark - EaseMob

#pragma mark - EMClientDelegate

- (void)didLoginFromOtherDevice
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

- (void)didRemovedFromServer
{
    if ([self.imagePicker.mediaTypes count] > 0 && [[self.imagePicker.mediaTypes objectAtIndex:0] isEqualToString:(NSString *)kUTTypeMovie]) {
        [self.imagePicker stopVideoCapture];
    }
}

#pragma mark - action

- (void)backAction
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].roomManager removeDelegate:self];
    //    [[ChatDemoHelper shareHelper] setChatVC:nil];
    [[ChatHelper shareHelper] setChatVC:nil];
    
    
    //add201603271757  在退出聊天界面的时候重新设置tabbar的bandage  刷新conversationVC 这个view
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUnreadMessageCount" object:nil];

    [[AppDelegate sharedappDelegate].tabbar setupUnreadMessageCount];
     [[AppDelegate sharedappDelegate].tabbar.conversationVC refreshAndSortView];
    
    
    if (self.deleteConversationIfNull) {
        //判断当前会话是否为空，若符合则删除该会话
        EMMessage *message = [self.conversation latestMessage];
        if (message == nil) {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId deleteMessages:NO];
        }
    }
    
    //返回列表（有预约关系）
    if ([User_Default objectForKey:@"advanceUbao"]) {
        [User_Default removeObjectForKey:@"advanceUbao"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showGroupDetailAction
{
    [self.view endEditing:YES];
    //    if (self.conversation.type == EMConversationTypeGroupChat) {
    //        ChatGroupDetailViewController *detailController = [[ChatGroupDetailViewController alloc] initWithGroupId:self.conversation.conversationId];
    //        [self.navigationController pushViewController:detailController animated:YES];
    //    }
    //    else if (self.conversation.type == EMConversationTypeChatRoom)
    //    {
    //        ChatroomDetailViewController *detailController = [[ChatroomDetailViewController alloc] initWithChatroomId:self.conversation.conversationId];
    //        [self.navigationController pushViewController:detailController animated:YES];
    //    }
}

- (void)deleteAllMessages:(id)sender
{
    if (self.dataArray.count == 0) {
        [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        return;
    }
    
    if ([sender isKindOfClass:[NSNotification class]]) {
        NSString *groupId = (NSString *)[(NSNotification *)sender object];
        BOOL isDelete = [groupId isEqualToString:self.conversation.conversationId];
        if (self.conversation.type != EMConversationTypeChat && isDelete) {
            self.messageTimeIntervalTag = -1;
            [self.conversation deleteAllMessages];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:NSLocalizedString(@"message.noMessage", @"no messages")];
        }
    }
    else if ([sender isKindOfClass:[UIButton class]]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"sureToDelete", @"please make sure to delete") delegate:self cancelButtonTitle:NSLocalizedString(@"cancel", @"Cancel") otherButtonTitles:NSLocalizedString(@"ok", @"OK"), nil];
        [alertView show];
    }
}

- (void)transpondMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
//        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        //        ContactListSelectViewController *listViewController = [[ContactListSelectViewController alloc] initWithNibName:nil bundle:nil];
        //        listViewController.messageModel = model;
        //        [listViewController tableViewDidTriggerHeaderRefresh];
        //        [self.navigationController pushViewController:listViewController animated:YES];
    }
    self.menuIndexPath = nil;
}

- (void)copyMenuAction:(id)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        pasteboard.string = model.text;
    }
    
    self.menuIndexPath = nil;
}

- (void)deleteMenuAction:(id)sender
{
    if (self.menuIndexPath && self.menuIndexPath.row > 0) {
        id<IMessageModel> model = [self.dataArray objectAtIndex:self.menuIndexPath.row];
        NSMutableIndexSet *indexs = [NSMutableIndexSet indexSetWithIndex:self.menuIndexPath.row];
        NSMutableArray *indexPaths = [NSMutableArray arrayWithObjects:self.menuIndexPath, nil];
        
        [self.conversation deleteMessageWithId:model.message.messageId];
        [self.messsagesSource removeObject:model.message];
        
        if (self.menuIndexPath.row - 1 >= 0) {
            id nextMessage = nil;
            id prevMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row - 1)];
            if (self.menuIndexPath.row + 1 < [self.dataArray count]) {
                nextMessage = [self.dataArray objectAtIndex:(self.menuIndexPath.row + 1)];
            }
            if ((!nextMessage || [nextMessage isKindOfClass:[NSString class]]) && [prevMessage isKindOfClass:[NSString class]]) {
                [indexs addIndex:self.menuIndexPath.row - 1];
                [indexPaths addObject:[NSIndexPath indexPathForRow:(self.menuIndexPath.row - 1) inSection:0]];
            }
        }
        
        [self.dataArray removeObjectsAtIndexes:indexs];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        
        
        if ([self.dataArray count] == 0) {
            self.messageTimeIntervalTag = -1;
        }
    }
    
    self.menuIndexPath = nil;
}

#pragma mark - notification
- (void)exitGroup
{
    [self.navigationController popToViewController:self animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)insertCallMessage:(NSNotification *)notification
{
    id object = notification.object;
    if (object) {
        EMMessage *message = (EMMessage *)object;
        [self addMessageToDataSource:message progress:nil];
        [[EMClient sharedClient].chatManager importMessages:@[message]];
    }
}

- (void)handleCallNotification:(NSNotification *)notification
{
    id object = notification.object;
    if ([object isKindOfClass:[NSDictionary class]]) {
        //开始call
        self.isViewDidAppear = NO;
    } else {
        //结束call
        self.isViewDidAppear = YES;
    }
}

#pragma mark - private

- (void)_showMenuViewController:(UIView *)showInView
                   andIndexPath:(NSIndexPath *)indexPath
                    messageType:(EMMessageBodyType)messageType
{
    if (self.menuController == nil) {
        self.menuController = [UIMenuController sharedMenuController];
    }
    
    if (_deleteMenuItem == nil) {
        _deleteMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"delete", @"Delete") action:@selector(deleteMenuAction:)];
    }
    
    if (_copyMenuItem == nil) {
        _copyMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"copy", @"Copy") action:@selector(copyMenuAction:)];
    }
    
    if (_transpondMenuItem == nil) {
        _transpondMenuItem = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"transpond", @"Transpond") action:@selector(transpondMenuAction:)];
    }
    
    if (messageType == EMMessageBodyTypeText) {
        [self.menuController setMenuItems:@[_copyMenuItem, _deleteMenuItem,_transpondMenuItem]];
    } else if (messageType == EMMessageBodyTypeImage){
        [self.menuController setMenuItems:@[_deleteMenuItem,_transpondMenuItem]];
    } else {
        [self.menuController setMenuItems:@[_deleteMenuItem]];
    }
    [self.menuController setTargetRect:showInView.frame inView:showInView.superview];
    [self.menuController setMenuVisible:YES animated:YES];
}
-(void)test{
    _alretView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _alretView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
//    
//        [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_alretView];
    [self.view addSubview:_alretView];
    [self.view bringSubviewToFront:_alretView];
        _EvaluationView = [[UIView alloc]init];
    _EvaluationView.backgroundColor = [UIColor whiteColor];
    
                           if(kScreenWidth==320){
                               _EvaluationView.frame = CGRectMake(24, 30, 272, 329);
                           }else{
                               _EvaluationView.frame = CGRectMake(52, 60, 272, 329);
                           }

    [_alretView addSubview:_EvaluationView];
    NSArray * array = [NSArray arrayWithObjects:@"很合适，希望进一步了解",@"再看看其他顾问",@"不合适", nil];
    
    UILabel * evluation = [[UILabel alloc]init];
    evluation.text = @"评价";
    evluation.font =[UIFont systemFontOfSize:16];
    evluation.textColor = [UIColor colorWithHexString:@"#4c4c4c"];
    UITapGestureRecognizer * contactRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
    
    [_EvaluationView addGestureRecognizer:contactRecognizer];
    [_EvaluationView addSubview:evluation];
    
    
    
    UIButton * cancleBtn = [[UIButton alloc]init];
    
    [cancleBtn setImage:[UIImage imageNamed:@"schedule_cancle_btn" ] forState:UIControlStateNormal];
    //[cancleBtn addTarget:self action:@selector(blackView)  forControlEvents:UIControlEventTouchUpInside];
    UIView * clrearView = [[UIView alloc] init];
    clrearView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackView)];
    
    [clrearView addGestureRecognizer:tapRecognizer];
    [_EvaluationView addSubview:clrearView];
    [_EvaluationView addSubview:cancleBtn];
    [_EvaluationView insertSubview:clrearView aboveSubview:cancleBtn];
    
    
    
    
    
    
    for (int i =0; i<3; i++ ) {
        UIButton * cancleDtlBtn = [[UIButton alloc]init];
        cancleDtlBtn.layer.cornerRadius = 10;
        [cancleDtlBtn setTitle:array[i] forState:UIControlStateNormal];
        cancleDtlBtn.layer.borderWidth = 0.5;
        cancleDtlBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        cancleDtlBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancleDtlBtn addTarget:self action:@selector(clickCancleBtn:) forControlEvents: UIControlEventTouchUpInside];
        [cancleDtlBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal ];
        [_EvaluationView addSubview:cancleDtlBtn];
        
        if (i==0) {
            
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_EvaluationView.mas_top).offset(48);
                make.centerX.mas_equalTo(_EvaluationView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));
                
            }];
        }else if(i==1){
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_EvaluationView.mas_top).offset(87);
                make.centerX.mas_equalTo(_EvaluationView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));
                
            }];
            
        }else if(i==2){
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_EvaluationView.mas_top).offset(126);
                make.centerX.mas_equalTo(_EvaluationView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));
                
                
            }];
        }
        
    }
    
    
    //留言
    UILabel * leaveMessage = [[UILabel alloc]init];
    leaveMessage.text = @"留言:";
    leaveMessage.font = [UIFont systemFontOfSize:14];
    [leaveMessage setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    leaveMessage.textAlignment =  NSTextAlignmentLeft;
    [_EvaluationView addSubview:leaveMessage];
    //输入框
    _leaveMessageView = [[UITextView alloc] init];
    _leaveMessageView.delegate = self;
    _leaveMessageView.layer.borderWidth = 0.5;
    _leaveMessageView.layer.borderColor = RGB(227, 227, 227).CGColor;
    [_EvaluationView addSubview:_leaveMessageView];
    //确定按钮
    UIButton * bottomBtn = [[UIButton alloc]init];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBtn setTitle:@"确定" forState: UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState: UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    [_EvaluationView addSubview:bottomBtn];
    
    
    [evluation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_EvaluationView.mas_top).offset(10);
        make.centerX.mas_equalTo(_EvaluationView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(33, 16));
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_EvaluationView.mas_top).offset(10);
        make.right.mas_equalTo(_EvaluationView.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12, 13));
    }];
    [clrearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancleBtn.mas_top).offset(-10);
        make.right.mas_equalTo(_EvaluationView.mas_right);
        make.size.mas_equalTo(CGSizeMake(32, 33));
    }];
    [leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_EvaluationView.mas_top).offset(173);
        make.left.mas_equalTo(_EvaluationView.mas_left).offset(23);
        make.size.mas_equalTo(CGSizeMake(43, 14));
    }];
    [_leaveMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_EvaluationView.mas_top).offset(197);
        make.left.mas_equalTo(_EvaluationView.mas_left).offset(25);
        make.size.mas_equalTo(CGSizeMake(220, 72));
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_EvaluationView.mas_bottom);
        make.left.mas_equalTo(_EvaluationView.mas_left);
        make.right.mas_equalTo(_EvaluationView.mas_right);
        make.height.mas_equalTo(36);
    }];
    

    
    
    
}
-(void)clickcontactRecognizer{
    
    
    
    [_leaveMessageView resignFirstResponder];
}
-(void)clickBottomBtn{
    
           NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"token"]= kToken;
        params[@"advanceId"]= _advanceId;
        params[@"commentTitle"]= _btnString;
        params[@"comment"]= _leaveMessageView.text;
    
    
        NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
        params1[@"token"]= kToken;
        params1[@"advanceId"]= _advanceId;
        
        NSLog(@"%@",self.advanceId);
    
    
    
        [HttpClientManager postAsyn:advanceCommentClient params:params success:^(id json) {
            NSLog(@"params.description====%@",params.description);
            NSLog(@"%@",json);
            NSString * str = json[@"header"][@"code"];
            if ([str isEqualToString:@"200"]) {
              
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
        
                [_scheduleView removeFromSuperview];
                [_alretView  removeFromSuperview];
                self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-46);
                           }
            
        } failure:^(NSError *error) {
            
        }];
    [HttpClientManager postAsyn:updateAdvanceStatus params:params1 success:^(id json) {
          NSLog(@"params1.description====%@",params1.description);
        NSLog(@"%@",json);
        NSString * str = json[@"header"][@"code"];
        if ([str isEqualToString:@"200"]) {
            [_scheduleView removeFromSuperview];
            [_alretView  removeFromSuperview];
       
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(void)clickCancleBtn:(UIButton *)sender{
    if (_evluationBtn ==sender) {
        
    }else{
        
        sender.backgroundColor = RGB(38, 189, 171);
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _evluationBtn.backgroundColor = [UIColor whiteColor];
        _evluationBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [_evluationBtn setTitleColor: [UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal];
        _evluationBtn.layer.masksToBounds = YES;
    }
    
    
    _evluationBtn = sender;
    _btnString =  _evluationBtn.titleLabel.text;
    
}
-(void)blackView{
    
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"]= kToken;
    params[@"advanceId"]= _advanceId;
    
    
    NSLog(@"%@",_advanceId);
    [HttpClientManager postAsyn:updateAdvanceStatus params:params success:^(id json) {
          NSLog(@"params2.description====%@",params.description);
        NSLog(@"%@",json);
        NSString * str = json[@"header"][@"code"];
        if ([str isEqualToString:@"200"]) {
           
            
   self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-46);
        }
        
    } failure:^(NSError *error) {
        
    }];

      [_scheduleView removeFromSuperview];
    [_alretView  removeFromSuperview];
}


#pragma mark *******ZooM*******介入细节

-(void)button_addVideo{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:12];
    
    rightButton.frame = CGRectMake(kScreenWidth-90, 10, 80, 40);
    rightButton.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    [rightButton setTitle:@"创建视频" forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButton_Action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightButton];
    
}
-(void)rightButton_Action
{
    //[self creatrVideoMeetting];
    [self getZoomHost_id];
}

#pragma mark - zoom视频的创建
-(void)creatrVideoMeetting:(NSString *)hostId name:(NSString *)name{
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"api_key"] = KZoomAPIKey;
    params[@"api_secret"] = KZoomAPISecret;
    //params[@"host_id"] = @"CP-Ef-kxSJ2_4Iq5i1itGw";
    params[@"host_id"] = hostId;
    params[@"topic"] = @"meeting";
    params[@"type"] = @"1";
    
    [HttpClientManager postAsyn:@"https://api.zoom.us/v1/meeting/create" params:params success:^(id resultData) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",resultData);
        
        NSString *host_id = [NSString stringWithFormat:@"%@",resultData[@"host_id"]];
        NSString *idName  = [NSString stringWithFormat:@"%@",resultData[@"id"]];
        
        if (host_id.length > 0) {
            [[AppDelegate sharedappDelegate] showZoomVideo];
            
            ZoomSDKMeetingService *ms = [[ZoomSDK sharedSDK] getMeetingService];
            if (ms)
            {
                [self insertZoom_id:idName];
                [self loadRequestGetName];//获取名字

                ms.delegate = self;
                if (!_name_zoom) {
                    _name_zoom = @"Urgoo";
                }
                ZoomSDKMeetError ret = [ms startMeeting:host_id userToken:kSDKUserToken userType:ZoomSDKUserType_APIUser displayName:_name_zoom meetingNumber:idName];
                NSLog(@"onJoinaMeeting ret返回信息:%d", ret);
            }
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

-(void)getZoomHost_id{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    //params[@"token"] = @"ENW2behsR+g=";
    [SVProgressHUD showWithStatus:@"Loading..."];
    [HttpClientManager postAsyn:UG_getZoomHost_id_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *host_id = json[@"body"][@"hostId"];
            NSString *name = json[@"body"][@"name"];
            if (host_id.length > 0) {
                [self creatrVideoMeetting:host_id name:name];
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"Network request failed, please try again later"];
    }];
    
}

-(void)insertZoom_id:(NSString *)zoomId{
    
    [SVProgressHUD showWithStatus:@"Loading..."];
    //
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"]      = kToken;
    params[@"zoomNo"]     = zoomId;
    params[@"userHxCode"] = _kHxStr;
    NSString *zoomChatId = [[NSUserDefaults standardUserDefaults] objectForKey:@"zoomChatId"];
    if (zoomChatId.length > 0) {
        params[@"zoomChatId"] = zoomChatId;
    }
    
    DLog(@"%@",params);
    
    [HttpClientManager postAsyn:UG_insertZoomNumber_id_URL params:params success:^(id json) {
        NSLog(@"%@",json);
        [SVProgressHUD dismiss];
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *zoomChatId = json[@"body"][@"zoomChatId"];
            [[NSUserDefaults standardUserDefaults] setObject:zoomChatId forKey:@"zoomChatId"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            DLog(@"创建的房间号：%@",zoomChatId);
            [self sendMessageNoteVideoStare];
        }else if ([msg.code isEqualToString:@"400"]) {
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}




#pragma mark - Meeting Service Delegate
- (void)onMeetingReturn:(ZoomSDKMeetError)error internalError:(NSInteger)internalError
{
    NSLog(@"onMeetingReturn:%d, internalError:%zd", error, internalError);
}

- (void)onMeetingStateChange:(ZoomSDKMeetingState)state
{
    NSLog(@"onMeetingStateChange:%d", state);
    if (state == ZoomSDKMeetingState_Idle) {
        [User_Default removeObjectForKey:@"LoctionZoom"];
        [[AppDelegate sharedappDelegate] showTabBar];
    }
    
#if 1
    if (state == ZoomSDKMeetingState_InMeeting)
    {
        //For customizing the content of Invite by SMS
        NSString *meetingID = [[ZoomSDKInviteHelper sharedInstance] meetingID];
        NSString *smsMessage = [NSString stringWithFormat:NSLocalizedString(@"Please join meeting with ID: %@", @""), meetingID];
        [[ZoomSDKInviteHelper sharedInstance] setInviteSMS:smsMessage];
        
        //For customizing the content of Copy URL
        NSString *joinURL = [[ZoomSDKInviteHelper sharedInstance] joinMeetingURL];
        NSString *copyURLMsg = [NSString stringWithFormat:NSLocalizedString(@"Meeting URL: %@", @""), joinURL];
        [[ZoomSDKInviteHelper sharedInstance] setInviteCopyURL:copyURLMsg];
    }
#endif
    
#if 0
    //For adding customize view above the meeting view
    if (state == ZoomSDKMeetingState_InMeeting)
    {
        ZoomSDKMeetingService *ms = [[ZoomSDK sharedSDK] getMeetingService];
        UIView *v = [ms meetingView];
        
        UIView *sv = [[UIView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, 64)];
        sv.backgroundColor = [UIColor clearColor];
        [v addSubview:sv];
        [self creatZoomVideo_button:sv];
    }
    
#endif
}

-(void)creatZoomVideo_button:(UIView *)view{
    UIButton *zoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zoomButton.frame = CGRectMake(kScreenWidth- 60, 0, 40, view.height);
    [zoomButton setTitle:@"结束" forState:UIControlStateNormal];
    [zoomButton addTarget:self action:@selector(zoomButnClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:zoomButton];
}
-(void)zoomButnClick{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"结束视频" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [sheet showInView:[[[ZoomSDK sharedSDK] getMeetingService] meetingView]];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.cancelButtonIndex != buttonIndex) {
        [[[ZoomSDK sharedSDK] getMeetingService] leaveMeetingWithCmd:LeaveMeetingCmd_End];
    }
}
-(void)sendMessageNoteVideoStare{
    //发送文字消息
    EMMessage *message = [EaseSDKHelper sendTextMessage:@"Video chat is starting"
                                                     to:_kHxStr//接收方
                                            messageType:EMChatTypeChat//消息类型
                                             messageExt:nil]; //扩展信息
    
    //发送构造成功的消息
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        NSLog(@"");
    }];
    
}

#pragma mark - 名字
-(void)loadRequestGetName
{
    
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"userHxCode"] = _kHxStr;
    
    [HttpClientManager getAsyn:UG_zoomHostName_URL params:params success:^(id resultData) {
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:resultData[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
          
            _name_zoom =resultData[@"body"][@"name"];
            
        }
        
        
        } failure:^(NSError *error) {
        
        
    }];
    
    
}
#pragma mark ********** 视频view *********（以下是加入房间）
-(void)isClientAcceptVideoStatus:(NSString *)state result:(void(^)())success{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"userHxCode"] = _kHxStr;
    params[@"opStatus"] = state;// 1.接受 2.拒接 0.未操作
    
     [HttpClientManager postAsyn:isClientcceptStates params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            success();
            
        }else if ([msg.code isEqualToString:@"400"]) {
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络请求超时，请稍后再试！"];
    }];
    
    
}
-(void)video_view{
    
    CGRect frame = self.tableView.frame;
    self.tableView.frame = CGRectMake(0, 125, frame.size.width, frame.size.height-125);
    
    UIView *video_zoom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 125)];
    video_zoom.layer.borderWidth = 0.5;
    video_zoom.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    video_zoom.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:video_zoom];
    
    UILabel *time_zoom = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, kScreenWidth, 15)];
    time_zoom.text = @"对方向您发起视频";
    time_zoom.font = [UIFont systemFontOfSize:13];
    time_zoom.textAlignment = NSTextAlignmentCenter;
    time_zoom.textColor = [UIColor colorWithHexString:@"434343"];
    [video_zoom addSubview:time_zoom];
    
    CGFloat widthL = 83*kScreenWidth/375;
    NSArray *arr = @[@"拒绝",@"接受"];
    for (int i = 0; i < 2; i ++) {
        
        UIButton *butn_zoom = [UIButton buttonWithType:UIButtonTypeCustom];
        butn_zoom.titleLabel.font = [UIFont systemFontOfSize:15];
        butn_zoom.layer.cornerRadius = 30;
        butn_zoom.layer.masksToBounds = YES;
        butn_zoom.titleLabel.font = [UIFont systemFontOfSize:12];
        butn_zoom.tag = 999 +i;
        [butn_zoom setTitle:arr[i] forState:UIControlStateNormal];
        if (i == 0) {
            butn_zoom.frame = CGRectMake(widthL , 48, 60, 60);
            [butn_zoom setBackgroundColor:[UIColor colorWithHexString:@"ff4e45"]];
        }else{
            butn_zoom.frame = CGRectMake(kScreenWidth-widthL-60 , 48, 60, 60);
            [butn_zoom setBackgroundColor:[UIColor colorWithHexString:@"0fb967"]];
        }
        [butn_zoom addTarget:self action:@selector(click_zoom:) forControlEvents:UIControlEventTouchUpInside];
        [video_zoom addSubview:butn_zoom];
    }
    
}
-(void)click_zoom:(UIButton *)button{
    if (button.tag == 1000) {
        //jion
        //[self getMeetingNumid];
        if (_numId) {
            [self addMeeting:_numId];
        }
        
        
    }else if (button.tag == 999){
        //reject
        [self isClientAcceptVideoStatus:@"2" result:^{
            
        }];
    }
}
-(void)getMeetingNumid{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"userHxCode"] = _kHxStr;
    
    [HttpClientManager postAsyn:UG_zoomHostNumber_URL params:params success:^(id json) {
        
        NSLog(@"%@",json);
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSString *numId = [NSString stringWithFormat:@"%@",json[@"body"][@"zoomNo"]];
            NSString *name = [NSString stringWithFormat:@"%@",json[@"body"][@"name"]];
            NSString *status = [NSString stringWithFormat:@"%@",json[@"body"][@"status"]];
            _numId = numId;
            
            if ([status isEqualToString:@"STARTED"]) {
                [self video_view];
                _name_zoom   = name;
                
                [self isClientAcceptVideoStatus:@"1" result:^{
                }];
                if ( _JPushZoom) {
                    _JPushZoom = NO;
                    [self addMeeting:numId];
                }
                
            }else{
                [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后再试！"];
            }
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络请求超时，请稍后再试！"];
    }];
}

-(void)addMeeting:(NSString *)numId{
    
    [[AppDelegate sharedappDelegate] showZoomVideo];
    if (!_name_zoom) {
        _name_zoom = @"Urgoo";
    }
    
    ZoomSDKMeetingService *ms = [[ZoomSDK sharedSDK] getMeetingService];
    if (ms)
    {
        ms.delegate = self;
        ZoomSDKMeetError ret = [ms joinMeeting:numId displayName:_name_zoom password:@""];
        NSLog(@"onJoinaMeeting ret:%d", ret);
    }
}
#pragma mark ********(以上是加入房间)*******



//显示时间
-(void)isTimeNoteShow{
    
    CGFloat YY = self.tableView.y;
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, YY, kScreenWidth, 21);
    view.backgroundColor = self.tableView.backgroundColor;
    [self.view addSubview:view];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(kScreenWidth/2-60, 1.5, 17, 17);
    imageV.image = [UIImage imageNamed:@"times_icontimes_icon"];
    [view addSubview:imageV];
    
    UILabel *timeLable = [[UILabel alloc] init];
    timeLable.frame = CGRectMake(imageV.x+imageV.width+5, 4, 100, 12);
    timeLable.font = [UIFont systemFontOfSize:12];
    timeLable.text = [NSString stringWithFormat:@"美国东部:%@",[self KgetTimeZoneBydate]] ;
    timeLable.textColor = [UIColor colorWithHexString:@"676767"];
    [view addSubview:timeLable];
    
}
-(NSString *)KgetTimeZoneBydate{
    
    NSDate *date = [NSDate date];
    
    //NSTimeInterval beijingInterval = 8*60*60;
    NSTimeInterval USAEastCoasttimeInterval = -4*60*60;
    
    //NSDate *beijingDateNow = [[NSDate alloc] initWithTimeInterval:beijingInterval sinceDate:date];
    NSDate *USAEastCoasttimeDateNow = [[NSDate alloc] initWithTimeInterval:USAEastCoasttimeInterval sinceDate:date];
    
    NSMutableString *time = [NSMutableString stringWithFormat:@"%@",[self dateToString:USAEastCoasttimeDateNow]];
    NSRange range = NSMakeRange([time rangeOfString:@" "].location, 6);
    NSString *timeNew = [time substringWithRange:range];
    
    return timeNew;
}
- (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
@end
