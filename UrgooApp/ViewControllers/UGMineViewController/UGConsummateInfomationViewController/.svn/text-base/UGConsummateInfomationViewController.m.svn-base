//
//  UGConsummateInfomationViewController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGConsummateInfomationViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>//iOS7之后才出现的API
/*
 JSContext, JSContext是代表JS的执行环境，通过-evaluateScript:方法就可以执行一JS代码
 JSValue,   JSValue封装了JS与ObjC中的对应的类型，以及调用JS的API等
 JSExport,  JSExport是一个协议，遵守此协议，就可以定义我们自己的协议，在协议中声明的API都会在JS中暴露出来，才能调用
 */

#define kUrl  @"http://127.0.0.1:8020/Urgoo1/cn/connections.html"
#define kUrl2 @"communication_log"

@interface UGConsummateInfomationViewController ()<UIWebViewDelegate>
@property(strong,nonatomic)UIWebView *webView;

@property (nonatomic, strong, readonly) JSContext    *jsContext;
@property (nonatomic, strong) NSString               *totalUrl;
@end

@implementation UGConsummateInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"完善资料"];
    
    
    DLog(@"完善资料begin");
    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(20, 20, kScreenWidth-40, kScreenHeight-49-40)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kUrl]]];

    

//    NSString *filePath = [[NSBundle mainBundle]pathForResource:kUrl2 ofType:@"html"];
//    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    [_webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:filePath]];
    
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    DLog(@"完善资料end");

}


- (void)webViewDidStartLoad:(UIWebView *)webView{}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //js方法名＋参数
//    NSString* jsCode = [NSString stringWithFormat:@"report('%@')",self.url];
    NSString* jsCode = [NSString stringWithFormat:@"report('%@')",kUrl];
    DLog(@"jsCode==%@",jsCode);
    //调用html页面的js方法
    [webView stringByEvaluatingJavaScriptFromString:jsCode];
    //    [SMProgressView dismiss];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //    [SMProgressView dismiss];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *requestString = [[[request URL] absoluteString]stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    DLog(@"requestString : %@",requestString);
    
    
    NSArray *components = [requestString componentsSeparatedByString:@"|"];
    DLog(@"=components=====%@",components);
    
    
    NSString *str1 = [components objectAtIndex:0];
    DLog(@"str1:::%@",str1);
    
    
    NSArray *array2 = [str1 componentsSeparatedByString:@"/"];
    DLog(@"array2:====%@",array2);
    
    
    NSInteger coun = array2.count;
    NSString *method = array2[coun-1];
    DLog(@"method:===%@",method);
    
    if ([method isEqualToString:@"InviteBtn1"])//查看详情
    {
//        UZGCustomAlertView *vc= [[UZGCustomAlertView alloc]initWithTitle:self.detailTitle andShow:NO];
//        [vc show];
        return NO;
    }else if ([method isEqualToString:@"InviteBtn2"])
    {
        
//        _shareVw = [ShareView defaultShareView];
//        UZGMyInvatationViewControllerParam *param=self.createArgs;
//        if ([param.from isEqualToString:@"分享红包"]) {
//            self.url2 = [NSString stringWithFormat:@"%@",self.url2];
//        }else{
//            self.url2 = [NSString stringWithFormat:@"%@?%@",self.url2,self.yaoQingma];
//        }
        
//        [_shareVw setShareContentWithTitle:self.title1 content:self.title2 shareImage:nil  shareURL:self.url2];
//        [_shareVw show];
//        [_shareVw setShareViewBlock:^(BOOL isSuccess) {
//            if (isSuccess) {
//                [TalkingData trackEvent:@"邀请页分享成功"];
//                DLog(@"分享成功");
//            }else {
//                [TalkingData trackEvent:@"邀请页分享失败"];
//                DLog(@"分享失败");
//            }
//        }];
        
//        [_shareVw setShareViewCopyBlock:^(BOOL isSuccess) {
//            if (isSuccess) {
//                DLog(@"复制链接成功");
//                [TalkingData trackEvent:@"邀请页复制链接成功"];
//                [SMAlertView showAlert:@"复制成功"];
//            }else {
//                [TalkingData trackEvent:@"邀请页复制链接失败"];
//                DLog(@"复制链接失败");
//            }
//        }];
        return NO;
    }
    return YES;
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
