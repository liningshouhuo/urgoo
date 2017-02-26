//
//  UGUderstandSeverViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGUderstandSeverViewController.h"
#import "UGConfirmOrderViewController.h"
#import "UGChatViewController.h"
#import "UGEditProfileViewController.h"
@interface UGUderstandSeverViewController ()

@end

@implementation UGUderstandSeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"了解服务"];
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]);
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
        
        if ([pathArr[0] isEqualToString:gotoOrderPay]) {
            
            UGConfirmOrderViewController *vc = [[UGConfirmOrderViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }
        else if ([pathArr[0] isEqualToString:gotoConversation]) {
            
            
            NSString *lowStr =[pathArr[pathArr.count-1] lowercaseString];
            
            UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:lowStr conversationType:EMConversationTypeChat];
            vc.kHxStr = lowStr;
            
            //保存环信ID，获取头像&昵称
            [[NSUserDefaults standardUserDefaults] setObject:lowStr forKey:@"chatOther_conversationId"];//userHxCode
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if([pathArr[0] isEqualToString:gotoEditStu]) {
            
            //完善资料
            UGEditProfileViewController *vc  =[[UGEditProfileViewController alloc]init];
            vc.urlStr = urlStr;
            // vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
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
