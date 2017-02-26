//
//  UGMyContractViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyContractViewController.h"

@interface UGMyContractViewController ()
@property(strong,nonatomic)UITextView *textView;
@end

@implementation UGMyContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _textView.editable=NO;
    _textView.text = @"";
    [self.view addSubview:_textView];
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
