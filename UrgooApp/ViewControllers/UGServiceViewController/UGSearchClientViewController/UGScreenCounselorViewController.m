//
//  UGScreenCounselorViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/25.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGScreenCounselorViewController.h"
#import "Masonry.h"
@interface UGScreenCounselorViewController ()
@property(nonatomic,strong)UIButton *countyBtn;
@property(nonatomic,strong)UIButton *genderbtn;
@property(nonatomic,strong)UIButton *tutorKindBtn;
@property(nonatomic,strong)UIButton *consultCanBtn;
@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *genderbtn1;
@property(nonatomic,strong)UIButton *genderbtn2;
@property(nonatomic,strong)UIButton *tutorKind1;
@property(nonatomic,strong)UIButton *tutorKind2;
@property(assign,nonatomic) int countynumber;//clickGender
@property(assign,nonatomic) int gendernumber;//tutorKind
@property(assign,nonatomic) int tutorKindnumber;//consultCan
@property(assign,nonatomic) int consultCannumber;
@end

@implementation UGScreenCounselorViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    //顾问擅长
   
    UILabel * consultlable = [[UILabel alloc]initWithFrame:CGRectMake(15, 230, 70, 16)];
    consultlable.text = @"顾问擅长：";
    consultlable.font = [UIFont systemFontOfSize:12];
    //countyLable1.backgroundColor = [UIColor whiteColor];
    [consultlable setTextColor:[UIColor colorWithHexString:@"#434343"]];
    [self.view addSubview:consultlable];
    
    
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"英本",@"美高",@"美本",@"艺术", @"英国", @"加本",@"澳/新 本科",nil];

    
    
    
    if (!_arrayM || !_arrayM.count){
        
        for (int i = 0;i< _consultCanArray.count; i++) {
             NSString * strtag = [NSString stringWithFormat:@"%@",_consultCanArray[i][@"lableId"]];
            NSInteger index = i % 2;
            NSInteger page = i / 2;
            CGFloat width = 80;
            CGFloat widthSpace = 30;
            CGFloat hight = 28;
            CGFloat hightSpace = 8;
            UIButton * consultCan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            NSInteger k = [strtag integerValue];
            consultCan.tag =k;
            consultCan.layer.borderColor = [RGB(213, 213, 213) CGColor];
            consultCan.layer.borderWidth = 1.0f;
            consultCan.layer.cornerRadius = 7;
            consultCan.clipsToBounds = YES;
            consultCan.backgroundColor = [UIColor whiteColor];
            [consultCan setTitle:_consultCanArray[i][@"lableCnName"] forState:UIControlStateNormal];
            [consultCan setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
            [consultCan addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            consultCan.frame = CGRectMake(10 + index *(width + widthSpace), page*(
                                                                                  hight + hightSpace ) + consultlable.origin.y +26                      , width, hight);
            
            //consultCan.backgroundColor = [UIColor blueColor];
            [self.view addSubview:consultCan];
            
        }
        //array是空或nil
    }else{
            if (_arrayM.count >0) {
                //int num = (int)_arrayM[0];
                
                
                NSString * str1 =[NSString stringWithFormat:@"%@", _arrayM[0]];
               NSString * str2 =[NSString stringWithFormat:@"%@", _arrayM[0]];
                 NSString * str3 =[NSString stringWithFormat:@"%@", _arrayM[0]];
                 NSString * str4 =[NSString stringWithFormat:@"%@", _arrayM[0]];
                NSLog(@"%@",str2);
                //第一个
                if ([str1 isEqualToString:@"1"]) {
                    NSLog(@"dss");
                    
                    _btn1.backgroundColor = RGB(38, 189, 171);
                     _btn1.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _btn1;
                }else if ([str1 isEqualToString:@"2"]){
                    _btn2.backgroundColor = RGB(38, 189, 171);
                    _btn2.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _btn2;

                }
                //第二个
                if ([str2 isEqualToString:@"3"]) {
                    NSLog(@"dss");
                    
                    _genderbtn1.backgroundColor = RGB(38, 189, 171);
                    _genderbtn1.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_genderbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _genderbtn1;
                }else if ([str2 isEqualToString:@"4"]){
                    NSLog(@"dierge ");
                    _genderbtn2.backgroundColor = RGB(38, 189, 171);
                    _genderbtn2.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_genderbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _genderbtn2;
                    
                }
               //第三个
                if ([str3 isEqualToString:@"5"]) {
                    NSLog(@"dss");
                    
                    _tutorKind1.backgroundColor = RGB(38, 189, 171);
                    _tutorKind1.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_tutorKind1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _tutorKind1;
                }else if ([str3 isEqualToString:@"6"]){
                    NSLog(@"dierge ");
                    _tutorKind2.backgroundColor = RGB(38, 189, 171);
                    _tutorKind2.layer.borderColor = [RGB(38, 189, 171) CGColor];
                    [_tutorKind2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                    //定义第一个按钮sender是已经被选中
                    _countyBtn = _tutorKind2;
                    
                }
                for (int i = 0;i< _consultCanArray.count; i++) {
                    NSString * strtag = [NSString stringWithFormat:@"%@",_consultCanArray[i][@"lableId"]];
                    NSInteger index = i % 2;
                    NSInteger page = i / 2;
                    CGFloat width = 80;
                    CGFloat widthSpace = 30;
                    CGFloat hight = 28;
                    CGFloat hightSpace = 8;
                    UIButton * consultCan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                
                    ;
                     NSInteger k = [strtag integerValue];
                    consultCan.tag =k;
                     consultCan.layer.borderColor = [RGB(213, 213, 213) CGColor];
                    consultCan.layer.borderWidth = 1.0f;
                    consultCan.layer.cornerRadius = 7;
                    consultCan.clipsToBounds = YES;
                    consultCan.backgroundColor = [UIColor whiteColor];
                    [consultCan setTitle:_consultCanArray[i][@"lableCnName"] forState:UIControlStateNormal];
                    [consultCan setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
                    [consultCan addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
                    
                    consultCan.frame = CGRectMake(10 + index *(width + widthSpace), page*(
                                                                                          hight + hightSpace ) + consultlable.origin.y +26                      , width, hight);
                    
                    //consultCan.backgroundColor = [UIColor blueColor];
                    //默认第一个选中
                    
                    if ([str4 isEqualToString:strtag]) {
                        consultCan.backgroundColor = RGB(38, 189, 171);
                        consultCan.layer.borderColor = [RGB(38, 189, 171) CGColor];
                        [consultCan setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        //定义第一个按钮sender是已经被选中
                        _countyBtn = consultCan;
                                          }

                    [self.view addSubview:consultCan];
                    
                }
            
            }
        
    }

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self needBackAction:YES];
    [self setCustomTitle:@"筛选顾问"];
    [self initUI];
}
-(void)initUI{
    
    NSLog(@"%@",_arrayM);
    NSLog(@"---------%ld",(long)_countyBtn.tag);
    
    // 国籍
    UILabel * countyLable1 = [[UILabel alloc]init];
    countyLable1.text = @"国籍：";
    countyLable1.font = [UIFont systemFontOfSize:12];
    //countyLable1.backgroundColor = [UIColor whiteColor];
    [countyLable1 setTextColor:[UIColor colorWithHexString:@"#434343"]];
    [self.view addSubview:countyLable1];
    
   _btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _btn1.tag =1;
    _btn1.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _btn1.layer.borderWidth = 1.0f;
    _btn1.layer.cornerRadius = 7;
    _btn1.clipsToBounds = YES;
    _btn1.backgroundColor = [UIColor whiteColor];
    [_btn1 setTitle:@"中国籍" forState:UIControlStateNormal];
    [_btn1 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_btn1 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn1];
    _btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _btn2.tag =2;
    _btn2.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _btn2.layer.borderWidth = 1.0f;
    _btn2.layer.cornerRadius = 7;
   _btn2.clipsToBounds = YES;
    _btn2.backgroundColor = [UIColor whiteColor];
    [_btn2 setTitle:@"外籍" forState:UIControlStateNormal];
    [_btn2 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_btn2 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn2];
    
    [countyLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(15);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(55, 16));
        
            }];
    [_btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(countyLable1.mas_left);
        make.top.mas_equalTo(countyLable1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(72, 28));
    }];
    [_btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_btn1.mas_right).offset(30);
        make.top.mas_equalTo(countyLable1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(72, 28));
    }];
    
    //性别
    UILabel * genderLable1 = [[UILabel alloc]init];
    genderLable1.text = @"性别：";
    genderLable1.font = [UIFont systemFontOfSize:12];
    //countyLable1.backgroundColor = [UIColor whiteColor];
    [genderLable1 setTextColor:[UIColor colorWithHexString:@"#434343"]];
    [self.view addSubview:genderLable1];
    
    _genderbtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _genderbtn1.tag =3;
    _genderbtn1.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _genderbtn1.layer.borderWidth = 1.0f;
    _genderbtn1.layer.cornerRadius = 7;
    _genderbtn1.clipsToBounds = YES;
    _genderbtn1.backgroundColor = [UIColor whiteColor];
    [_genderbtn1 setTitle:@"男" forState:UIControlStateNormal];
    [_genderbtn1 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_genderbtn1 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_genderbtn1];
   _genderbtn2= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _genderbtn2.tag =4;
    _genderbtn2.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _genderbtn2.layer.borderWidth = 1.0f;
    _genderbtn2.layer.cornerRadius = 7;
    _genderbtn2.clipsToBounds = YES;
    _genderbtn2.backgroundColor = [UIColor whiteColor];
    [_genderbtn2 setTitle:@"女" forState:UIControlStateNormal];
    [_genderbtn2 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_genderbtn2 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_genderbtn2];
    [genderLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_btn1.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(55, 16));
        
    }];
    [_genderbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(genderLable1.mas_left);
        make.top.mas_equalTo(genderLable1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 28));
    }];
    [_genderbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(genderLable1.mas_right).offset(20);
        make.top.mas_equalTo(genderLable1.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 28));
    }];
//辅导方式
    
    UILabel * tutorKind = [[UILabel alloc]init];
    tutorKind.text = @"辅导方式：";
    tutorKind.font = [UIFont systemFontOfSize:12];
    //countyLable1.backgroundColor = [UIColor whiteColor];
    [tutorKind setTextColor:[UIColor colorWithHexString:@"#434343"]];
    [self.view addSubview:tutorKind];
    
   _tutorKind1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _tutorKind1.tag =5;
    _tutorKind1.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _tutorKind1.layer.borderWidth = 1.0f;
    _tutorKind1.layer.cornerRadius = 7;
    _tutorKind1.clipsToBounds = YES;
    _tutorKind1.backgroundColor = [UIColor whiteColor];
    [_tutorKind1 setTitle:@"远程" forState:UIControlStateNormal];
    [_tutorKind1 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_tutorKind1 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tutorKind1];
   _tutorKind2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
    _tutorKind2.tag =6;
    _tutorKind2.layer.borderColor = [RGB(213, 213, 213) CGColor];
    _tutorKind2.layer.borderWidth = 1.0f;
    _tutorKind2.layer.cornerRadius = 7;
    _tutorKind2.clipsToBounds = YES;
    _tutorKind2.backgroundColor = [UIColor whiteColor];
    [_tutorKind2 setTitle:@"面授" forState:UIControlStateNormal];
    [_tutorKind2 setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
    [_tutorKind2 addTarget:self action:@selector(clickCountyBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_tutorKind2];
    [tutorKind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_genderbtn1.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 16));
        
    }];
    [_tutorKind1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tutorKind.mas_left);
        make.top.mas_equalTo(tutorKind.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 28));
    }];
    [_tutorKind2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tutorKind.mas_right).offset(20);
        make.top.mas_equalTo(tutorKind.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(55, 28));
    }];
////顾问擅长
//    
//    UILabel * consultlable = [[UILabel alloc]initWithFrame:CGRectMake(15, 230, 70, 16)];
//    consultlable.text = @"顾问擅长：";
//    consultlable.font = [UIFont systemFontOfSize:12];
//    //countyLable1.backgroundColor = [UIColor whiteColor];
//    [tutorKind setTextColor:[UIColor colorWithHexString:@"#434343"]];
//    [self.view addSubview:consultlable];
//
//    
//    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:@"英本",@"美高",@"美本",@"艺术", @"英国", @"加本",@"澳/新 本科",nil];
//    
//    for (int i = 0;i< 7; i++) {
//        NSInteger index = i % 2;
//        NSInteger page = i / 2;
//        CGFloat width = 80;
//        CGFloat widthSpace = 30;
//        CGFloat hight = 28;
//         CGFloat hightSpace = 8;
//        UIButton * consultCan = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        consultCan.tag =i;
//        consultCan.layer.borderColor = [[UIColor blackColor] CGColor];
//        consultCan.layer.borderWidth = 1.0f;
//        consultCan.layer.cornerRadius = 7;
//        consultCan.clipsToBounds = YES;
//        consultCan.backgroundColor = [UIColor whiteColor];
//        [consultCan setTitle:array[i] forState:UIControlStateNormal];
//        [consultCan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [consultCan addTarget:self action:@selector(clickconsultCanBtn:) forControlEvents:UIControlEventTouchUpInside];
//      
//       consultCan.frame = CGRectMake(10 + index *(width + widthSpace), page*(
//                                                                             hight + hightSpace ) + consultlable.origin.y +26                      , width, hight);
//        
//        //consultCan.backgroundColor = [UIColor blueColor];
//        [self.view addSubview:consultCan];
//        
//    }
    
    
    
    _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 420, kScreenWidth-40, 50)];
    _confirmBtn.backgroundColor = RGB(38, 189, 171);
    _confirmBtn.layer.cornerRadius = 10;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitle:@"确认" forState: UIControlStateNormal ];
    [_confirmBtn addTarget:self action:@selector(clickConfirmBtn) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:_confirmBtn];
    
}
//选择国籍
-(void)clickCountyBtn:(UIButton *)sender{
   //[_countyBtn addSubview:]
       //点击的和上次是一样的
    if(_countyBtn == sender) {
        _countynumber+=1;
       
        if ((_countynumber + 1)%2 ==0) {
            
            sender.layer.borderColor = [RGB(213, 213, 213) CGColor];
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:RGB(102, 102, 102) forState:UIControlStateNormal];
            //sender.tag = 0;
        }
        else if((_countynumber + 1)%2 ==1){
        sender.backgroundColor = RGB(38, 189, 171);
        //设置边框颜色
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
       
        //设置背景颜色
       
               [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
//        _countyBtn.backgroundColor = [UIColor whiteColor];
//        _countyBtn.layer.borderColor = [[UIColor blackColor] CGColor];
//        [_countyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        _countyBtn.layer.masksToBounds = YES;
        }
       
    } else{
        _countynumber=0;
        sender.backgroundColor = RGB(38, 189, 171);
        //设置边框颜色
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        //设置边框宽度
        sender.layer.borderWidth = 1.0f;
        //给按钮设置角的弧度
        sender.layer.cornerRadius = 7.0f;
        //设置背景颜色
        //button.backgroundColor = [UIColor redColor];
        sender.layer.masksToBounds = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _countyBtn.backgroundColor = [UIColor whiteColor];
        _countyBtn.layer.borderColor = [RGB(213, 213, 213) CGColor];
        [_countyBtn setTitleColor: RGB(102, 102, 102) forState:UIControlStateNormal];
        _countyBtn.layer.masksToBounds = YES;

        
    }
    
    _countyBtn = sender;
    //_text1 =sender.titleLabel.text;

    
}
-(void)clickGenderBtn:(UIButton *)sender{
    
    NSLog(@"dianji性别 ");
    if(_genderbtn == sender) {
        
        _gendernumber+=1;
        
        if ((_gendernumber + 1)%2 ==0) {
            
            sender.layer.borderColor = [[UIColor blackColor] CGColor];
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //sender.tag = 0;
        }
        else if((_gendernumber + 1)%2 ==1){
            sender.backgroundColor = RGB(38, 189, 171);
            //设置边框颜色
            sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
            
            //设置背景颜色
            
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            

        }
        
    } else{
        _gendernumber =0;
        sender.backgroundColor = RGB(38, 189, 171);
        //设置边框颜色
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        //设置边框宽度
        sender.layer.borderWidth = 1.0f;
        //给按钮设置角的弧度
        sender.layer.cornerRadius = 7.0f;
        //设置背景颜色
        //button.backgroundColor = [UIColor redColor];
        sender.layer.masksToBounds = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _genderbtn.backgroundColor = [UIColor whiteColor];
        _genderbtn.layer.borderColor = [[UIColor blackColor] CGColor];
        [_genderbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _genderbtn.layer.masksToBounds = YES;
        
    }
    
    _genderbtn = sender;

    
}
-(void)clicktutorKindBtn:(UIButton *)sender{
    
    NSLog(@"dianji服务方式 ");
    if(_tutorKindBtn == sender) {
        
        _tutorKindnumber+=1;
        
        if ((_tutorKindnumber + 1)%2 ==0) {
            
            sender.layer.borderColor = [[UIColor blackColor] CGColor];
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //sender.tag = 0;
        }
        else if((_tutorKindnumber + 1)%2 ==1){
            _tutorKindnumber =0;
            sender.backgroundColor = RGB(38, 189, 171);
            //设置边框颜色
            sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
            
            //设置背景颜色
            
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
        }

        
        
    } else{
        
        sender.backgroundColor = RGB(38, 189, 171);
        //设置边框颜色
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        //设置边框宽度
        sender.layer.borderWidth = 1.0f;
        //给按钮设置角的弧度
        sender.layer.cornerRadius = 7.0f;
        //设置背景颜色
        //button.backgroundColor = [UIColor redColor];
        sender.layer.masksToBounds = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _tutorKindBtn.backgroundColor = [UIColor whiteColor];
        _tutorKindBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        [_tutorKindBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _tutorKindBtn.layer.masksToBounds = YES;
        
    }
    
    _tutorKindBtn = sender;
    

    
}
-(void)clickconsultCanBtn:(UIButton *)sender{
    
    NSLog(@"dianji顾问擅长 ");
    if(_consultCanBtn == sender) {
        _consultCannumber+=1;
        
        if ((_consultCannumber + 1)%2 ==0) {
            
            sender.layer.borderColor = [[UIColor blackColor] CGColor];
            sender.backgroundColor = [UIColor whiteColor];
            [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //sender.tag = 0;
        }
        else if((_consultCannumber + 1)%2 ==1){
            sender.backgroundColor = RGB(38, 189, 171);
            //设置边框颜色
            sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
            
            //设置背景颜色
            
            [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
        }

        
        
    } else{
        _consultCannumber = 0;
        sender.backgroundColor = RGB(38, 189, 171);
        //设置边框颜色
        sender.layer.borderColor = [RGB(38, 189, 171) CGColor];
        //设置边框宽度
        sender.layer.borderWidth = 1.0f;
        //给按钮设置角的弧度
        sender.layer.cornerRadius = 7.0f;
        //设置背景颜色
        //button.backgroundColor = [UIColor redColor];
        sender.layer.masksToBounds = YES;
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _consultCanBtn.backgroundColor = [UIColor whiteColor];
        _consultCanBtn.layer.borderColor = [[UIColor blackColor] CGColor];
        [_consultCanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _consultCanBtn.layer.masksToBounds = YES;
        
    }
    
    _consultCanBtn = sender;
    
    

    
}

-(void)clickConfirmBtn{
    NSLog(@"%ld",(long)_consultCanBtn.tag);
    if ((_countynumber + 1)%2 ==0) {
       _countyBtn.tag = 0;
    }
       long tag1 = _countyBtn.tag;
    NSLog(@"%ld",tag1);

    [self.navigationController popViewControllerAnimated:YES];
     NSMutableArray *array = [NSMutableArray array];
    [array addObject:[NSNumber numberWithInt:(int)tag1]];
    NSLog(@"array======%@",array);
    _settingBlock(array);
    
    
}
/*

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
