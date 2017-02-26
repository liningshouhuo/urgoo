//
//  UGTaskViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTaskViewController.h"
#import "UGTaskDetailViewController.h"
@interface UGTaskViewController ()

@end

@implementation UGTaskViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
  [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_Task_URL,kToken]];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomTitle:@"任务情况"];

    //[self loadWebViewWithUrlStr:UG_TASK_TASK_URL];
    //[self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_Task_URL,kToken]];
}
-(void)backAction{
    if (self.fromType == 666) {
        
        if (self.navigationController == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
        }

        
    }else{
        if (self.navigationController == nil) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }

    }
    
    
    
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
        if ([pathArr[0] isEqualToString:gotoTaskDetail]){
            //gotoTaskDetail
            
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
