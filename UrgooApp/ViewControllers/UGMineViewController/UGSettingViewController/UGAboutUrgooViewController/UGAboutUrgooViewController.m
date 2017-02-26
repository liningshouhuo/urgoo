//
//  UGAboutUrgooViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/30.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAboutUrgooViewController.h"

@interface UGAboutUrgooViewController ()
@property(strong,nonatomic)UIImageView *imageView;//图片
@property(strong,nonatomic)UILabel *versionLabel;//版本号
@end

@implementation UGAboutUrgooViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setCustomTitle:@"关于优顾"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
}
-(void)initUI{
   self.imageView  =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-40, 60, 80, 80)];
    self.imageView.image =[UIImage imageNamed:@"Icon-60"];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 8;
    [self.view addSubview:self.imageView];
    
    
    self.versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageView.x, self.imageView.y+self.imageView.height+10, self.imageView.width, 30)];
    self.versionLabel.textAlignment = NSTextAlignmentCenter;
    self.versionLabel.textColor = [UIColor colorWithHexString:@"656565"];
    [self.view addSubview:self.versionLabel];
    
    NSString *version = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSLog(@"%@",version);
    self.versionLabel.text = [NSString stringWithFormat:@"V%@",version];
    //UILabel * lable = [[UILabel alloc]init];
    UITextView *detailTextView =[[UITextView alloc]initWithFrame:CGRectMake(kScreenWidth/9,  self.versionLabel.y +  self.versionLabel.height + 10, kScreenWidth/9 *7, 200)];
    NSString * str = @"优顾是一个全球留学顾问共享平台，利用互联网技术以及线上线下资源，有效连接学生和全球顾问，成就学生的国际教育梦想，以及顾问的事业梦想。平台对顾问资质严格审核，对留学咨询服务流程监控，建立顾问信用评价体系；同时，平台承担资金担保责任，建立支付信用体系，保障学生的权益。";
    detailTextView.text = str;
    detailTextView.backgroundColor = [UIColor clearColor];
    detailTextView.textColor = [UIColor colorWithHexString:@"616161"];
    detailTextView.font =  [UIFont boldSystemFontOfSize:14];
    
    [detailTextView setEditable:NO];
    
    detailTextView.scrollEnabled=NO;
    [self.view addSubview:detailTextView];
    
 /**#ifdef DEBUG
    NSString *build = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    self.versionLabel.text = [NSString stringWithFormat:@"V%@.%@",version,build];
#else
    self.versionLabel.text = [NSString stringWithFormat:@"V%@",version];
#endif**/
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
