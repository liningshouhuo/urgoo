//
//  UGDateCollectionViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGDateCollectionViewCell.h"
@interface UGDateCollectionViewCell()
@property (strong,nonatomic) UIView * bgView;
@property (strong,nonatomic)  NSMutableArray * colorArray;
@property (strong,nonatomic)  NSMutableArray * dateArray;
@property (strong,nonatomic) UIButton * indexBtn;
@end
@implementation UGDateCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yl_collectionView:) name:@"yl_collectionView" object:nil];
//    _bgView = [[UIView alloc]init];
//    
//    
//    _bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
//    
//    [self.contentView addSubview:_bgView];
    
    //self.backgroundColor = [UIColor yellowColor];
     //[self setUI];
    return self;
}
-(void)setIndexpathArray:(NSMutableArray *)indexpathArray{
    [_bgView removeFromSuperview];
  _indexpathArray = [NSMutableArray arrayWithArray: indexpathArray];
    _colorArray = [NSMutableArray array];
    _dateArray = [NSMutableArray array];
    for (NSDictionary * dict in _indexpathArray) {
        [_colorArray addObject:dict[@"busyDay"]];
        [_dateArray addObject:dict[@"dataYanlong"]];
        
    }
   
    
    if (self.tagindex == 1) {
        NSLog(@"self.tagindex ==------1");
        [self setUI];
    }else if (self.tagindex == 2){
        NSLog(@"self.tagindex ==------2");
         [self setUI];
    }else if (self.tagindex == 3){
        NSLog(@"self.tagindex ==------3");
         [self setUI];
    }else if (self.tagindex == 4 ){
        NSLog(@"self.tagindex ==------4");
         [self setUI];
    }
    
    
    
  // [self setUI];
   
    
}
-(void)setUI{
    _bgView = [[UIView alloc]init];
    
    
    _bgView.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    
    [self.contentView addSubview:_bgView];

    //[self.contentView re]
        for (int i =0; i<7; i++) {
//        int space = 7;
//        CGFloat width = (kScreenWidth - 56)/7;
            
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = 10 * self.tagindex + i;
        //button.tag = 10 + i;
        button.frame = CGRectMake( i * kScreenWidth/7 +10, 0, 35, 35);
        
//        [button setTitleColor:[UIColor whiteColor] forState:  UIControlStateSelected ];
        //        [button setBackgroundImage:[self createImageWithColor:RGB(38, 189, 171)] forState:UIControlStateSelected];
        //        [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#f6f6f6"]] forState:UIControlStateNormal];
        [button setTitle:_dateArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
//     button.titleLabel.font = [UIFont systemFontOfSize:13];
//        //[button.titleLabel setTextColor:[UIColor blackColor]];
       // [button setTintColor:[UIColor blackColor]];
        if ([_colorArray[i] isEqualToString:@"black"] ||[_colorArray[i] isEqualToString:@"red"] ) {
            [button setBackgroundImage:[UIImage imageNamed:@"test_buttonimage"] forState:UIControlStateNormal];
             [button setBackgroundImage:[self createImageWithColor:[UIColor colorWithHexString:@"#26bdab"]] forState:UIControlStateSelected];
            //[button addTarget:self action:@selector(clickDatebutton1:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            //[button setBackgroundImage:[UIImage imageNamed:@"choose_btn_yeee"] forState:    UIControlStateSelected];
           //[button setImage:[UIImage imageNamed:@"choose_btn_y"] forState:UIControlStateSelected];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            
        }
            [button addTarget:self action:@selector(clickDatebutton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        button.layer.cornerRadius = 17.5;

            button.clipsToBounds = YES;
        [_bgView addSubview:button];
        
//        //默认第一个选中
//        if (button.tag == 10) {
//            
//            button.selected = YES;
//            button.tintColor = [UIColor whiteColor];
//            //[_dateView addSubview:button];
//            
//        }
        
        
    }

    
    
    
}
-(void)clickDatebutton1:(UIButton *)sender{
    
    sender.selected = YES;
    
    
}
-(void)clickDatebutton:(UIButton * )sender{
    
    
       if (self.tagindex == 1) {
        for (NSInteger i = 10; i<17; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            tmpButton.selected = NO;
            
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:sender.tag];
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
    }else if (self.tagindex == 2){
        for (NSInteger i = 20; i<27; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
            tmpButton.selected = NO;
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:sender.tag];
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
        
        
        
    }else if (self.tagindex == 3){
        for (NSInteger i = 30; i<37; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
            tmpButton.selected = NO;
            
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:sender.tag];
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
        
        
        
    }else if (self.tagindex == 4){
        for (NSInteger i = 40; i<47; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
            tmpButton.selected = NO;
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:sender.tag];
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
        
        
        
    }

//    if (_indexBtn ==sender) {
//        
//    }else{
//        sender.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
//        [sender setTitleColor:[UIColor whiteColor] forState: UIControlStateNormal ];
//        _indexBtn.backgroundColor = [UIColor whiteColor];
//        [_indexBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    }
//    
//    _indexBtn = sender;
   //sender.tag - 10;
   
        
//        for (NSInteger i = 10; i<17; i++) {
//            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
//            tmpButton.backgroundColor = [UIColor whiteColor];
//            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
//            
//        }
      NSInteger    button_index =sender.tag - self.tagindex * 10;
    sender.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
    
    
    
    NSString * button_indexstr = [NSString stringWithFormat:@"%ld",(long)button_index];
    NSLog(@"%@",button_indexstr);
    //NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:button_indexstr,@"button_indexstr", nil];
    //创建一个消息对象
    NSNotification * dateBtnNotice = [NSNotification notificationWithName:@"yl_clickdatebtn" object:self userInfo:dict];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:dateBtnNotice];

    
    
}
-(void)yl_collectionView:(NSNotification *)notification{
    NSString * indexSection= [NSString stringWithFormat:@"%@",notification.userInfo[@"index_str"]];
    NSLog(@"indexSection=====%@",indexSection);
  
    NSInteger indextag = [indexSection intValue] + self.tagindex * 10;
    if (self.tagindex == 1) {
        for (NSInteger i = 10; i<17; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            tmpButton.selected = NO;
            
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:indextag];
        button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
    }else if (self.tagindex == 2){
        for (NSInteger i = 20; i<27; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
             tmpButton.selected = NO;
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:indextag];
         button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        

        
        
        
    }else if (self.tagindex == 3){
        for (NSInteger i = 30; i<37; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
            tmpButton.selected = NO;

            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:indextag];
         button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
        
        
        
    }else if (self.tagindex == 4){
        for (NSInteger i = 40; i<47; i++) {
            UIButton * tmpButton = (UIButton *)[self.contentView viewWithTag:i];
            tmpButton.backgroundColor = [UIColor whiteColor];
            [tmpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
            
              tmpButton.selected = NO;
            
        }
        UIButton * button = (UIButton *)[self.contentView viewWithTag:indextag];
         button.selected = YES;
        button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        
        
        
        
        
    }


    
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
