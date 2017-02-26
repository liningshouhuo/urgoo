//
//  UGUserProfileTableViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/28.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGUserProfileTableViewController.h"
#import "UGUderstandSeverViewController.h"

@interface UGUserProfileTableViewController ()

@end

@implementation UGUserProfileTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setCustomTitle:@"详情页"];
   
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@token=%@&chattype=100&counselorId=%@",UG_clientProfile_URL,kToken,_userId]];
    
    
}



-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    // NSString *str=gotoStudentInfo;
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
    DLog(@"pathArr=%@",pathArr);
    if (pathArr.count>1) {
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        DLog(@"拼接前的地址--%@",urlStr);
        if ([pathArr[0] isEqualToString:gotoConversation]) {
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else if ([pathArr[0] isEqualToString:gotoUs]) {
            
            UGUderstandSeverViewController *vc = [[UGUderstandSeverViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }

    
    
   }
    return YES;
    
}

@end
