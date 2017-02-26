//
//  UGExtracurricularJzAddViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGExtracurricularJzAddViewController.h"

@interface UGExtracurricularJzAddViewController ()

@end

@implementation UGExtracurricularJzAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    [self setCustomTitle:@"课外活动"];
    NSString * str =[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken];
    NSLog(@"%@",str);
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];


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
        NSLog(@"%@",pathArr);
        if ([pathArr[0] isEqualToString:gotoExtracurricularJz]) {
            
            [self.navigationController  popViewControllerAnimated:YES];
        }
        //
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
