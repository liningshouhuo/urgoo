//
//  UGAgreementViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAgreementViewController.h"

@interface UGAgreementViewController ()

@end

@implementation UGAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setCustomTitle:@"优顾三方协议"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@001/001/client/xyJz?%@",UG_HOST,kToken]);
     [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@001/001/client/xyJz?token=%@",UG_HOST,kToken]];
        self.webView.frame = CGRectMake(0, 64, kScreenWidth , kScreenHeight - 64 -44);
    
   
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [SVProgressHUD dismiss];
    UIButton  * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 , kScreenWidth, 44)];
    
    
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle: @"同意" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(click_deal) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    UIImageView * argeeImage = [[UIImageView alloc]init];
    
    argeeImage .image = [UIImage imageNamed:@"agree_photo_sanf"];
    argeeImage.frame = CGRectMake((kScreenWidth/2 -35), 15, 14, 14);
    [button addSubview:argeeImage];
    
    DLog(@"Finish Load");
}
-(void)click_deal{
    
    
    
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
