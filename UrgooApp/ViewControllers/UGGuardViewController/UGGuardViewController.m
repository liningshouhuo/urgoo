//
//  UGGuardViewController.m
//  UrgooApp
//
//  Created by admin on 16/4/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGGuardViewController.h"
#import "UrgooTabBarController.h"
@interface UGGuardViewController ()
{
    UIScrollView *_scrollView;
}
@end

@implementation UGGuardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 5, 0);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"6-%d",i+1]];
        
        if (i == 4) {
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
            gest.numberOfTapsRequired = 1;
            gest.numberOfTouchesRequired = 1;
            [imageView addGestureRecognizer:gest];
        }
        
        [_scrollView addSubview:imageView];
    }
    [self.view addSubview:_scrollView];
}
- (void)tapAction {
    [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"guide"];
    //[[[UIApplication sharedApplication] delegate] window].rootViewController = [[UrgooTabBarController alloc]init];
    [[AppDelegate sharedappDelegate] showNewLong];
    
    //[self presentViewController:[[UrgooTabBarController alloc]init] animated:YES completion:^{
        
    //}];
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
