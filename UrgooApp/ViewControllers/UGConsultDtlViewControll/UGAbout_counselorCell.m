//
//  UGAbout_counselorCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAbout_counselorCell.h"

static CGFloat heightOne;
static CGFloat heightOneOne;
static CGFloat heightTwo;
static CGFloat heightThree;

@implementation UGAbout_counselorCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);//f7f7f7
        //[self initUI];
    }
    return self;
}

-(void)clickVideoButn
{
    if (_videoDetialBlock) {
        _videoDetialBlock(_counselorModel.liveId);
    }
}

-(void)initUI:(CounselorDedailDataModel *)dataModel
{
    _counselorModel = dataModel.counselorDetail;
    
    _backImageView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 980)];
    _backImageView.backgroundColor = [UIColor whiteColor];
    _backImageView.layer.cornerRadius = 8;
    _backImageView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    _backImageView.clipsToBounds = YES;
    [self.contentView addSubview:_backImageView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _backImageView.width, 36)];
    title.text = @"关于顾问";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"000000"];
    title.textAlignment = NSTextAlignmentCenter;
    [_backImageView addSubview:title];
    
    _videoButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoButn.frame = CGRectMake(_backImageView.width-80-25, title.bottom+5, 80, 15);
    _videoButn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_videoButn setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
    [_videoButn setImage:[UIImage imageNamed:@"click_arror_more"] forState:UIControlStateNormal];
    [_videoButn setTitle:@"查看他的直播" forState:UIControlStateNormal];
    [_videoButn setImageEdgeInsets:UIEdgeInsetsMake(5, 70, 5, 0)];
    [_videoButn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_videoButn addTarget:self action:@selector(clickVideoButn) forControlEvents:UIControlEventTouchUpInside];
    if (_counselorModel.liveId.length > 0) {
        [_backImageView addSubview:_videoButn];
    }
    
    
    //分割线
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, title.height, _backImageView.width, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backImageView addSubview:line];
    
    //基本资料
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, title.bottom+5, 100, 15)];
    lable1.text = @"基本资料:";
    lable1.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable1.textColor = [UIColor colorWithHexString:@"000000"];
    [_backImageView addSubview:lable1];
    
    NSArray *dataArr = [NSArray array];
    NSArray *dataDetil = [NSArray array];
    if (_counselorModel.organization.length > 0) {
        dataArr = @[@"国籍："
                    ,@"学历："
                    ,@"工作经验："
                    ,@"资格认证："
                    ,@"指导方式："
                    ,@"毕业院校："];
        dataDetil = @[_counselorModel.countyName,_counselorModel.levelEducation,_counselorModel.workYear,_counselorModel.organization,[NSString stringWithFormat:@"远程指导  %@",_counselorModel.serviceMode],@""];
    } else {
        dataArr = @[@"国籍："
                    ,@"学历："
                    ,@"工作经验："
                    ,@"指导方式："
                    ,@"毕业院校："];
        dataDetil = @[_counselorModel.countyName,_counselorModel.levelEducation,_counselorModel.workYear,[NSString stringWithFormat:@"远程指导  %@",_counselorModel.serviceMode],@""];
    }
    
    for (int i = 0; i < dataArr.count; i ++) {
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(20, lable1.bottom+i*18+9, _backImageView.width-40, 15)];
        lable.text = dataArr[i];
        NSString *lenthStr = dataDetil[i];
        lable.font = [UIFont systemFontOfSize:13];
        
        lable.textColor = [UIColor colorWithHexString:@"000000"];
        [lable changLableTextColorFromNote:@"：" text:[NSString stringWithFormat:@"%@%@",dataArr[i],dataDetil[i]] colorLength:lenthStr.length color:[UIColor colorWithHexString:@"666666"]];
       /*
        if (i == dataArr.count - 1) {
            lable.frame = CGRectMake(20, lable1.bottom+i*18+7, _backImageView.width-40, 35);
            lable.numberOfLines = 2;
            [lable changLableTextColorFromNote:@"：" text:[NSString stringWithFormat:@"%@\n%@",dataArr[i],dataDetil[i]] colorLength:lenthStr.length+1 color:[UIColor colorWithHexString:@"666666"]];
            heightOne = lable.bottom;
        }
        */
        heightOne = lable.bottom;
        [_backImageView addSubview:lable];
        
    }
    //毕业院校
    NSArray *eduList = dataModel.eduList;
    NSMutableArray *schoolArr = [NSMutableArray array];
    NSMutableArray *schTimeArr = [NSMutableArray array];
    for (EduListsModel *Model in eduList) {
        [schoolArr addObject:Model.educationName];
        [schoolArr addObject:Model.major];
        NSString *time = [NSString stringWithFormat:@"%@-%@",Model.startTime,Model.endTime];
        [schTimeArr addObject:time];
    }
    
    if (schTimeArr.count < 1) {
        heightOneOne = heightOne+7;
    }
    
    for (int i = 0; i < schTimeArr.count; i ++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(20, heightOne+7+i*38 , _backImageView.width-40, 0.5)];
        [_backImageView addSubview:view];
        if (i != 0) {
            [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"d4d4d4"]];
        }
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(20, heightOne+30+i*38, _backImageView.width-40, 13)];
        time.text = schTimeArr[i];
        time.textColor = [UIColor colorWithHexString:@"999999"];
        time.font = [UIFont systemFontOfSize:10];
        time.textAlignment = NSTextAlignmentRight;
        [_backImageView addSubview:time];
        
        heightOneOne = time.bottom;
    }
    for (int i = 0; i < schoolArr.count; i ++) {
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(20, heightOne+10+i*19, _backImageView.width-25, 15)];
        work.text = schoolArr[i];
        work.textColor = [UIColor colorWithHexString:@"999999"];
        work.font = [UIFont systemFontOfSize:13];
        [_backImageView addSubview:work];
    }
    
    
    
    //工作经历
    NSArray *experienceList = dataModel.experienceList;
    NSMutableArray *nameArr = [NSMutableArray array];
    NSMutableArray *timeArr = [NSMutableArray array];
    for (ExperienceListsModel *experienceModel in experienceList) {
        [nameArr addObject:experienceModel.companyName];
        [nameArr addObject:experienceModel.position];
        NSString *time = [NSString stringWithFormat:@"%@-%@",experienceModel.startDate,experienceModel.endDate];
        [timeArr addObject:time];
    }
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20, heightOneOne+30, 100, 15)];
    lable2.text = @"工作经历:";
    lable2.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable2.textColor = [UIColor colorWithHexString:@"000000"];
    [_backImageView addSubview:lable2];
    
    /*
    NSArray *workName = @[@"Townsend Hrris High School,Flushing,New York"
                          ,@"教导主任"
                          ,@"STuyvesant High School,New York"
                          ,@"教导主任"
                          ];
    NSArray *workTime   = @[@"2015.09-now",@"2011.11-2015.09"];
     */
    NSArray *workName = nameArr;
    NSArray *workTime = timeArr;
    if (workName.count == 0) {
        //lable2.frame = CGRectMake(20, heightOne+30, 100, 0);
        heightTwo = lable2.bottom;
    }
    for (int i = 0; i < workTime.count; i ++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(lable2.x, lable2.bottom+7+i*38 , _backImageView.width-40, 0.5)];
        [_backImageView addSubview:view];
        if (i != 0) {
            [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"d4d4d4"]];
        }
        
        UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(lable2.x, lable2.bottom+30+i*38, _backImageView.width-40, 13)];
        time.text = workTime[i];
        time.textColor = [UIColor colorWithHexString:@"999999"];
        time.font = [UIFont systemFontOfSize:10];
        time.textAlignment = NSTextAlignmentRight;
        [_backImageView addSubview:time];
        
        heightTwo = time.bottom;
    }
    
    for (int i = 0; i < workName.count; i ++) {
        
        UILabel *work = [[UILabel alloc] initWithFrame:CGRectMake(lable2.x, lable2.bottom+10+i*19, _backImageView.width-40, 15)];
        work.text = workName[i];
        work.textColor = [UIColor colorWithHexString:@"999999"];
        work.font = [UIFont systemFontOfSize:13];
        [_backImageView addSubview:work];
    }
    
    
    //顾问介绍
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(20, heightTwo+30, 100, 15)];
    lable3.text = @"顾问介绍:";
    lable3.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable3.textColor = [UIColor colorWithHexString:@"000000"];
    [_backImageView addSubview:lable3];
    
    NSString *introduceStr = _counselorModel.selfBio;
    UILabel *introduce = [[UILabel alloc] initWithFrame:CGRectMake(20, lable3.bottom, _backImageView.width-40, 10)];
    introduce.textColor = [UIColor colorWithHexString:@"666666"];
    [introduce heightForLableText:introduceStr fontOfSize:13 frame:introduce.frame];
    [_backImageView addSubview:introduce];
    
    UILabel *translation = [[UILabel alloc] init];
    if (_counselorModel.selfBioTranz.length > 0) {
        NSString *translationStr = [NSString stringWithFormat:@"友情翻译：%@", _counselorModel.selfBioTranz];
        translation.frame = CGRectMake(20, introduce.bottom-5, _backImageView.width-40, 10);
        translation.textColor = [UIColor colorWithHexString:@"aaaaaa"];
        [translation heightForLableText:translationStr fontOfSize:11 frame:translation.frame];
        [translation changLableTextColorToNote:@"：" text:translationStr colorLength:5 color:[UIColor colorWithHexString:@"26BDAB"]];
        [_backImageView addSubview:translation];
        
    }else{
        translation.frame = CGRectMake(20, introduce.bottom-5, _backImageView.width-40, 0);
    }
    
    
    
    
    //成功案例 (注意)
    NSString *successCase = _counselorModel.successCase;
    NSString *successCaseTranz = _counselorModel.successCaseTranz;
    
    UILabel *lable4 = [[UILabel alloc] initWithFrame:CGRectMake(20, translation.bottom+20, 100, 15)];
    success = [[UILabel alloc] initWithFrame:CGRectMake(20, lable4.bottom, _backImageView.width-40, 10)];
    tranSuccess = [[UILabel alloc] init];
    if (successCase.length > 1) {
        
        lable4.text = @"成功案例:";
        lable4.font = [UIFont systemFontOfSize:15 weight:0.1];
        lable4.textColor = [UIColor colorWithHexString:@"000000"];
        [_backImageView addSubview:lable4];
        
        NSString *successStr = successCase;
        //success = [[UILabel alloc] initWithFrame:CGRectMake(20, lable4.bottom, _backImageView.width-40, 10)];
        success.textColor = [UIColor colorWithHexString:@"666666"];
        [success heightForLableText:successStr fontOfSize:13 frame:success.frame];
        [_backImageView addSubview:success];
        
        
        if (successCaseTranz.length > 0) {
            NSString *tranSuccessStr = [NSString stringWithFormat:@"友情翻译：%@", successCaseTranz];
            //tranSuccess = [[UILabel alloc] init];
            tranSuccess.frame = CGRectMake(20, success.bottom-5, _backImageView.width-40, 10);
            tranSuccess.textColor = [UIColor colorWithHexString:@"aaaaaa"];
            [tranSuccess heightForLableText:tranSuccessStr fontOfSize:11 frame:tranSuccess.frame];
            [tranSuccess changLableTextColorToNote:@"：" text:tranSuccessStr colorLength:5 color:[UIColor colorWithHexString:@"26BDAB"]];
            [_backImageView addSubview:tranSuccess];
        }else{
            tranSuccess.frame = CGRectMake(20, success.bottom-5, _backImageView.width-40, 0);
        }

    }else{
        lable4.frame = CGRectMake(20, translation.bottom+20, 100, 0);
        success.frame = CGRectMake(20, lable4.bottom, _backImageView.width-40, 0);
        tranSuccess.frame = CGRectMake(20, success.bottom-5, _backImageView.width-40, 0);
    }
    
    
    
    NSString *requires = _counselorModel.requires;
    NSString *requiresTranz = _counselorModel.requiresTranz;
    //对学生和家长的期望
    UILabel *lable5 = [[UILabel alloc] initWithFrame:CGRectMake(20, tranSuccess.bottom+20, 200, 15)];
    hope = [[UILabel alloc] initWithFrame:CGRectMake(20, lable5.bottom, _backImageView.width-40, 10)];
    tranHope = [[UILabel alloc] init];
    if (requires.length > 0) {
        
        lable5.text = @"对学生和家长的期望:";
        lable5.font = [UIFont systemFontOfSize:15 weight:0.1];
        lable5.textColor = [UIColor colorWithHexString:@"000000"];
        [_backImageView addSubview:lable5];
        
        NSString *hopeStr = requires;
        //hope = [[UILabel alloc] initWithFrame:CGRectMake(20, lable5.bottom, _backImageView.width-40, 10)];
        hope.textColor = [UIColor colorWithHexString:@"666666"];
        [hope heightForLableText:hopeStr fontOfSize:13 frame:hope.frame];
        [_backImageView addSubview:hope];
        
        
        if (requiresTranz.length > 0) {
            NSString *tranHopeStr = [NSString stringWithFormat:@"友情翻译：%@", requiresTranz];
            //tranHope = [[UILabel alloc] init];
            tranHope.frame = CGRectMake(20, hope.bottom-5, _backImageView.width-40, 10);
            tranHope.textColor = [UIColor colorWithHexString:@"aaaaaa"];
            [tranHope heightForLableText:tranHopeStr fontOfSize:11 frame:tranHope.frame];
            [tranHope changLableTextColorToNote:@"：" text:tranHopeStr colorLength:5 color:[UIColor colorWithHexString:@"26BDAB"]];
            [_backImageView addSubview:tranHope];
        }else{
            tranHope.frame = CGRectMake(20, hope.bottom-5, _backImageView.width-40, 0);
        }
        
    }else{
        lable5.frame = CGRectMake(20, tranSuccess.bottom+20, 200, 0);
        hope.frame = CGRectMake(20, lable5.bottom, _backImageView.width-40, 0);
        tranHope.frame = CGRectMake(20, hope.bottom-5, _backImageView.width-40, 0);
    }
    
    
    
    
    
    
    
    //顾问作品
    NSArray *worksArr = dataModel.works;
    
    UILabel *lable6 = [[UILabel alloc] initWithFrame:CGRectMake(20, tranHope.bottom+20, 200, 15)];
    lable6.text = @"顾问作品:";
    lable6.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable6.textColor = [UIColor colorWithHexString:@"000000"];
    [_backImageView addSubview:lable6];
    
    _moreButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButn.frame = CGRectMake(_backImageView.width-50, lable6.y-5, 40, 20);
    _moreButn.titleLabel.font = [UIFont systemFontOfSize:12];
    _moreButn.titleLabel.textColor = [UIColor whiteColor];
    _moreButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    _moreButn.layer.cornerRadius = 6;
    _moreButn.layer.masksToBounds = YES;
    [_moreButn setTitle:@"更多" forState:UIControlStateNormal];
    [_moreButn addTarget:self action:@selector(clickMoreButn) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_moreButn];
    
    works = [[UILabel alloc] init];
    worksDetail = [[UILabel alloc] init];
    if (worksArr.count > 0) {
        _workssModel = worksArr[0];
        
        UIImageView *dot = [[UIImageView alloc] init];
        dot.frame = CGRectMake(20, lable6.bottom+12, 4, 4);
        dot.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        dot.layer.cornerRadius = 2;
        dot.clipsToBounds = YES;
        [_backImageView addSubview:dot];
        
        NSString *worksStr = _workssModel.title;
        works.frame = CGRectMake(30, lable6.bottom+6, _backImageView.width-40, 14);
        works.text = worksStr;
        works.font = [UIFont systemFontOfSize:13];
        works.textColor = [UIColor colorWithHexString:@"666666"];
        [_backImageView addSubview:works];
        
        NSString *worksDetailStr = _workssModel.content;
        worksDetail.frame = CGRectMake(30, works.bottom, _backImageView.width-40, 30);
        worksDetail.text = worksDetailStr;
        worksDetail.numberOfLines = 2;
        worksDetail.font = [UIFont systemFontOfSize:11];
        worksDetail.textColor = [UIColor colorWithHexString:@"aaaaaa"];
        [_backImageView addSubview:worksDetail];
        
    }else{
        lable6.frame = CGRectMake(20, tranHope.bottom+20, 200, 0);
        [_moreButn removeFromSuperview];
         works.frame = CGRectMake(30, lable6.bottom+6, _backImageView.width-40, 0);
        worksDetail.frame = CGRectMake(30, works.bottom, _backImageView.width-40, 0);
    }
    
    
    
    NSArray *lableArr = dataModel.labelList;
    NSMutableArray *lableArray = [NSMutableArray array];
    for (LableListssModel *model in lableArr) {
        if (model.lableCnName) {
            [lableArray addObject:model.lableCnName];
        }
    }
    heightThree = worksDetail.bottom +25;
    
    int width = 0;
    int height = 0;
    int number = 0;
    int han = 0;
    NSArray *titleArr = lableArray;
    for (int i = 0; i < titleArr.count; i++) {
        
        UILabel *lable = [[UILabel alloc] init];
        
        CGSize titleSize = [StringHelper getSizeByString:titleArr[i] AndFontSize:15];
        han = han +titleSize.width;
        if (han > _backImageView.width-40) {
            han = 0;
            han = han + titleSize.width;
            height++;
            width = 0;
            width = width+titleSize.width;
            number = 0;
            lable.frame = CGRectMake(20, worksDetail.bottom+10 +22*height, titleSize.width, 17);
        }else{
            lable.frame = CGRectMake(width+20+(number*10), worksDetail.bottom+10 +22*height, titleSize.width, 17);
            width = width+titleSize.width;
        }
        number++;
        lable.font = [UIFont systemFontOfSize:12];
        lable.layer.masksToBounds = YES;
        lable.layer.cornerRadius = 8;
        lable.layer.borderColor = [UIColor colorWithHexString:@"26BDAB"].CGColor;
        lable.layer.borderWidth = 0.6;
        lable.text = titleArr[i];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor colorWithHexString:@"26BDAB"];
        [_backImageView addSubview:lable];
        
        heightThree = lable.bottom + 15;
    }
    
    
    
    if (![User_Default objectForKey:@"IsUp"]) {
        _isUp = YES;
        firstHeight = 300;
    }else{
        firstHeight = heightThree;
        _isUp = NO;
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.frame = CGRectMake(0, firstHeight, _backImageView.width, 0.6);
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backImageView addSubview:bottomLine];
    
    UIView *buttonG = [[UIView alloc] init];
    buttonG.frame = CGRectMake(0, firstHeight+1, _backImageView.width, 36);
    buttonG.backgroundColor = [UIColor whiteColor];
    [_backImageView addSubview:buttonG];
    
    _bottomButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButn.frame = CGRectMake(0, firstHeight, _backImageView.width, 36);
    if (_isUp) {
        [_bottomButn.layer addAnimation:[self animation] forKey:nil];
        [_bottomButn setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
    }else{
        [_bottomButn.layer addAnimation:[self animation] forKey:nil];
        [_bottomButn setImage:[UIImage imageNamed:@"icon_up_arrow"] forState:UIControlStateNormal];
    }
    [_bottomButn addTarget:self action:@selector(clickBottomButn) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_bottomButn];
    
    
    _backImageView.frame = CGRectMake(10, 10, kScreenWidth-20, _bottomButn.bottom);
    
    CGRect frame = self.frame;
    frame.size.height = _bottomButn.bottom + 20;
    self.frame = frame;
    
}

-(void)clickMoreButn
{
    _moreWorksBlock(_counselorModel.counselorId);
}

-(void)clickBottomButn
{
    if (_isUp) {
        [User_Default setObject:@"IsUp" forKey:@"IsUp"];
        [User_Default synchronize];
    }else{
        [User_Default removeObjectForKey:@"IsUp"];
    }
    _isUpBlock();
}


-(CABasicAnimation *)animation
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(90, 0, 0, 0.5);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = 0.2;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    return animation;
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
