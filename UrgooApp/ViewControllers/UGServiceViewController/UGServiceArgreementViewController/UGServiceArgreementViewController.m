//
//  UGServiceArgreementViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/30.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGServiceArgreementViewController.h"

@interface UGServiceArgreementViewController ()<UIWebViewDelegate>
@property(strong,nonatomic)UIWebView *webView;
@end

@implementation UGServiceArgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setCustomTitle:@"服务协议"];
    
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    _webView.delegate =self;
    [self.view addSubview:_webView];

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
