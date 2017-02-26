//
//  UGSearchClientDetailViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/5.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSearchClientDetailViewController.h"
#import "UGChatViewController.h"
#import "UGUderstandSeverViewController.h"
#import "UGProfileViewController.h"
#import "UGEditProfileViewController.h"


@interface UGSearchClientDetailViewController ()

@end

@implementation UGSearchClientDetailViewController
//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"26BDAB"]] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    
//
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
//    
//    
//    
//}
//-(UIImage*) createImageWithColor:(UIColor*) color
//{
//    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [color CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return theImage;
//}

  - (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setCustomTitle:@"顾问详情"];
      NSString * str = [NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken];
      NSLog(@"%@",str);
      
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];
      NSLog(@"%@",kToken);
      NSLog(@"%@",_urlStr);
//      [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_myConsultant_URL,kToken]];
}
//-(void)loadWebViewWithUrlStr:(NSString *)urlStr
//{
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-60)];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
//    self.webView.delegate =self;
//    [self.view addSubview:self.webView];
//}

//
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    DLog(@"path=%@",[[request URL] absoluteString]);
    NSString *pathStr = [[request URL] absoluteString];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    NSInteger accountObj = [pathArr count];
    
    DLog(@"pathAr=%@",pathArr);
    if (pathArr.count>1) {
        
        
                NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
                DLog(@"拼接前的地址--%@",urlStr);
                   //  了解服务
                if ([pathArr[0] isEqualToString:gotoUs]) {
                  
                    UGUderstandSeverViewController *vc = [[UGUderstandSeverViewController alloc]init];
                    vc.urlStr = urlStr;
                    [self pushToNextViewController:vc];
                    
                }
                else if ([pathArr[0] isEqualToString:gotoConversation]) {
                    
                    NSLog(@"%@",pathArr);
                    NSString *lowStr =[pathArr[pathArr.count-1] lowercaseString];
                    
                    UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:lowStr conversationType:EMConversationTypeChat];
                    vc.kHxStr = lowStr;
                    
                    //保存环信ID，获取头像&昵称
                    [[NSUserDefaults standardUserDefaults] setObject:lowStr forKey:@"chatOther_conversationId"];//userHxCode
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }
                else if([pathArr[0] isEqualToString:gotoEditStu]) {

                    //完善资料
                    UGEditProfileViewController *vc  =[[UGEditProfileViewController alloc]init];
                    vc.urlStr = urlStr;
                   // vc.hidesBottomBarWhenPushed = YES;
                    [self pushToNextViewController:vc];
                    
                }
        

                   //
//        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
//        DLog(@"SearchClientDetail-->urlStr-->%@",urlStr);
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
