//
//  UGStuSchoolViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/5.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGStuSchoolViewController.h"
#import "UGEditProfileViewController.h"
@interface UGStuSchoolViewController ()

@end

@implementation UGStuSchoolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"就读学校"];
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
        
        if ([pathArr[0] isEqualToString:gotoEdit]) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
//            UGEditProfileViewController *vc = [[UGEditProfileViewController alloc]init];
//            vc.urlStr = urlStr;
//            [self pushToNextViewController:vc];
            
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
