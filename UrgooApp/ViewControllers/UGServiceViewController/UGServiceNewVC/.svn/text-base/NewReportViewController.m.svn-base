//
//  NewReportViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewReportViewController.h"

static CGFloat heightOne;
@interface NewReportViewController ()

@property (nonatomic,strong) UIScrollView *scrollView;

@end

@implementation NewReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setCustomTitle:@"顾问报告"];
    
    [self initUI];
}

-(void)initUI{
    
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _scrollView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self.view addSubview:_scrollView];
    
    UIView *backGroundFir = [[UIView alloc] init];
    backGroundFir.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    backGroundFir.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:backGroundFir];
    
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.frame = CGRectMake(0, 20, kScreenWidth-62*2, (kScreenWidth-62*2)*0.78);
    imageV.center = CGPointMake(kScreenWidth/2, imageV.centerY);
    imageV.image = [UIImage imageNamed:@"new_report_icon"];
    [backGroundFir addSubview:imageV];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, kScreenWidth*0.63, kScreenWidth, 1);//235
    line.layer.borderWidth = 0.2;
    line.layer.borderColor = RGBAlpha(130, 130, 130, 0.5).CGColor;
    line.layer.shadowColor = RGBAlpha(130, 130, 130, 0.5).CGColor;
    line.layer.shadowOffset = CGSizeMake(0, 2);
    line.layer.shadowOpacity = 0.5;
    [backGroundFir addSubview:line];
    
    UILabel *titleName = [[UILabel alloc] init];
    titleName.frame = CGRectMake(0, line.bottom + 20, kScreenWidth, 20);
    titleName.textAlignment = NSTextAlignmentCenter;
    titleName.font = [UIFont systemFontOfSize:15];
    titleName.text = @"Meeting Report 会议纪要";
    titleName.textColor = [UIColor colorWithHexString:@"2e2e2e"];
    [backGroundFir addSubview:titleName];
    
    NSArray *nameArr = @[@"Student：",@"Date of Meeting：2016.08.31",@"When the meeting starts：3 p.m.",@"When the meeting ends：4 p.m.",@"Date for next meeting：5 p.m. on 2016.10.03"];
    for (int i = 0; i < 5; i ++) {
        
        UILabel *name = [[UILabel alloc] init];
        name.frame = CGRectMake(36, titleName.bottom+25 +i*30, kScreenWidth-36*2, 15);
        name.font = [UIFont systemFontOfSize:13];
        name.text = nameArr[i];
        name.textColor = [UIColor colorWithHexString:@"434343"];
        [backGroundFir addSubview:name];
        
        heightOne = name.bottom + 35;
    }
    
    backGroundFir.frame = CGRectMake(0, 0, kScreenWidth, heightOne);
    
    
    
    UIView *backGroundSec = [[UIView alloc] init];
    backGroundSec.frame = CGRectMake(0, heightOne + 14, kScreenWidth, 240);
    backGroundSec.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:backGroundSec];
    
    UILabel *titleNameSec = [[UILabel alloc] init];
    titleNameSec.frame = CGRectMake(0,  20, kScreenWidth, 20);
    titleNameSec.textAlignment = NSTextAlignmentCenter;
    titleNameSec.font = [UIFont systemFontOfSize:15];
    titleNameSec.text = @"Meeting Notes";
    titleNameSec.textColor = [UIColor colorWithHexString:@"2e2e2e"];
    [backGroundSec addSubview:titleNameSec];
    
    NSString *contentStr = @"Sophia has been very enthusiastic about their assignments/work, agreeable to new responsibilities, asks for new tasks. She also exceeds expectations in the complexity and difficulty of work they are able to successfully complete. Her work is always very thorough and excellent quality, few if any errors. She completes the majority of work within specified deadlines.\r\rHer problem solving skills is better than 80% of her peers. She can be relied upon to make good decisions, requires limited guidance. She also displays a strong work ethic and is present at meetings in a reliable and timely manner.\r\rSophia takes the initiate to follow through on all feedback from counselor and to continually improve upon her approach to all tasks.";
    UILabel *content = [[UILabel alloc] init];
    content.frame = CGRectMake(35, titleNameSec.bottom + 15, kScreenWidth-35*2, 5);
    content.font = [UIFont systemFontOfSize:14];
    content.text = contentStr;
    content.textColor = [UIColor colorWithHexString:@"434343"];
    [content heightForLableText:contentStr fontOfSize:14 frame:content.frame];
    [backGroundSec addSubview:content];
    
    backGroundSec.frame = CGRectMake(0, heightOne + 14, kScreenWidth, content.bottom + 20);
    _scrollView.contentSize = CGSizeMake(0, backGroundSec.bottom + 60);
    
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
