//
//  UGAccountViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAccountViewController.h"
#import "UGAccountDetailViewController.h"
@interface UGAccountViewController ()

@end

@implementation UGAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"账单"];
    
    //[self loadWebViewWithUrlStr:UG_ACCOUNT_ACCOUNT_URL];
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_ParentAccount_URL,kToken]];
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    
//    DLog(@"path=%@",[[request URL] absoluteString]);
//    
//    NSString *pathStr = [[request URL] absoluteString];
//    
//    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"$_$"];
//    
//    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
//    
//    NSInteger accountObj = [pathArr count];
//    
//    DLog(@"pathAr=%@",pathArr);
//    if (pathArr.count>1) {
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
//        
//        DLog(@"urlStr=%@",urlStr);
//        
//        UGAccountDetailViewController *vc = [[UGAccountDetailViewController alloc]init];
//        vc.urlStr = urlStr;
//        [self pushToNextViewController:vc];
//        
//        
//    }
//    
//    return YES;
//}
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

        if ([pathArr[0] isEqualToString:gotoAccountDtlJz]) {
        //
        UGAccountDetailViewController *vc = [[UGAccountDetailViewController alloc]init];
        vc.urlStr = urlStr;
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
