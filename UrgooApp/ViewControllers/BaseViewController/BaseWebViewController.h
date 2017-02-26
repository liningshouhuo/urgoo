//
//  BaseWebViewController.h
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseWebViewController : BaseViewController<UIWebViewDelegate>
@property(strong,nonatomic)UIWebView *webView;


-(void)loadWebViewWithUrlStr:(NSString *)urlStr;



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
@end
