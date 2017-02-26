//
//  UGMessageDetaillViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/5/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMessageDetaillViewController.h"
#import "InformationModel.h"

@interface UGMessageDetaillViewController ()

@property(nonatomic,strong)UITextView *text;

@end

@implementation UGMessageDetaillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     [self setCustomTitle:@"消息详情"];
    
    if (self.informationModel != nil) {
        
        self.text = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, 200)];
        self.text.text = self.informationModel.contentCn;
        self.text.font = [UIFont systemFontOfSize:14.0];
        self.text.textColor = [UIColor colorWithHexString:@"616161"];
        self.text.editable = NO;
        self.text.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.text];
    }
    if (self.mesgAccountModel != nil) {
        
        self.text = [[UITextView alloc] initWithFrame:CGRectMake(20, 10, kScreenWidth - 40, 200)];
        self.text.text = self.mesgAccountModel.content;
        self.text.font = [UIFont systemFontOfSize:14.0];
        self.text.textColor = [UIColor colorWithHexString:@"616161"];
        self.text.editable = NO;
        self.text.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.text];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
