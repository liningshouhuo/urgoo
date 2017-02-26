//
//  UGEditProfileViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/5.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGEditProfileViewController.h"
#import "UGTagViewController.h"
#import "UGStuSchoolViewController.h"
#import "UGGraduationTimeViewController.h"
#import "UGAimSchoolViewController.h"
#import "UGAimMajorViewController.h"
#import "UGAssessmentPageViewController.h"
#import "UGAwardsViewController.h"
#import "UGExtracurricularJzViewController.h"


@interface UGEditProfileViewController ()

@end

@implementation UGEditProfileViewController
-(void)viewWillAppear:(BOOL)animated{
   [super viewWillAppear:NO];
    NSLog(@"wdwsdsds");
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];

}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"编辑资料"];
    NSString * str = [NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken];
    NSLog(@"%@",str);
    self.webView.scrollView.bounces = NO;
//     [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@&token=%@",_urlStr,kToken]];

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
        // 个性标签
        if ([pathArr[0] isEqualToString:gotoPersonalityLabel]) {
            
            UGTagViewController *vc = [[UGTagViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            // 就读学校
        }else if ([pathArr[0] isEqualToString:gotoSchool]) {
            
            UGStuSchoolViewController *vc = [[UGStuSchoolViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
          // 当前年级
        }else if ([pathArr[0] isEqualToString:gotoGraduationTime]) {
            
            UGGraduationTimeViewController *vc = [[UGGraduationTimeViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
         //校内成绩
        }else if ([pathArr[0] isEqualToString:gotoAimSchool]) {
            
            UGAimSchoolViewController *vc = [[UGAimSchoolViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            //意向国家
        }else if ([pathArr[0] isEqualToString:gotoAimMajor]) {
            
            UGAimMajorViewController *vc = [[UGAimMajorViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            //标准化考试
        }
        else if ([pathArr[0] isEqualToString:gotoToTest]) {
            
            UGAssessmentPageViewController *vc = [[UGAssessmentPageViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            //学术化奖项
        }else if ([pathArr[0] isEqualToString:gotoAwards]) {
            
            UGAwardsViewController *vc = [[UGAwardsViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            //主要课外活动
        }else if ([pathArr[0] isEqualToString:gotoExtracurricularJz]) {
            
            UGExtracurricularJzViewController *vc = [[UGExtracurricularJzViewController alloc]init];
            vc.urlStr = urlStr;
            [self pushToNextViewController:vc];
            
        }else if([pathArr[0] isEqualToString:gotoMyInfo]) {
            
            [self.navigationController popViewControllerAnimated:YES];
//            UGExtracurricularJzViewController *vc = [[UGExtracurricularJzViewController alloc]init];
//            vc.urlStr = urlStr;
//            [self pushToNextViewController:vc];
            
        }

        





    }
    return YES;
}
//
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
