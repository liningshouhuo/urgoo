//
//  UGHelpViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGHelpViewController.h"
#import "UGChatViewController.h"

@interface UGHelpViewController ()

@end

@implementation UGHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setCustomTitle:@"帮助"];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_Help_URL,kToken]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@?token=%@",UG_Help_URL,kToken]);

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
        
        if ([pathArr[0] isEqualToString:gotoConversation]) {
            
            UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
            vc.kHxStr = serviceId;
            
            //保存环信ID，获取头像&昵称
            [[NSUserDefaults standardUserDefaults] setObject:serviceId forKey:@"chatOther_conversationId"];//userHxCode
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.navigationController pushViewController:vc animated:YES];
            
            
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
