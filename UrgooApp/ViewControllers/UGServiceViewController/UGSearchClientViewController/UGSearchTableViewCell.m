//
//  UGSearchTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSearchTableViewCell.h"
#import "Masonry.h"
#import "MJRefresh.h"
@interface UGSearchTableViewCell()
@property (strong,nonatomic) UIView * view;
@property (strong,nonatomic) UILabel * workYear;
@property (strong,nonatomic) UIImageView * imageview;
@property (strong,nonatomic) UIView * lineView;
@property (strong,nonatomic) UILabel * nameText;
@property (strong,nonatomic) UILabel * countylable;
@property (strong,nonatomic) UILabel * sloganlable;
@property (strong,nonatomic) UIImageView * countyTag;
@property (strong,nonatomic) UILabel * certifybutton;
@property (strong,nonatomic) NSArray * arrayM;
@property (strong,nonatomic) UIView * view1;
@property (strong,nonatomic) UIView * view2;
@property (strong,nonatomic) UIView * view3;
@property (strong,nonatomic) UILabel * lable1;
@property (strong,nonatomic) UILabel * lable2;
@property (strong,nonatomic) UILabel * lable3;
@property (strong,nonatomic) NSString * lableCnNAme;

@end
@implementation UGSearchTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //self.contentView.backgroundColor =[UIColor yellowColor];
    [self initUI];
    return self;
}
-(void)setCounselorModel:(CounselorListModel *)counselorModel{
    
    _counselorModel = counselorModel;
    NSString * str = [NSString stringWithFormat:@"从业年数%@",_counselorModel.workYear];
    _workYear.text = str;
    CGSize size = [_workYear.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_workYear.font,NSFontAttributeName, nil]];
    [_workYear mas_updateConstraints:^(MASConstraintMaker *make) {
         make.size.mas_equalTo(CGSizeMake(size.width +2, size.height));
    }];
    
//     if (!_arrayM || !_arrayM.count)
    if (!_counselorModel.organization || !_counselorModel.organization.count) {
        _certifybutton.hidden = YES;
    }else{
        CGSize size = [ _counselorModel.organization[0] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_certifybutton.font,NSFontAttributeName, nil]];
        [_certifybutton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_view.mas_top).offset(10);
            make.right.mas_equalTo(_view.mas_right).offset(-20);
            make.size.mas_equalTo(CGSizeMake(size.width +2 , size.height +2));
        }];

        _certifybutton.text= _counselorModel.organization[0] ;
    }
    _nameText.text = _counselorModel.enName;
    _countylable.text = _counselorModel.countyName;
    CGSize _countylablesize = [_countylable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_countylable.font,NSFontAttributeName, nil]];
    [_countylable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(_countylablesize.width +2, 16));
    }];

    _sloganlable.text = _counselorModel.slogan;
    //判断小橙点
    if (_counselorModel.slogan == nil) {
        
        [_view1 mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameText.mas_left);
            make.centerY.mas_equalTo(_view.mas_centerY).offset(20);
            make.size.mas_equalTo(CGSizeMake(6, 6));
        }];
        
          }else{
        
              [_view1 mas_updateConstraints:^(MASConstraintMaker *make) {
                  make.left.mas_equalTo(_sloganlable.mas_left);
                  make.top.mas_equalTo(_view.mas_top).offset(123);
                  make.size.mas_equalTo(CGSizeMake(6, 6));
              }];

        
         [self.contentView layoutIfNeeded];
        
    }

    _arrayM = _counselorModel.lableList;
    if (_arrayM.count >0) {
        if (_arrayM.count > 3) {
            _lable1.text = _arrayM[0][@"lableCnNAme"];
            NSLog(@"%@", _lable1.text);
            _lable2.text =_arrayM[1][@"lableCnNAme"];
            NSLog(@"%@", _lable2.text);
            _lable3.text = _arrayM[2][@"lableCnNAme"];
            NSLog(@"%@", _lable3.text);

        }else if (_arrayM.count ==1){
            _lable1.text = _arrayM[0][@"lableCnNAme"];
            _view2.hidden =YES;
            _view3.hidden =YES;
            _lable2.hidden = YES;
            _lable3.hidden = YES;
        }else if (_arrayM.count == 2){
            _lable1.text = _arrayM[0][@"lableCnNAme"];
            _lable2.text =_arrayM[1][@"lableCnNAme"];
            _view3.hidden =YES;
            _lable3.hidden = YES;

        }else if (_arrayM.count == 3){
            _lable1.text = _arrayM[0][@"lableCnNAme"];
          
            _lable2.text =_arrayM[1][@"lableCnNAme"];
           
            _lable3.text = _arrayM[2][@"lableCnNAme"];
          

        }
        
    }else{
        _view1.hidden =YES;
        _view2.hidden =YES;
        _view3.hidden =YES;
        _lable1.hidden = YES;
        _lable2.hidden = YES;
        _lable3.hidden = YES;
    }
//    switch (_arrayM.count) {
//        case 0:
//            _view1.hidden =YES;
//             _view2.hidden =YES;
//             _view3.hidden =YES;
//            _lable1.hidden = YES;
//             _lable2.hidden = YES;
//            _lable3.hidden = YES;
//            break;
//            case 1:
//            _lable1.text = _arrayM[0][@"lableCnNAme"];
//            _view2.hidden =YES;
//            _view3.hidden =YES;
//            _lable2.hidden = YES;
//            _lable3.hidden = YES;
//            break;
//            case 2:
//            _lable1.text = _arrayM[0][@"lableCnNAme"];
//            _lable2.text =_arrayM[1][@"lableCnNAme"];
//             _view3.hidden =YES;
//             _lable3.hidden = YES;
//            break;
//            case 3:
//            
//            _lable1.text = _arrayM[0][@"lableCnNAme"];
//            NSLog(@"%@", _lable1.text);
//            _lable2.text =_arrayM[1][@"lableCnNAme"];
//              NSLog(@"%@", _lable2.text);
//            _lable3.text = _arrayM[2][@"lableCnNAme"];
//              NSLog(@"%@", _lable3.text);
//        default:
//            break;
//    }
    
        NSLog(@"%@", [NSString stringWithFormat:@"%@%@",UG_HOST,_counselorModel.userIcon]);
    
    //头像
    NSString * qingdaostr = _counselorModel.userIcon;
    if ([qingdaostr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [_imageview sd_setImageWithURL:[NSURL URLWithString:_counselorModel.userIcon ] placeholderImage:[UIImage imageNamed:@"default_icon"] ];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,_counselorModel.userIcon];
        
        
        NSLog(@"%@",imageUrl);
        [_imageview sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"default_icon"]  ];
    }
   
    
    [self.contentView layoutIfNeeded];
}
-(void)initUI{
    
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    
    _view = [[UIView alloc]init];
    _view.backgroundColor = [UIColor whiteColor];
    _view.layer.cornerRadius = 10;
    _view.layer.borderColor = [[UIColor colorWithHexString:@"#f7f7f7"] CGColor];
     _view.layer.borderWidth = 0.5f;
    _view.layer.shadowColor = RGB(102, 102, 102).CGColor;//阴影颜色
    _view.layer.shadowOffset = CGSizeMake(0, 2);//偏移距离
    _view.layer.shadowOpacity = 0.25;//不透明度
    _view.layer.shadowRadius = 2;//半径
    _view.clipsToBounds = NO;
    [self.contentView addSubview: _view];
     //头像
    _imageview = [[UIImageView alloc]init];
    //_imageview.layer.cornerRadius = 50;
    _imageview.image = [UIImage imageNamed:@"test_image"];
    _imageview.layer.cornerRadius = 30;
    _imageview.clipsToBounds = YES;
    _imageview.backgroundColor = [UIColor whiteColor];
    [ _view addSubview:_imageview];
    
    //工作经验
    _workYear = [[UILabel alloc]init];
    
    _workYear.text = @"从业年数：3~5Years & USA";
    _workYear.font = [UIFont systemFontOfSize:12];
    _workYear.textAlignment = NSTextAlignmentLeft;
    _workYear.textColor = [UIColor colorWithHexString:@"#26bdab"];
    [_view addSubview:_workYear];
    //虚线
    _lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth-20, 1)];
    [_view addSubview:_lineView];
    [self drawDashLine:_lineView lineLength:5 lineSpacing:5 lineColor:RGB(230, 230, 230)];
    //图片标志
    _countyTag = [[UIImageView alloc]init];
    _countyTag.image = [UIImage imageNamed:@"county_photo"];
    
    [_view addSubview:_countyTag];
    //国家
    _countylable = [[UILabel alloc]init];
    _countylable.text = @"";
    _countylable.font = [UIFont systemFontOfSize:13];
    _countylable.textColor = [UIColor colorWithHexString:@"#26bdab"];
    [_view addSubview:_countylable];
    //lineView.backgroundColor = [UIColor redColor];
    //[self drawDashLine:lineView lineLength:10 lineSpacing:5 lineColor:[UIColor blackColor]];
    //认证标志
    //_certifybutton =
    _certifybutton = [[UILabel alloc]init];
    //btn1.frame = CGRectMake(100, 100, 100, 100);
   
    _certifybutton.layer.borderColor = [[UIColor  colorWithHexString:@"#ff9148"] CGColor];
    _certifybutton.layer.borderWidth = 1.0f;
    _certifybutton.layer.cornerRadius = 2;
    _certifybutton.clipsToBounds = YES;
    _certifybutton.font = [UIFont systemFontOfSize:12];
    _certifybutton.textAlignment = NSTextAlignmentCenter;
    _certifybutton.backgroundColor = [UIColor clearColor];
    _certifybutton.text = @"";
    
    [_certifybutton setTextColor:[UIColor  colorWithHexString:@"#ff9148"]];
    //[_certifybutton setTintColor:[UIColor redColor]];
    [_view addSubview:_certifybutton];
    //名字
    _nameText = [[UILabel alloc ]init];
    
    _nameText.text = @"jokecdcsscsdc";
    _nameText.textColor = [UIColor colorWithHexString:@"#434343"];
    _nameText.textAlignment = NSTextAlignmentLeft;
    _nameText.font = [UIFont systemFontOfSize:14];
   //[_nameText setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [_view addSubview:_nameText];
    //口号
    _sloganlable = [[UILabel alloc ]init];
    
    _sloganlable.text = @"jjjjjjfdscscsdcscdscscscdscdschdsgvdfkgvdfgvygtiuvhiurhvidufgvfhdjkgvd";
    _sloganlable.textColor = [UIColor colorWithHexString:@"#262626"];
    _sloganlable.numberOfLines = 0;
    _sloganlable.font = [UIFont systemFontOfSize:13];
    _sloganlable.textAlignment = NSTextAlignmentLeft;
    
    [_view addSubview:_sloganlable];
    //小橙点 和后面的文字
    _view1 = [[UIView alloc ]init];
    _view1.backgroundColor = [UIColor colorWithHexString:@"#ff9148"];
    _view1.layer.cornerRadius =3;
    [_view addSubview:_view1];
    _lable1 = [[UILabel alloc]init];
    _lable1.text = @"";
    _lable1.font = [UIFont systemFontOfSize:10];
    [_lable1 setTextColor:[UIColor colorWithHexString:@"#b3b3b3"]];
    [_view addSubview:_lable1];
    
    
    _view2 = [[UIView alloc ]init];
    _view2.backgroundColor = [UIColor  colorWithHexString:@"#ff9148"];
    _view2.layer.cornerRadius =3;
    [_view addSubview:_view2];
    _lable2 = [[UILabel alloc]init];
    _lable2.text = @"";
    _lable2.font = [UIFont systemFontOfSize:11];
    [_lable2 setTextColor:[UIColor colorWithHexString:@"#b3b3b3"]];
    [_view addSubview:_lable2];
    
    
    _view3 = [[UIView alloc ]init];
    _view3.backgroundColor = [UIColor  colorWithHexString:@"#ff9148"];
    _view3.layer.cornerRadius =3;
    [_view addSubview:_view3];
    _lable3 = [[UILabel alloc]init];
    _lable3.text = @"";
    _lable3.font = [UIFont systemFontOfSize:11];
    [_lable3 setTextColor:[UIColor colorWithHexString:@"#b3b3b3"]];
    [_view addSubview:_lable3];
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(9);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-11);
    }];
    [_workYear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_top).offset(10);
        make.left.mas_equalTo(_view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(180, 16));
    }];
    [_countyTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_top).offset(12);
        make.left.mas_equalTo(_workYear.mas_right).offset(15);
        //make.bottom.mas_equalTo(_workYear.mas_bottom).offset(2);
        make.size.mas_equalTo(CGSizeMake(9, 12));
    }];
    [_countylable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_workYear.mas_top);
        make.left.mas_equalTo(_countyTag.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(40, 16));
    }];
    [_certifybutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view.mas_top).offset(11);
        make.right.mas_equalTo(_view.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_workYear.mas_bottom).offset(10);
        make.left.mas_equalTo(_view.mas_left);
        make.right.mas_equalTo(_view.mas_right);
        make.height.mas_equalTo(4);
        //[self drawDashLine:lineView lineLength:10 lineSpacing:5 lineColor:[UIColor blackColor]];
        
    }];
    //[self drawDashLine:_lineView lineLength:10 lineSpacing:5 lineColor:[UIColor redColor]];
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(_workYear.mas_left);
       // make.size.mas_equalTo(CGSizeMake(60, 60));
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
    }];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lineView.mas_bottom).offset(10);
        make.left.mas_equalTo(_imageview.mas_right).offset(8);
        make.size.mas_equalTo(CGSizeMake(200, 17));
    }];
    [_sloganlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameText.mas_bottom).offset(4);
        make.left.mas_equalTo(_nameText.mas_left);
        make.right.mas_equalTo(_view.mas_right).offset(-10);
        make.height.mas_equalTo(48);
    }];
    [_view2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view1.mas_right).offset(60);
        make.centerY.mas_equalTo(_view1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    [_view3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view2.mas_right).offset(60);;
        make.centerY.mas_equalTo(_view1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    [_lable1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view1.mas_right).offset(5);;
        make.centerY.mas_equalTo(_view1.mas_centerY);
        make.right.mas_equalTo(_view2.mas_left);
        make.height.mas_equalTo(16);
    }];
    [_lable2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view2.mas_right).offset(5);;
        make.centerY.mas_equalTo(_view1.mas_centerY);
        make.right.mas_equalTo(_view3.mas_left);
        make.height.mas_equalTo(16);
        
    }];
    [_lable3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_view3.mas_right).offset(5);;
        make.centerY.mas_equalTo(_view1.mas_centerY);
        
        make.size.mas_equalTo(CGSizeMake(60, 16));
    }];
    
}

-(void)setline{
    _lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 35, kScreenWidth-20, 1)];
    [_view addSubview:_lineView];
    [self drawDashLine:_lineView lineLength:10 lineSpacing:5 lineColor:[UIColor grayColor]];
    
    
    
}
//绘制虚线的方法

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
