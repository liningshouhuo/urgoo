//
//  TripartiteAgreementViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/9/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "TripartiteAgreementViewController.h"
#import "UgComordViewController.h"

@interface TripartiteAgreementViewController ()

@end

@implementation TripartiteAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"三方协议"];
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@001/001/client/xyJz?token=%@",UG_HOST,kToken]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:NO];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
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
        
        
        if  ([pathArr[0] isEqualToString:gotoOOrder]) {
            //urgoo://gotoOOrder
            
            UgComordViewController * vc = [[UgComordViewController alloc]init];
            vc.serviceid = _serviceid;
            vc.counselorId = _counselorId;
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
