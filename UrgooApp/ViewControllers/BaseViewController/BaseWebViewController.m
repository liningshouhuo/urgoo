//
//  BaseWebViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()
@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)loadWebViewWithUrlStr:(NSString *)urlStr
{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64)];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webView.delegate =self;
    self.webView.scrollView.bounces = NO;
    [self.view addSubview:self.webView];
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    
    [SVProgressHUD showWithStatus:@"Loading"];
    
    DLog(@"start Load");
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [SVProgressHUD dismiss];
    
    DLog(@"Finish Load");
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
    DLog(@"pathAr=%@",pathArr);
    if (pathArr.count>1) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        
        DLog(@"urlStr=%@",urlStr);
        
    }
    
    return YES;
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
