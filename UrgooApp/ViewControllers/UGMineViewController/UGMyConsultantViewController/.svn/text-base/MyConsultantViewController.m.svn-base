//
//  MyConsultantViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "MyConsultantViewController.h"
#import "UGSearchClientDetailViewController.h"

@interface MyConsultantViewController ()

@end

@implementation MyConsultantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"我的顾问"];
    
    //[self loadWebViewWithUrlStr:UG_STUDENT_FOLLOW_URL];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_myConsultant_URL,kToken]];
    
    
    DLog(@"我的顾问-->%@",[NSString stringWithFormat:@"%@?token=%@",UG_myConsultant_URL,kToken]);
    
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
        UGSearchClientDetailViewController *vc = [[UGSearchClientDetailViewController alloc]init];
        vc.urlStr = urlStr;
        [self pushToNextViewController:vc];
        
        
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
