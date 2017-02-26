//
//  UGTaskDetailViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTaskDetailViewController.h"

@interface UGTaskDetailViewController ()

@end

@implementation UGTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"任务详情"];
    NSString * str = [NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken];
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
    
    DLog(@"pathAr=%@",pathArr);
    if (pathArr.count>1) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        if ([pathArr[0] isEqualToString:gotoTaskJz]) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }else if ([pathArr[0] isEqualToString:gotoTaskDetail]){
            
            UGTaskDetailViewController *vc = [[UGTaskDetailViewController alloc]init];
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
