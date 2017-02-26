//
//  UGProfileViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGProfileViewController.h"
#import "UGEditProfileViewController.h"
@interface UGProfileViewController ()

@end

@implementation UGProfileViewController
-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:NO];
    
     [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_mmyInfo_URL,kToken]];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.bounces = NO;
    
    [self needBackAction:YES];
    
    [self setCustomTitle:@"个人资料"];
    
    NSString * str = [NSString stringWithFormat:@"%@?token=%@",UG_mmyInfo_URL,kToken];
    NSLog(@"%@",str);
    //[self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_mmyInfo_URL,kToken]];
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
        NSLog(@"%@",pathArr);
        if ([pathArr[0] isEqualToString:gotoEditStu]) {
            
            UGEditProfileViewController *vc = [[UGEditProfileViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }
        //
    }
    
    return YES;
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



@end
