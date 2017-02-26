//
//  UGUnderstandUrgooViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGUnderstandUrgooViewController.h"
#import "Masonry.h"
@interface UGUnderstandUrgooViewController ()
@property (strong,nonatomic)UIScrollView * scrollView;
@end

@implementation UGUnderstandUrgooViewController
-(void)loadView{
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenWidth * 7 );
    UIImageView * imageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,kScreenWidth, kScreenWidth * 7 )];
    imageVIew.image = [UIImage imageNamed:@"30s_understand"];
    [_scrollView addSubview:imageVIew];
    UIButton  * button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(click_viewBtn) forControlEvents: UIControlEventTouchUpInside];
    //[_scrollView bringSubviewToFront:button];
    [_scrollView addSubview:button];
    [button  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(imageVIew.mas_bottom).offset(-kScreenHeight * 0.065);
        make.left.mas_equalTo(imageVIew.mas_left).offset(kScreenWidth * 0.173);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 2*kScreenWidth * 0.173, kScreenHeight *0.074));
    }];
    self.view = _scrollView;
}
-(void)click_viewBtn{
    NSLog(@"dianjil");
   
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"了解优顾"];
    
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
