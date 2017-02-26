//
//  UGMyOrderDetailsViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyOrderDetailsViewController.h"
#import "UGPaymentViewController.h"
#import "UGChatViewController.h" 
#import "UGPayViewController.h"
#import "UGPlanningViewController.h"
#import "UGMyOrderViewController.h"
#import "UGCounselorDetailNewViewController.h"

@interface UGMyOrderDetailsViewController ()

@end

@implementation UGMyOrderDetailsViewController

-(void)backAction

{
    if ([self.type isEqualToString:@"我的订单"]) {
        
        UGMyOrderViewController *vc  =[[UGMyOrderViewController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:vc];
//        NSArray *controllersArr = self.navigationController.viewControllers;
//        DLog(@"%ld",controllersArr.count);
//        [self.navigationController popToViewController:controllersArr[3] animated:YES];

        
    }else if (self.isShouye) {
        //从“找顾问”进入,订单详情
        NSArray *controllersArr = self.navigationController.viewControllers;
        DLog(@"%ld",controllersArr.count);
        [self.navigationController popToViewController:controllersArr[1] animated:YES];
        
    }else{
        //从“我”进入,订单详情
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self setCustomTitle:@"订单详情"];
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];
    NSLog(@"%@",[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]);
   
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
    DLog(@"pathArr=%@",pathArr);
    NSLog(@"pathArr=%@",pathArr);
    if (pathArr.count>1) {
         DLog(@"pathArr=%@",pathArr);
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        DLog(@"拼接前的地址--%@",urlStr);
        NSLog(@"pathArr[0] == %@ ",pathArr[0]);
        NSString * parr = [NSString stringWithFormat:@"%@",pathArr[0]];
        if ([pathArr[0] isEqualToString:gotoPayment]) {
            
            UGPaymentViewController *vc = [[UGPaymentViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }
        else if ([pathArr[0] isEqualToString:gotoConversation]) {
            
            
            NSString *lowStr =[pathArr[pathArr.count-1] lowercaseString];
            UGChatViewController *vc = [[UGChatViewController alloc]initWithConversationChatter:serviceId conversationType:EMConversationTypeChat];
            vc.kHxStr = serviceId;
            [vc setCustomTitle:ServiecName];
            
            //保存环信ID，获取头像&昵称
            [[NSUserDefaults standardUserDefaults] setObject:lowStr forKey:@"chatOther_conversationId"];//userHxCode
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            vc.hidesBottomBarWhenPushed = YES;
           [self.navigationController pushViewController:vc animated:YES];
            //[self pushToNextViewController:vc];
            
        }else if ([pathArr[0] isEqualToString:gotoOriginTask]){
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self performSelector:@selector(done1) withObject:nil afterDelay:0.05];
            
        }else if ([pathArr[0] isEqualToString:gotoGwDtl]) {//顾问详情  UGGotoPtGzViewController
            
            UGCounselorDetailNewViewController * counselorDetailNewVC = [[UGCounselorDetailNewViewController alloc]init];
            counselorDetailNewVC.counselorId = pathArr[1];
            //  NSLog(@"counselorId===%@",counselorId);
            counselorDetailNewVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:counselorDetailNewVC animated:YES];
            
            
        }

        else if ([pathArr[0] isEqualToString:gotoSearchConsultant]){
            
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self performSelector:@selector(done2) withObject:nil afterDelay:0.05];
        }
        
        else if([parr isEqualToString:gotoOriginPay ]){
            NSLog(@"%@",pathArr);
          
            
            
            
            UGPayViewController *vc = [[UGPayViewController alloc]init];
           

            vc.orderId = pathArr[1];
            NSLog(@"%@",vc.orderId);
//            NSString*string =pathArr[1];
//            
//            NSArray *array = [string componentsSeparatedByString:@"-"]; //从字符A中分隔成2个元素的数组
//            NSLog(@"array:%@",array); //结果是adfsfsfs和dfsdf
            
            
            [self pushToNextViewController:vc];
            
            
        }
        
    }else if (pathArr.count ==1){
        
        if ([pathArr[0] isEqualToString:gotoOriginPlan]){
            UGPlanningViewController * vc = [[UGPlanningViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
            
        }
        

        
        
    }
    
    return YES;
}
- (NSString *)decodeFromPercentEscapeString: (NSString *) input
{
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    [outputStr replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, outputStr.length)];
//    [outputStr replaceOccurrencesOfString:@"+"
//                               withString:@"
//     "
//                                  options:NSLiteralSearch
//                                    range:NSMakeRange(0,
//                                                      [outputStr length])];
//    
    return
    [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(void)done1{
    [AppDelegate sharedappDelegate].tabbar.selectedIndex = 2;
}

-(void)done2{
    [AppDelegate sharedappDelegate].tabbar.selectedIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
