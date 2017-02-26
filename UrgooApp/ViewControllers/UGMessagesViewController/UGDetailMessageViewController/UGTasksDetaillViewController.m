//
//  UGTasksDetaillViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/5/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTasksDetaillViewController.h"
#import "UGTaskDetailViewController.h"
#import "UGTaskViewController.h"
@interface UGTasksDetaillViewController ()

@end

@implementation UGTasksDetaillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"任务详情"];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@&taskId=%@&informationId=%@&unread=%@",UG_TASK_TASKDETAILSTU_URL,kToken,self.mesgAccountModel.targetId,self.mesgAccountModel.informationId,self.mesgAccountModel.unread]];
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
        if ([pathArr[0] isEqualToString:gotoTaskJz]){
            UGTaskViewController *vc = [[UGTaskViewController alloc]init];
            vc.fromType = 666;
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
        }
        
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
