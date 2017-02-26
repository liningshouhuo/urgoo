//
//  UGGotoH5ViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGGotoH5ViewController.h"
#import "UGConsultantLIstViewController.h"

@interface UGGotoH5ViewController ()

@end

@implementation UGGotoH5ViewController
-(void)viewWillAppear:(BOOL)animated{
    
   
    
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setCustomTitle:self.titlele];
    [self loadWebViewWithUrlStr:self.urlstr];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
     [SVProgressHUD dismiss];
    NSString * str  = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
    [self setCustomTitle:str];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
    DLog(@"pathArr=%@",pathArr);
    if (pathArr.count>1) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        DLog(@"拼接前的地址--%@",urlStr);
        
        if ([pathArr[0] isEqualToString:gotoLookForGw]) {
            
            UGConsultantLIstViewController * vc= [[UGConsultantLIstViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];

            
        }
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
