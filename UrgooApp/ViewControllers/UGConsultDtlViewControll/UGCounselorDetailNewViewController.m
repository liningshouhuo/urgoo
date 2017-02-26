//
//  UGCounselorDetailNewViewController.m
//  client
//
//  Created by IOS开发者 on 16/7/7.
//  Copyright © 2016年 IOS开发者. All rights reserved.
//

#import "UGCounselorDetailNewViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "UGcounselorDetailHeardView.h"
#import "UGAbout_counselorCell.h"
#import "UGAbount_searveCell.h"
#import "UGAbount_employCell.h"
#import "UGAbount_employPlanCell.h"
#import "UGChatViewController.h"
#import "CounselorDetailSubListModel.h"
#import "CounselorDetailssModel.h"
#import "CounselorDedailDataModel.h"
#import "EmployServiceModel.h"
#import "UGSchedulingViewController.h"
#import "UGConfirmOrderViewController.h"
#import "UGCounselorWorkssViewController.h"
#import "UGLiveVideoDetailViewController.h"
#import "EduListsModel.h"
#import "UGScheduleDtlViewController.h"

//share
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
// 自定义分享菜单栏需要导入的头文件
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//#自定义分享编辑界面所需要导入的头文件
#import <ShareSDKUI/SSUIEditorViewStyle.h>

#import "MalertView.h"
#import "ShareXinLangWeiBoVC.h"

#import "WXApi.h"

#import "UGServeDtlViewController.h"
// 导航条的高度 44
CGFloat const STNavigationBarHeight = 44;

// 状态栏的高度 20
CGFloat const STStatusBarHeight = 20;

@interface UGCounselorDetailNewViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate,AVPlayerViewControllerDelegate,MalertItemSelectDelegate>
{
    AVPlayer *player;
    AVPlayerViewController *playerVC;
    UIButton *attention;
    UIView   *imageBackG;
    
    NSMutableArray *imageUrlArray;
    NSMutableArray *typeArray;
    NSMutableArray *videoArr;
    NSArray        *detailModelArr;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel     *titleView;
@property (nonatomic, strong) UIButton    *buttonBack;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView      *bottomView;
@property (nonatomic, strong) NSMutableArray *subListArr;
@property (nonatomic, strong) NSArray        *employArr;
@property (nonatomic,copy)    NSString       *hXcode;
@property (nonatomic,strong)  UIView         *alphaView;
@property (nonatomic,strong)  UIView         *guide;
@property (nonatomic,copy)    NSString       *isAdvanceRelation;
@property (nonatomic,copy)    NSString       *advanceId;
@property (nonatomic,copy)    NSString       *status;
@property (nonatomic,copy)    NSString       *type;

@property (nonatomic, strong) UGcounselorDetailHeardView  *detailHeardView;
@property (nonatomic, strong) CounselorDetailSubListModel *subListModel;
@property (nonatomic, strong) CounselorDedailDataModel    *DetailDataModel;
@property (nonatomic, strong) CounselorDetailssModel      *DetailModel;
@property (nonatomic, strong) ShareDetailsModel           *shareDetailsModel;

@property (strong, nonatomic) MalertView *alert;

@end

@implementation UGCounselorDetailNewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    //[self.navigationController.navigationBar setTranslucent:NO];
    
    [self initUI];
    
    [self getNetDataCounselorDetailImageAndVideo];
    [self getNetDataStatCounselorCount];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[AppDelegate sharedappDelegate] zoomVideoViewByGetNetData];
    [super viewWillAppear:YES];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - --- ScrollViewdelegate ---
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat progress = offsetY / 260*kScreenHeight/667;
    //CGFloat progressChange = offsetY / (kScreenWidth/2 - 64 - 44);
    //NSLog(@"%f, %f, %f",progressChange, progress, offsetY);
    
    if (progress < 1) {
        _alphaView.alpha = progress;
    }else if (progress >= 1){
        _alphaView.alpha = 1.0;
    }
}

-(void)initUI
{
    detailModelArr = [NSArray array];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.buttonBack];
    
    _detailHeardView = [[UGcounselorDetailHeardView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 440)];
    self.tableView.tableHeaderView = _detailHeardView;
    
    typeof(self) weakSelf = self;
    _detailHeardView.videoBlock = ^(NSString *videoUrl,NSInteger butnTag,CounselorDetailssModel *model){
        if (videoUrl) {
            [weakSelf KAddAVPlayerViewControllerURL:videoUrl];
        }else{
            [weakSelf imageViewAppearance:butnTag model:model];
        }
    };
    
    _detailHeardView.attentionBlock = ^(BOOL selectButn){
        if (selectButn) {
            [weakSelf getNetDataCounselorAddFollow];
        }else{
            [weakSelf getNetDataCounselorCancleFollow];
        }
    };
    
    //分享
    _detailHeardView.shareBlock = ^(){
        //分享
        [weakSelf shareWeiXin:weakSelf.shareDetailsModel];
    };
    
    [self KKaddBottomView];
    
    if (![User_Default objectForKey:@"Group_guide_b"]) {
        [self kkAddGuide];
    }
}

#pragma mark - 点击图片放大
-(void)imageViewAppearance:(NSInteger )integer model:(CounselorDetailssModel *)model
{
    imageBackG = [[UIView alloc] init];
    imageBackG.frame = self.view.bounds;
    imageBackG.hidden = NO;
    imageBackG.backgroundColor = RGBAlpha(0, 0, 0, 1);
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageBackG)];
    [imageBackG addGestureRecognizer:tapp];
    [[UIApplication sharedApplication].keyWindow addSubview:imageBackG];
    
    imageUrlArray = [NSMutableArray array];
    typeArray = [NSMutableArray array];
    videoArr  = [NSMutableArray array];
    for (CounselorDetailSubListModel *subListModel in detailModelArr) {
        [imageUrlArray addObject:subListModel.url];
        [typeArray addObject:subListModel.type];
        [videoArr addObject:subListModel.videoPic];
    }
    
    NSArray *imageArr = [NSArray array];;
    imageArr = imageUrlArray;
    UIScrollView *_scrollsView = [[UIScrollView alloc] init];
    _scrollsView.frame = CGRectMake(0, kScreenHeight/4, kScreenWidth, kScreenWidth/1.64);
    _scrollsView.contentSize = CGSizeMake(kScreenWidth*imageArr.count, 0);
    _scrollsView.pagingEnabled = YES;
    _scrollsView.backgroundColor = RGB(0, 0, 0);
    CGPoint p = CGPointMake(kScreenWidth*integer, 0);
    [_scrollsView setContentOffset:p animated:YES];

    for (int i = 0; i < imageArr.count; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, _scrollsView.height)];
        if ([StringHelper isUserIconContainHttp:imageArr[i]]) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@%@",UG_HOST1,imageArr[i]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
        }
        imageV.layer.masksToBounds = YES;
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        if ([typeArray[i] isEqualToString:@"1"]) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:videoArr[i]] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
            
            UIImageView *video = [[UIImageView alloc] init];
            video.frame  = CGRectMake(0, 0, 50, 50);
            video.center = CGPointMake(imageV.centerX/kScreenWidth+kScreenWidth/2, imageV.centerY+10);
            video.image  = [UIImage imageNamed:@"icon_play_video2"];
            //[imageV addSubview:video];
        }
        
        UIButton *touch = [UIButton buttonWithType:UIButtonTypeCustom];
        touch.frame = imageV.bounds;
        touch.tag = 200 + i;
        [touch addTarget:self action:@selector(tapTouchImage:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:touch];
        
        [_scrollsView addSubview:imageV];
    }
    [imageBackG addSubview:_scrollsView];
    
}
-(void)clickImageBackG
{
    [UIView animateWithDuration:2.0 animations:^{
        imageBackG.hidden = YES;
    }];
}
-(void)tapTouchImage:(UIButton *)butn
{
    NSString *type = typeArray[butn.tag - 200];
    NSString *url  = imageUrlArray[butn.tag - 200];
    if ([type isEqualToString:@"1"]) {
        imageBackG.hidden = YES;
        [self KAddAVPlayerViewControllerURL:url];
    }
}


-(void)shareWeiXin:(ShareDetailsModel *)model
{
    _shareDetailsModel = model;
    
    [_alert removeFromSuperview];
    typeof(self) weakSelf = self;
    
    _alert = [[MalertView alloc] initWithImageArrOfButton:@[@"share_weixin_icon",@"share_weixinFriend_icon",@"share_weibo_icon"]];
    [[UIApplication sharedApplication].keyWindow addSubview:_alert];
    
    _alert.selectBlock = ^(NSInteger index){
        [weakSelf malertItemSelect:index];
    };
    
    [_alert showAlert];
    
    
  /*
   // NSString * str = @"http://mob.com/Assets/images/logo.png?v=20150320";
   NSArray *imageArray;
    //UIImage * iamge = [UIImage imageNamed:@"1.1m"];
    if(model.pic){
       imageArray = @[model.pic];
    }else
  imageArray = @[@""];
   
    //imageArray = @[@"4"];
        // [@"ShareDetailsModel"] model.text
    // （//注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSString * strUrl = [NSString stringWithFormat:@"%@%@",UG_HOST,model.url];
        
        NSLog(@"%@",strUrl);

        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        [shareParams SSDKSetupShareParamsByText:model.text
                                         images:imageArray
                                            url:[NSURL URLWithString:strUrl]
                                          title:model.title
                                           type:SSDKContentTypeAuto];
        //设置编辑界面标题颜色
        [SSUIEditorViewStyle setTitleColor:[UIColor whiteColor]];
        //设置取消发布标签文本颜色
        [SSUIEditorViewStyle setCancelButtonLabelColor:[UIColor whiteColor]];
        [SSUIEditorViewStyle setShareButtonLabelColor:[UIColor whiteColor]];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        
        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
            
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                        message:[NSString stringWithFormat:@"%@", error]
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateCancel:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                default:
                    break;
            }
        }];
    }*/
}

- (void)malertItemSelect:(NSInteger)index
{
    NSLog(@"点击了－－－%ld",index);
    NSString *descripStr = _shareDetailsModel.text;
    NSString *titleStr = _shareDetailsModel.title;
    
    _alert.hidden = YES ;
    typeof(self) weakSelf = self;
    NSArray *imageArray;
    imageArray = @[_shareDetailsModel.pic];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * strUrl = [NSString stringWithFormat:@"%@%@",UG_HOST,_shareDetailsModel.url];
    
    [shareParams SSDKSetupShareParamsByText:descripStr
                                     images:imageArray
                                        url:[NSURL URLWithString:strUrl]
                                      title: titleStr
                                       type:SSDKContentTypeAuto];
    
    if (index == 110) {
        //微信
        DLog(@"微信好友分享");
        
        [ShareSDK share:SSDKPlatformSubTypeWechatSession parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
            [weakSelf SSDKResponseState:state andError:error];
        }];
        
        
    }else if (index == 111){
        //朋友圈
        DLog(@"微信朋友圈分享");
        
        [ShareSDK share:SSDKPlatformSubTypeWechatTimeline parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            
            [weakSelf SSDKResponseState:state andError:error];
        }];
        
        
    }else if (index == 112){
        //新浪
        
        if ([WeiboSDK isWeiboAppInstalled]) {
            
            if ([WeiboSDK isCanShareInWeiboAPP]) {
                [self weiboAppInstalledShare];
            }else{
                DLog(@"检查用户‘不可以’通过微博客户端进行分享");
            }
            
        }else{
            DLog(@"未安装客户端");
            ShareXinLangWeiBoVC *vc = [[ShareXinLangWeiBoVC alloc] init];
            vc.titl = _shareDetailsModel.title;
            vc.desc = _shareDetailsModel.text;
            vc.picshare = _shareDetailsModel.pic;
            vc.urlShare = strUrl;
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    }
}

-(void)weiboAppInstalledShare
{
    typeof(self) weakSelf = self;
    DLog(@"新浪微博客户端分享");
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSString * strUrl = [NSString stringWithFormat:@"%@%@",UG_HOST,_shareDetailsModel.url];
    // 定制新浪微博的分享内容
    [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@ %@",_shareDetailsModel.text,[NSURL URLWithString:strUrl]]title:nil image:[NSURL URLWithString:_shareDetailsModel.pic] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
    
    //调用客户端
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        [weakSelf SSDKResponseState:state andError:error];
        
    }];
    
}

-(void)SSDKResponseState:(SSDKResponseState)state andError:(NSError *)error
{
    switch (state) {
        case SSDKResponseStateSuccess:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
        case SSDKResponseStateFail:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                message:[NSString stringWithFormat:@"%@", error]
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
        case SSDKResponseStateCancel:
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
            break;
        }
        default:
            break;
    }
    
}





#pragma mark - guide页
-(void)kkAddGuide
{
    _guide = [[UIView alloc] init];
    _guide.frame = self.view.bounds;
    _guide.backgroundColor = RGBAlpha(0, 0, 0, 0.3);
    _guide.hidden = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:_guide];
    
    UIImageView *image = [[UIImageView alloc] init];
    image.frame = _guide.frame;
    image.userInteractionEnabled = YES;
    image.image = [UIImage imageNamed:@"Group_guide_bb"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchGuide)];
    [image addGestureRecognizer:tap];
    [_guide addSubview:image];
}
-(void)touchGuide
{
    [UIView animateWithDuration:2.0 animations:^{
        _guide.hidden = YES;
        [User_Default setObject:@"Group_guide_b" forKey:@"Group_guide_b"];
        [User_Default synchronize];
    }];
}


#pragma mark - Bar
-(void)navigationBarView:(CounselorDetailssModel *)model
{
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _alphaView.alpha = 0.0;
    _alphaView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    _alphaView.userInteractionEnabled = YES;
    [self.view addSubview:_alphaView];
    
    attention = [UIButton buttonWithType:UIButtonTypeCustom];
    attention.frame = CGRectMake(kScreenWidth-110, 20, 40, 40);
    attention.titleLabel.font = [UIFont systemFontOfSize:9];
    [attention setImage:[UIImage imageNamed:@"cancle_save"] forState:UIControlStateNormal];
    [attention setImage:[UIImage imageNamed:@"click_save2"] forState:UIControlStateSelected];
    [attention addTarget:self action:@selector(click_RightBtnAttention:) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:attention];
    if ([model.isAttention isEqualToString:@"1"]) {
        attention.selected = YES;
    }else{
        attention.selected = NO;
    }
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(attention.x+attention.width+10, attention.y, 40, 40);
    share.titleLabel.font = [UIFont systemFontOfSize:9];
    [share setImage:[UIImage imageNamed:@"click_share"] forState:UIControlStateNormal];
    [share addTarget:self action:@selector(clickRightBtn_lastShare) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:share];
    
    _titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    _titleView.text = model.enName;
    _titleView.textAlignment = NSTextAlignmentCenter;
    _titleView.font = [UIFont systemFontOfSize:18];
    if (kScreenWidth<370) {
        _titleView.font = [UIFont systemFontOfSize:15];
    }
    _titleView.textColor = [UIColor whiteColor];
    [_alphaView addSubview:_titleView];
    
    [_alphaView addSubview:self.buttonBack];
}
-(void)click_RightBtnAttention:(UIButton *)button
{
    if (button.isSelected) {
        attention.selected = NO;
        _detailHeardView.saveButn.selected = NO;
        [self getNetDataCounselorCancleFollow];
    }else{
        attention.selected = YES;
        _detailHeardView.saveButn.selected = YES;
        [self getNetDataCounselorAddFollow];
    }
}
-(void)clickRightBtn_lastShare
{
    //分享
    [self shareWeiXin:_shareDetailsModel];
}

#pragma mark - 播放视频 AVPlayerViewController
-(void)KAddAVPlayerViewControllerURL:(NSString *)url
{
    player = [AVPlayer playerWithURL:[NSURL URLWithString:url]];
    playerVC = [[AVPlayerViewController alloc] init];
    playerVC.player = player;
    playerVC.delegate = self;
    
    playerVC.showsPlaybackControls = YES;
    playerVC.view.frame = self.view.bounds;
    [playerVC.player play];
    
    [self presentViewController:playerVC animated:YES completion:nil];
}


-(void)KKaddBottomView
{
    _bottomView = [[UIView alloc] init];
    _bottomView.frame = CGRectMake(0, kScreenHeight-44, kScreenWidth, 44);
    _bottomView.hidden = NO;
    _bottomView.layer.borderWidth = 0.6;
    _bottomView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    //NSArray *titleArr = @[@"预约顾问视频",@"给顾问留言",@"立即聘用"];
    //NSArray *titleArr = @[@"预约顾问视频",@"聘用详情"];
    NSArray *titleArr = @[@"预约顾问视频",@"需要帮助"];
    
    for (int i = 0; i < titleArr.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //button.frame = CGRectMake(i * (kScreenWidth/3-20), 0, kScreenWidth/3-20, 44);
        button.frame = CGRectMake(i * (kScreenWidth/3-20), 0, kScreenWidth/3-20, 44);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 300 + i;
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        //button.layer.borderWidth =0.6;
        //[button setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(clickBottomButns:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {//top left bottom right
            button.frame = CGRectMake(0, 0, kScreenWidth - (kScreenWidth/3+40), 44);
            button.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
            [button setImage:[UIImage imageNamed:@"icon_time_imageW"] forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(10, -10, 10, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 0)];
        }
        else if (i == 1){
            button.frame = CGRectMake(kScreenWidth - (kScreenWidth/3+40), 0, kScreenWidth/3+40, 44);
            [button setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
        }
        [_bottomView addSubview:button];
        
        /*
        if (i == 0) {//top left bottom right
            [button setImage:[UIImage imageNamed:@"icon_time_image"] forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, (kScreenWidth/3-20)/2-10, 20, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(25, -20, 5, 0)];
        }
        else if (i == 1){
            [button setImage:[UIImage imageNamed:@"icon_chat_image"] forState:UIControlStateNormal];
            [button setImageEdgeInsets:UIEdgeInsetsMake(5, (kScreenWidth/3-20)/2-10, 20, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(25, -20, 5, 0)];
        }
        else if (i == 2){
            button.frame = CGRectMake(i * (kScreenWidth/3-20), 0, kScreenWidth/3+40, 44);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
        }
        
        [_bottomView addSubview:button];
        
        if (i < 2) {
            UIView *line = [[UIView alloc] init];
            line.frame = CGRectMake((i+1) * (kScreenWidth/3-20), 12, 0.6, 19);
            line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            [_bottomView addSubview:line];
        }
         */
        
    }
}

-(void)clickBottomButns:(UIButton *)butn
{
    NSInteger interger = butn.tag - 300;
    if (interger == 0) {
        
        if ([_isAdvanceRelation isEqualToString:@"0"]) {
            
            UGSchedulingViewController * vc = [[UGSchedulingViewController alloc]init];
            vc.counselorId = _counselorId;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([_isAdvanceRelation isEqualToString:@"1"]){
            
            UGScheduleDtlViewController *scheduleDtlVC = [[UGScheduleDtlViewController alloc] init];
            scheduleDtlVC.index = [self.status intValue];
            scheduleDtlVC.type  = self.type;
            scheduleDtlVC.advanceId = _advanceId;
            [self pushToNextViewController:scheduleDtlVC];
        }
        
    }else if (interger == 1){
        
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        UGChatViewController *chatVC = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
        chatVC.kHxStr = serviceId;
        
        //保存环信ID，获取头像&昵称
        [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
    }

    
    /*
    if (interger == 0) {
        UGSchedulingViewController * vc = [[UGSchedulingViewController alloc]init];
        vc.counselorId = _counselorId;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (interger == 1){
        
        if (_hXcode) {
            UGChatViewController *chatController = [[UGChatViewController alloc] initWithConversationChatter:_hXcode conversationType:EMConversationTypeChat];
            chatController.kHxStr = _hXcode;
            
            [[NSUserDefaults standardUserDefaults] setObject:_hXcode forKey:@"chatOther_conversationId"];//userHxCode
            [[NSUserDefaults standardUserDefaults] synchronize];
            chatController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:chatController animated:YES];
        }
        
    }else if (interger == 2){
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
     */
}


#pragma mark - TableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        UGAbout_counselorCell *cell = (UGAbout_counselorCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }
    /*
    else if (indexPath.row == 1){
        
        UGAbount_searveCell *cell = (UGAbount_searveCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }*/
     else if (indexPath.row == 1){
        
        UGAbount_employCell *cell = (UGAbount_employCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }
    else if (indexPath.row == 2){
        
        UGAbount_employPlanCell *cell = (UGAbount_employPlanCell *)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
        
    }
    return 0;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *counselorCell = @"counselorCell";
    //static NSString *searveCell = @"searveCell";
    static NSString *employCell = @"employCell";
    static NSString *employPlanCell = @"employPlanCell";
    
    if (indexPath.row == 0) {
        UGAbout_counselorCell *cell = [tableView dequeueReusableCellWithIdentifier:counselorCell];
        if (cell == nil) {
            cell = [[UGAbout_counselorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:counselorCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        if (_DetailDataModel) {
            [cell initUI:_DetailDataModel];
        }
        [self about_counselorCell:cell];
        
        return  cell;
    }
    
    /*
    else if (indexPath.row == 1) {
        UGAbount_searveCell *cell = [tableView dequeueReusableCellWithIdentifier:searveCell];
        if (cell == nil) {
            cell = [[UGAbount_searveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searveCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        if (_DetailDataModel) {
           [cell initUI:_DetailDataModel];
        }
        [self abount_searveCell:cell];
        
        return cell;
    }
     */
    
    else if (indexPath.row == 1) {
        UGAbount_employCell *cell = [tableView dequeueReusableCellWithIdentifier:employCell];
        if (cell == nil) {
            cell = [[UGAbount_employCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:employCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        if (_employArr && _DetailModel) {
            [cell initUI:_employArr CounselorDetailModel:_DetailModel];
        }
        [self abount_employCell:cell];
        
        return cell;
    }
    else if (indexPath.row == 2) {
        UGAbount_employPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:employCell];
        if (cell == nil) {
            cell = [[UGAbount_employPlanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:employPlanCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *subViews = cell.contentView.subviews;
        for (UIView *view in subViews) {
            [view removeFromSuperview];
        }
        
        [cell initUI];
        [self abount_employPlanCell:cell];
        
        return cell;
    }

    
    
    UITableViewCell *cell;
    return cell;
}

#pragma mark - 点击事件
-(void)about_counselorCell:(UGAbout_counselorCell *)cell
{
    cell.isUpBlock = ^(){
        
        //[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        [self.tableView reloadData];
    };
    
    cell.moreWorksBlock = ^(NSString *counselorId){
        
        UGCounselorWorkssViewController *counselorWorkssViewVC = [[UGCounselorWorkssViewController alloc] init];
        
        counselorWorkssViewVC.counselorId = counselorId;
        [self pushToNextViewController:counselorWorkssViewVC];
    };
    
    cell.videoDetialBlock = ^(NSString *liveId){
        
        UGLiveVideoDetailViewController *liveVideoDetailVC = [[UGLiveVideoDetailViewController alloc] init];
        liveVideoDetailVC.liveId = liveId;
        if (_byGuanZhu) {
            liveVideoDetailVC.byGuanZhu2 = @"guanzhu";
        }
        if (!_byTabBar) {
            liveVideoDetailVC.byHome = @"2";
            [self pushToNextViewController:liveVideoDetailVC];
        }else{//
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
    };
}

-(void)abount_searveCell:(UGAbount_searveCell *)cell
{
    cell.isUpBlock = ^(){
        
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        [self.tableView reloadData];
    };
}

-(void)abount_employCell:(UGAbount_employCell *)cell
{
    cell.emplyBlock = ^(EmployServiceModel *employServiceModel){
        
        UGServeDtlViewController *confirmOrderVC = [[UGServeDtlViewController alloc] init];
        
        
       confirmOrderVC.serviceid = employServiceModel.serviceid;
        confirmOrderVC.serviceType = employServiceModel.type;
        confirmOrderVC.counselorId = self.counselorId;
        confirmOrderVC.grade  = employServiceModel.grade;
        
        
        confirmOrderVC.expectStr = _DetailModel.requires;
        confirmOrderVC.dataModel =   _DetailDataModel;
        
        
//        confirmOrderVC.urlStr = [NSString stringWithFormat:@"%@001/001/order/parentOrderPay?termType=2&counselorId=%@&serviceId=%@",UG_HOST,_counselorId,serviceid];
        [self pushToNextViewController:confirmOrderVC];
    };
}

-(void)abount_employPlanCell:(UGAbount_employPlanCell *)cell
{
    cell.chatUBaoBlock = ^(){
        
        UGChatViewController *chatVC = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
        chatVC.kHxStr = serviceId;
       
        //保存环信ID，获取头像&昵称
        [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        chatVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatVC animated:YES];
        
    };
}

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-44)];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIButton *)buttonBack
{
    if (!_buttonBack) {
        
        _buttonBack = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 40, 40)];
        [_buttonBack setImage:[UIImage imageNamed:@"nav_back-n"] forState:UIControlStateNormal];
        [_buttonBack addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonBack;
}

-(void)backButton
{
    if (_isJPush) {
        [[AppDelegate sharedappDelegate] showTabBar];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - 网络请求 详情的轮播图
-(void)getNetDataCounselorDetailImageAndVideo{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_CounselorDetailImageAndVideo_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_CounselorDetailImageAndVideo_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _subListArr = [NSMutableArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _subListArr = [CounselorDetailSubListModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"counselorDetailSubList"]];
            
            if (_subListArr) {
                detailModelArr = _subListArr;
                [self getNetDataFindCounselorDetail:_subListArr];
            }
                       
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}


#pragma mark - 网络请求 详情 基本信息
-(void)getNetDataFindCounselorDetail:(NSArray *)subListArr
{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_FindCounselorDetail_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_FindCounselorDetail_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _subListArr = [NSMutableArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            [CounselorDedailDataModel mj_setupObjectClassInArray:^NSDictionary *{
                
                return @{
                         @"labelList":@"LableListssModel",
                         @"experienceList":@"ExperienceListsModel",
                         @"serviceLongList":@"ServiceLongListsModel",
                         @"works":@"WorkssModel",
                         @"eduList":@"EduListsModel"
                         };
                
            }];
            
            _DetailDataModel = [CounselorDedailDataModel mj_objectWithKeyValues:json[@"body"]];
            
            _DetailModel = _DetailDataModel.counselorDetail;
            
            _shareDetailsModel = _DetailDataModel.shareDetail;
            
            _hXcode = _DetailModel.userHxCode;
            
            if (_DetailModel) {
                self.isAdvanceRelation = _DetailModel.isAdvanceRelation;
                self.advanceId         = _DetailModel.advanceId;
                self.status            = _DetailModel.status;
                self.type              = _DetailModel.type;
                [_detailHeardView initUI:subListArr detialModel:_DetailModel];
                [self getNetDataSelectCounselorServiceList];
                [self navigationBarView:_DetailModel];
                [self.view addSubview:self.buttonBack];
                [self.tableView reloadData];
            }
            
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

#pragma mark - 网络请求 详情 (顾问的服务)
-(void)getNetDataSelectCounselorServiceList
{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_SelectCounselorServiceList_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_SelectCounselorServiceList_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _employArr = [NSMutableArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _employArr = [EmployServiceModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"counselorServiceList"]];
            
            if (_employArr) {
                [self.tableView reloadData];
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

#pragma mark - 网络请求 详情 (关注顾问)
-(void)getNetDataCounselorAddFollow
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_CounselorAddFollow_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_CounselorAddFollow_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _employArr = [NSMutableArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            [weakSelf showSVSuccessWithStatus:@"关注成功"];
            attention.selected = YES;
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

#pragma mark - 网络请求 详情 (取消关注)
-(void)getNetDataCounselorCancleFollow
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_CounselorCancleFollow_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_CounselorCancleFollow_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        _employArr = [NSMutableArray array];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            [weakSelf showSVSuccessWithStatus:@"已取消关注"];
            attention.selected = NO;
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}

#pragma mark - 网络请求  (统计该顾问被多少家长看过)
-(void)getNetDataStatCounselorCount
{
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    params[@"counselorId"] = _counselorId;
    
    DLog(@"%@?token=%@&counselorId=%@",UG_StatCounselorCount_URL,kToken,_counselorId);
    
    [HttpClientManager postAsyn:UG_StatCounselorCount_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
