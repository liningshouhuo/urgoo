//
//  UGEvaluationViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGEvaluationViewController.h"

@interface UGEvaluationViewController ()<UITextViewDelegate>
@property (strong,nonatomic) UITextView * leaveMessageView;
@property (strong,nonatomic) NSString * totleStr;
@property (strong,nonatomic) UIView * backView;
@end

@implementation UGEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomTitle:@"评价"];
    
    [self setUI];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Hidden:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)setUI{
 _backView =[[UIView alloc]initWithFrame:CGRectMake(0, 15, kScreenWidth, 321)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
    [_backView addGestureRecognizer:tap];
    _backView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:_backView];
    UILabel * lable1 = [[UILabel alloc]init];
    lable1.text = @"对本次视频满意度:";
    lable1.font = [UIFont systemFontOfSize:13];
    lable1.frame = CGRectMake(10, 13, 130, 13);
    lable1.textColor = [UIColor colorWithHexString:@"#252525"];
    lable1.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:lable1];
    for (int i =0; i<5; i++) {
        UIButton * button = [[UIButton alloc]init];
        
        
        [button setImage:[UIImage imageNamed:@"Star_no_choose"] forState: UIControlStateNormal ];
       [button setImage:[UIImage imageNamed:@"Star_choose"] forState: UIControlStateSelected  ];
//        [button set]
        
        [button addTarget:self action:@selector(clickBTnStar:) forControlEvents:    UIControlEventTouchUpInside  ];
        button.frame = CGRectMake(kScreenWidth * 0.2+ i *50, 46, 30, 30);
        button.tag = 10+ i;
         [_backView addSubview:button];

    }
    UILabel * lable2 = [[UILabel alloc]init];
    lable2.text = @"对顾问做个评价:";
    lable2.font = [UIFont systemFontOfSize:13];
    lable2.frame = CGRectMake(10, 116, 130, 13);
    lable2.textColor = [UIColor colorWithHexString:@"#252525"];
    lable2.textAlignment = NSTextAlignmentLeft;
    [_backView addSubview:lable2];

    //留言框
    _leaveMessageView = [[UITextView alloc] init];
    _leaveMessageView.delegate = self;
    //_leaveMessageView.text = _advancelModel.message;
    _leaveMessageView.userInteractionEnabled = YES;
    _leaveMessageView.layer.borderWidth = 0.5;
    _leaveMessageView.layer.borderColor = RGB(227, 227, 227).CGColor;
    _leaveMessageView.frame = CGRectMake(10, 147, kScreenWidth, 112);
    [_backView addSubview:_leaveMessageView];
    UIButton * bottomBtn = [[UIButton alloc]init];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [bottomBtn setTitle:@"提交" forState:0];
    bottomBtn.frame = CGRectMake(0, kScreenHeight - 44 -64, kScreenWidth, 44);
    
    [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
   // [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside UIControlEventTouchUpInside];
    [self.view addSubview:bottomBtn];
    
}
-(void)clickBTnStar:(UIButton * )sender{
   // int totleStar=0;
    
    if (sender.selected) {
        sender.selected = NO;
    }else{
        
        sender.selected = YES;
    }
    for (NSInteger i = 10; i<15; i++) {
        
            UIButton * tmpBtn = (UIButton * )[self.view  viewWithTag:i];
            //[tmpBtn setImage:[UIImage imageNamed:@"Star_no_choose"] forState:  UIControlStateNormal   ];
           tmpBtn.selected= NO;
       

  }
   //  [tmpBtn setImage:[UIImage imageNamed:@"Star_choose"] forState:  UIControlStateNormal   ];
    for (NSInteger i = 10; i<15; i++) {
        if (i < sender.tag +1) {
            UIButton * tmpBtn = (UIButton * )[self.view  viewWithTag:i];
           // [tmpBtn setImage:[UIImage imageNamed:@"Star_choose"] forState:  UIControlStateNormal   ];
            tmpBtn.selected= YES;
        }
    }
        
//        if (i< sender.tag) {
//        UIButton * tmpBtn = (UIButton * )[self.view  viewWithTag:i];
//            tmpBtn.selected = YES;
//        }
//        UIButton * tmpBtn = (UIButton * )[self.view  viewWithTag:i];
//        if (tmpBtn .selected) {
//            totleStar+=1;
//        }
//        
        
    
    
    NSLog(@"%ld",sender.tag -9);
    _totleStr = [NSString stringWithFormat:@"%ld",sender.tag -9];
    
    NSLog(@"_totleStr====%@",_totleStr);
    
}
-(void)clickBottomBtn{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"token"]= kToken;
    params[@"advanceId"]= self.advanceId;
    params[@"star"]= _totleStr;
    params[@"comment"]= _leaveMessageView.text;
    NSLog(@"%@",params);
    [HttpClientManager postAsyn:advanceCommentClient params:params success:^(id json) {
        NSLog(@"%@",json);
        NSString * str = json[@"header"][@"code"];
        if ([str isEqualToString:@"200"]) {
            NSLog(@"评价成功");
        }
        
    } failure:^(NSError *error) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
   
}


#pragma mark -监听键盘的升降
- (void)keyboard_Show:(NSNotification *)nf {
    //获取键盘的高度
    NSDictionary *info = [nf userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    if (keyboardSize.height > 200) {
        
        [UIView animateWithDuration:0.25 animations:^{
            if (kScreenHeight < 660) {
                _backView.frame = CGRectMake(0, -90, kScreenWidth, kScreenHeight);
            }else{
                _backView.frame = CGRectMake(0, -70, kScreenWidth, kScreenHeight);
            }
        } completion:^(BOOL finished) {
        }];
    }
    
}
- (void)keyboard_Hidden:(NSNotification *)nf {
    
    [UIView animateWithDuration:0.25 animations:^{
    } completion:^(BOOL finished) {
        _backView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
-(void)tapTouch
{
    [self.view endEditing:YES];
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
