//
//  UGEvaluationView.m
//  UrgooApp
//
//  Created by UrgooDev on 16/6/20.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGEvaluationView.h"
#import "Masonry.h"
@interface UGEvaluationView()<UITextViewDelegate>
@property (strong,nonatomic) UITextView * leaveMessageView;
@property (strong,nonatomic) UIButton * evluationBtn;
@property  (strong,nonatomic) NSString * btnString;
@end
@implementation UGEvaluationView
-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    [self initUI];
    self.backgroundColor = [UIColor whiteColor];
    return self;
    
}
-(void)clickcontactRecognizer{
    
    
    
    [_leaveMessageView resignFirstResponder];
}
-(void)initUI{
    NSArray * array = [NSArray arrayWithObjects:@"很合适，希望进一步了解",@"再看看其他顾问",@"不合适", nil];
    
    UILabel * evluation = [[UILabel alloc]init];
    evluation.text = @"评价";
    evluation.font =[UIFont systemFontOfSize:16];
    evluation.textColor = [UIColor colorWithHexString:@"#4c4c4c"];
    UITapGestureRecognizer * contactRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickcontactRecognizer)];
    
    [self addGestureRecognizer:contactRecognizer];
    [self addSubview:evluation];
    
    
    
    UIButton * cancleBtn = [[UIButton alloc]init];
    
    [cancleBtn setImage:[UIImage imageNamed:@"schedule_cancle_btn" ] forState:UIControlStateNormal];
    //[cancleBtn addTarget:self action:@selector(blackView)  forControlEvents:UIControlEventTouchUpInside];
    UIView * clrearView = [[UIView alloc] init];
    clrearView.backgroundColor = [UIColor clearColor];
  UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackView)];
    
    [clrearView addGestureRecognizer:tapRecognizer];
    [self addSubview:clrearView];
    [self addSubview:cancleBtn];
    [self insertSubview:clrearView aboveSubview:cancleBtn];
   
    
    
    
    
    
    for (int i =0; i<3; i++ ) {
        UIButton * cancleDtlBtn = [[UIButton alloc]init];
        cancleDtlBtn.layer.cornerRadius = 10;
        [cancleDtlBtn setTitle:array[i] forState:UIControlStateNormal];
        cancleDtlBtn.layer.borderWidth = 0.5;
        cancleDtlBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        cancleDtlBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [cancleDtlBtn addTarget:self action:@selector(clickCancleBtn:) forControlEvents: UIControlEventTouchUpInside];
        [cancleDtlBtn setTitleColor:[UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal ];
        [self addSubview:cancleDtlBtn];
        
        if (i==0) {
          
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).offset(48);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));
                
            }];
        }else if(i==1){
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).offset(87);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));
                
            }];
            
        }else if(i==2){
            [cancleDtlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.mas_top).offset(126);
                make.centerX.mas_equalTo(self.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(185, 30));

                
            }];
        }

    }
    
    
    //留言
    UILabel * leaveMessage = [[UILabel alloc]init];
    leaveMessage.text = @"留言:";
    leaveMessage.font = [UIFont systemFontOfSize:14];
    [leaveMessage setTextColor:[UIColor colorWithHexString:@"#4c4c4c"]];
    leaveMessage.textAlignment =  NSTextAlignmentLeft;
    [self addSubview:leaveMessage];
    //输入框
    _leaveMessageView = [[UITextView alloc] init];
    _leaveMessageView.delegate = self;
    _leaveMessageView.layer.borderWidth = 0.5;
    _leaveMessageView.layer.borderColor = RGB(227, 227, 227).CGColor;
    [self addSubview:_leaveMessageView];
    //确定按钮
    UIButton * bottomBtn = [[UIButton alloc]init];
    bottomBtn.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBtn setTitle:@"确定" forState: UIControlStateNormal];
    [bottomBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState: UIControlStateNormal];
    [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomBtn];


    [evluation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(33, 16));
    }];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(10);
        make.right.mas_equalTo(self.mas_right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(12, 13));
    }];
    [clrearView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cancleBtn.mas_top).offset(-10);
        make.right.mas_equalTo(self.mas_right);
        make.size.mas_equalTo(CGSizeMake(32, 33));
    }];
    [leaveMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(173);
        make.left.mas_equalTo(self.mas_left).offset(23);
        make.size.mas_equalTo(CGSizeMake(43, 14));
    }];
    [_leaveMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(197);
        make.left.mas_equalTo(self.mas_left).offset(25);
        make.size.mas_equalTo(CGSizeMake(220, 72));
    }];

    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.left.mas_equalTo(self.mas_left);
        make.right.mas_equalTo(self.mas_right);
        make.height.mas_equalTo(36);
    }];

}
    
#pragma mark 发送评价网络请求
-(void)clickBottomBtn{
    
    
    NSLog(@"%@",_btnString);
    NSLog(@"%@",_leaveMessageView.text);
      if ([self.index isEqualToString:@"视频结束后"]) {
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"token"]= kToken;
        params[@"advanceId"]= self.advanceId;
        params[@"commentTitle"]= _btnString;
        params[@"comment"]= _leaveMessageView.text;
          NSMutableDictionary * params1 = [NSMutableDictionary dictionary];
          params1[@"token"]= kToken;
          params1[@"advanceId"]= self.advanceId;

          NSLog(@"%@",self.advanceId);
        [HttpClientManager postAsyn:advanceCommentClient params:params success:^(id json) {
            NSLog(@"%@",json);
            NSString * str = json[@"header"][@"code"];
            if ([str isEqualToString:@"200"]) {
                //_evalutionBlack();
                   _VoideEvaluationBlock();
                
            }
            
        } failure:^(NSError *error) {
            
        }];
         
          _VoideEvaluationBlock();
//    [HttpClientManager postAsyn:updateAdvanceStatus params:params1 success:^(id json) {
//              
//        [SVProgressHUD showSuccessWithStatus:@"你玩我"];
//             
//          } failure:^(NSError *error) {
//          }];

        
    }else{
        NSMutableDictionary * params = [NSMutableDictionary dictionary];
        params[@"token"]= kToken;
        params[@"advanceId"]= self.advanceId;
        params[@"commentTitle"]= _btnString;
        params[@"comment"]= _leaveMessageView.text;
        
        
        [HttpClientManager postAsyn:advanceCommentClient params:params success:^(id json) {
            NSLog(@"%@",json);
            NSString * str = json[@"header"][@"code"];
            if ([str isEqualToString:@"200"]) {
                //_evalutionBlack();
            }
            
        } failure:^(NSError *error) {
            
        }];

        _viewRemove();
    }
    
}
-(void)blackView{
    
    _viewRemove();

}
-(void)clickCancleBtn:(UIButton *)sender{
    if (_evluationBtn ==sender) {
        
    }else{
        
        sender.backgroundColor = RGB(38, 189, 171);
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _evluationBtn.backgroundColor = [UIColor whiteColor];
        _evluationBtn.layer.borderColor = [[UIColor colorWithHexString:@"#26bdab"] CGColor];
        [_evluationBtn setTitleColor: [UIColor colorWithHexString:@"#26bdab"] forState:UIControlStateNormal];
        _evluationBtn.layer.masksToBounds = YES;
    }
    
    
    _evluationBtn = sender;
    _btnString =  _evluationBtn.titleLabel.text;
    
}

@end
