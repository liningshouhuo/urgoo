//
//  UGMyOrderViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyOrderViewController.h"
#import "UGMyOrderDetailsViewController.h"
#import "AppDelegate.h"
#import "UGCounselorDetailNewViewController.h"
@interface UGMyOrderViewController ()

@end

@implementation UGMyOrderViewController
-(void)viewWillAppear:(BOOL)animated{
    [super  viewWillAppear:YES];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_ParentOrder_URL,kToken]];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self setCustomTitle:@"我的订单"];
   
    
//    [self loadWebViewWithUrlStr:UG_ORDER_MYORDER_URL];
    
//    
//    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_ParentOrder_URL,kToken]];
}
-(void)needBackAction:(BOOL)isNeed{
    
    if (isNeed) {
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_back-n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] landscapeImagePhone:nil style:UIBarButtonItemStyleDone target:self action:@selector(backToRoot)];
        self.navigationItem.leftBarButtonItem = backItem;
    }else{
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.hidesBackButton = YES;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    }

    
    
}
-(void)backToRoot{
    
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self backtoAction];
}
-(void)backtoAction{
    [AppDelegate sharedappDelegate].tabbar.selectedIndex = 3 ;
 
    
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
        
        if ([pathArr[0] isEqualToString:gotoOrderDtlJz]) {
            
            UGMyOrderDetailsViewController *vc = [[UGMyOrderDetailsViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }else if ([pathArr[0] isEqualToString:gotoGwDtl]) {//顾问详情  UGGotoPtGzViewController
            
            UGCounselorDetailNewViewController * counselorDetailNewVC = [[UGCounselorDetailNewViewController alloc]init];
            counselorDetailNewVC.counselorId = pathArr[1];
            //  NSLog(@"counselorId===%@",counselorId);
            counselorDetailNewVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:counselorDetailNewVC animated:YES];
            
            
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
