//
//  UGShareTofirViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGShareTofirViewController.h"
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

@interface UGShareTofirViewController ()

@property (strong,nonatomic) NSString * picURl;
@property (strong,nonatomic) NSString * urlShare;
@property (strong,nonatomic) NSString * picshare;
@property (strong,nonatomic) NSString * titl;
@property (strong,nonatomic) NSString * desc;
@property (strong,nonatomic) NSString * shareNumber;
@property (strong,nonatomic) NSString * shareSuccess;
@property (strong,nonatomic) MalertView *alert;

@end

@implementation UGShareTofirViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"告诉朋友"];
    [self loadRequest];
}
-(void)loadRequest{
    
    NSMutableDictionary * parmas = [NSMutableDictionary dictionary];
  
    //[self setUpUI:_picURl];
    parmas[@"token"] = kToken;
    parmas[@"role"] = @"2";
    [HttpClientManager postAsyn:UG_createQrcode_URL params:parmas success:^(id json) {
        
        NSLog(@"%@",json);
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            _picURl   = json[@"body"][@"qrcodeUrl"];
            _picshare = json[@"body"][@"pic"];
            _urlShare = json[@"body"][@"url"];
            _titl     = json[@"body"][@"title"];
            _desc     = json[@"body"][@"desc"];
            _shareNumber  = json[@"body"][@"resultStr"];
            
            
            
            [self setUpUI:_picURl];
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [self showSVErrorString:msg.message];
        }
       
    } failure:^(NSError *error) {
        
    }];
    
    
    
}
-(void)setUpUI:(NSString * )urlStr
{
    
    UILabel * shareNumber = [[UILabel alloc]init];
    shareNumber.text = [NSString stringWithFormat:@"%@",_shareNumber];
    shareNumber.textAlignment = NSTextAlignmentCenter;
    shareNumber.font = [UIFont systemFontOfSize:12];
    shareNumber.numberOfLines = 2;
    shareNumber.frame =CGRectMake( 0, 15, kScreenWidth, 30);
    shareNumber.textColor = [UIColor blackColor];
    [self.view addSubview:shareNumber];
    
    UIImageView * imageView = [[UIImageView alloc]init];
   // imageView.backgroundColor = [UIColor colorWithHexString:@"oooooo"];
    [imageView sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@""]];
    imageView.frame = CGRectMake((kScreenWidth - 225)/2, kScreenHeight *0.146, 225, 225);
    [self.view addSubview:imageView ];
    
    UILabel * worblable = [[UILabel alloc]init];
    worblable.text = @"扫描上方二维码即可下载APP";
    worblable.textAlignment = NSTextAlignmentCenter;
    worblable.font = [UIFont systemFontOfSize:15];
    worblable.frame =CGRectMake(kScreenWidth * 0.075, imageView.bottom + 15, kScreenWidth * 0.85, 16);
    [self.view addSubview:worblable];
    
    UIButton * button =[[UIButton alloc]init];
    button.frame = CGRectMake(kScreenWidth * 0.075, worblable.bottom + 25, kScreenWidth * 0.85, 49);
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle:@"立即分享" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click_shark) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)click_shark{
    
    
    [self  shareWeiXin:_picURl];
    
}
-(void)shareWeiXin:(NSString *)UrlStr
{
    [_alert removeFromSuperview];
    typeof(self) weakSelf = self;
    
    _alert = [[MalertView alloc] initWithImageArrOfButton:@[@"share_weixin_icon",@"share_weixinFriend_icon",@"share_weibo_icon"]];
    [[UIApplication sharedApplication].keyWindow addSubview:_alert];
    
    _alert.selectBlock = ^(NSInteger index){
        [weakSelf malertItemSelect:index];
    };
    
    [_alert showAlert];
    
}


- (void)malertItemSelect:(NSInteger)index
{
    NSLog(@"点击了－－－%ld",index);
    
    _alert.hidden = YES;
    typeof(self) weakSelf = self;
    NSArray *imageArray;
    imageArray = @[_picshare];
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    
    [shareParams SSDKSetupShareParamsByText: _desc
                                     images:imageArray
                                        url:[NSURL URLWithString:_urlShare]
                                      title: _titl
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
        //isCanShareInWeiboAPP
        
//        DLog(@"未安装客户端");
//        ShareXinLangWeiBoVC *vc = [[ShareXinLangWeiBoVC alloc] init];
//        vc.titl = _titl;
//        vc.desc = _desc;
//        vc.picshare = _picshare;
//        vc.urlShare = _urlShare;
//        [self presentViewController:vc animated:YES completion:nil];
        
        
        if ([WeiboSDK isWeiboAppInstalled]) {
            
            if ([WeiboSDK isCanShareInWeiboAPP]) {
                [self weiboAppInstalledShare];
            }else{
                DLog(@"检查用户‘不可以’通过微博客户端进行分享");
            }
            
        }else{
            DLog(@"未安装客户端");
            ShareXinLangWeiBoVC *vc = [[ShareXinLangWeiBoVC alloc] init];
            vc.titl = _titl;
            vc.desc = _desc;
            vc.picshare = _picshare;
            vc.urlShare = _urlShare;
            [self presentViewController:vc animated:YES completion:nil];
        }
        
    }
    
}

-(void)weiboAppInstalledShare
{
    typeof(self) weakSelf = self;
    DLog(@"新浪微博客户端分享");
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    // 定制新浪微博的分享内容
    [shareParams SSDKSetupSinaWeiboShareParamsByText:[NSString stringWithFormat:@"%@ %@",_desc,[NSURL URLWithString:_urlShare]]title:nil image:[NSURL URLWithString:_picshare] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
    
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






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
