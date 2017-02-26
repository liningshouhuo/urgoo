//
//  ShareXinLangWeiBoVC.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/9/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ShareXinLangWeiBoVC.h"

//share
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>


@interface ShareXinLangWeiBoVC ()

@property (nonatomic,strong)  UIView  *alphaView;
@property (nonatomic,strong)  UITextView  *messageText;

@end

@implementation ShareXinLangWeiBoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self AddalphaView];
    
    [self editShareContext];
    
}

-(void)editShareContext
{
    _messageText = [[UITextView alloc] init];
    _messageText.frame = CGRectMake(10, 70, kScreenWidth-20, 150);
    _messageText.font = [UIFont systemFontOfSize:17];
    _messageText.text = [NSString stringWithFormat:@"%@ %@",_desc,[NSURL URLWithString:_urlShare]];
    _messageText.layer.borderWidth = 0.6;
    _messageText.layer.cornerRadius = 4;
    _messageText.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.view addSubview:_messageText];
    
    [_messageText becomeFirstResponder];
    
    
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:_picshare] placeholderImage:[UIImage imageNamed:@""]];
    imageView.frame = CGRectMake(20, _messageText.bottom+10, 100, 80);
    [self.view addSubview:imageView ];
    
}

-(void)AddalphaView
{
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _alphaView.backgroundColor = [UIColor colorWithHexString:@"26bdab"];
    _alphaView.userInteractionEnabled = YES;
    [self.view addSubview:_alphaView];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(15, 20, 40, 40);
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(clickLightButn_cancel) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:cancel];

    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(kScreenWidth-55, cancel.y, 40, 40);
    share.titleLabel.font = [UIFont systemFontOfSize:15];
    [share setTitle:@"分享" forState:UIControlStateNormal];
    [share addTarget:self action:@selector(clickRightButn_share) forControlEvents:UIControlEventTouchUpInside];
    [_alphaView addSubview:share];
    
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenWidth, 40)];
    titleLable.text = @"分享内容";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:16];
    
    [_alphaView addSubview:titleLable];
    
}


-(void)clickLightButn_cancel
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
    [alertView show];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)clickRightButn_share
{
    [_messageText resignFirstResponder];
    typeof(self) weakSelf = self;
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    // 定制新浪微博的分享内容 [NSString stringWithFormat:@"%@ %@",_desc,[NSURL URLWithString:_urlShare]]
    [shareParams SSDKSetupSinaWeiboShareParamsByText:_messageText.text title:nil image:[NSURL URLWithString:_picshare] url:nil latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
    
    [ShareSDK share:SSDKPlatformTypeSinaWeibo parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        
        [weakSelf SSDKResponseState:state andError:error];
        
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];

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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_messageText resignFirstResponder];
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
