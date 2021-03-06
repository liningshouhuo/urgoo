//
//  UGcounselorDetailHeardView.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGcounselorDetailHeardView.h"

@implementation UGcounselorDetailHeardView

-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        //[self initUI];
    }
    
    return self;
}

-(void)initUI:(NSArray *)subListArr detialModel:(CounselorDetailssModel *)detailmodel
{
    _counselorDetailssModel = detailmodel;
    imageUrlArray = [NSMutableArray array];
    typeArray = [NSMutableArray array];
    videoArr  = [NSMutableArray array];
    for (CounselorDetailSubListModel *subListModel in subListArr) {
        [imageUrlArray addObject:subListModel.url];
        [typeArray addObject:subListModel.type];
        [videoArr addObject:subListModel.videoPic];
    }
    
    //背景图片
    _backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 440)];
    //_backImageView.layer.borderWidth = 1;
    _backImageView.userInteractionEnabled = YES;
    _backImageView.clipsToBounds = YES;
    [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_backImageView];
    
    //轮播
    NSArray *imageArr = [NSArray array];;
    imageArr = imageUrlArray;
    if (imageArr.count < 1) {
        imageArr = @[@""];
    }
    _scrollsView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 310)];
    _scrollsView.contentSize = CGSizeMake(kScreenWidth*imageArr.count, 0);
    _scrollsView.pagingEnabled = YES;
    _scrollsView.delegate = self;
    _scrollsView.backgroundColor = RGB(238, 238, 238);
    _scrollsView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < imageArr.count; i ++) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, kScreenWidth, _scrollsView.height)];
        if ([StringHelper isUserIconContainHttp:imageArr[i]]) {
            [imageV sd_setImageWithURL:[NSURL URLWithString:imageArr[i]] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@%@",UG_HOST1,imageArr[i]];
            [imageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
        }
        imageV.layer.masksToBounds = YES;
        imageV.userInteractionEnabled = YES;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        
        if (typeArray.count > 0) {
            
            if ([typeArray[i] isEqualToString:@"1"]) {
                [imageV sd_setImageWithURL:[NSURL URLWithString:videoArr[i]] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
                
                UIImageView *video = [[UIImageView alloc] init];
                video.frame  = CGRectMake(0, 0, 50, 50);
                video.center = CGPointMake(imageV.centerX/kScreenWidth+kScreenWidth/2, imageV.centerY+10);
                video.image  = [UIImage imageNamed:@"icon_play_video2"];
                //[imageV addSubview:video];
            }

            
        }
        
        UIButton *touch = [UIButton buttonWithType:UIButtonTypeCustom];
        touch.frame = imageV.bounds;
        touch.tag = 200 + i;
        [touch addTarget:self action:@selector(tapTouchImage:) forControlEvents:UIControlEventTouchUpInside];
        [imageV addSubview:touch];
        
        [_scrollsView addSubview:imageV];
    }
    [_backImageView addSubview:_scrollsView];
    
    //page
    /*
    _pageControls = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _scrollsView.y+_scrollsView.height-15, kScreenWidth, 10)];
    _pageControls.numberOfPages = imageArr.count;
    _pageControls.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"26BDAB"];
    _pageControls.pageIndicatorTintColor = [UIColor whiteColor];
    [_pageControls addTarget:self action:@selector(pageConTrol:) forControlEvents:UIControlEventValueChanged];
    [_backImageView addSubview:_pageControls];
    */
    
    _pageControls = [[MyPageControl alloc] initWithFrame:CGRectMake(0, _scrollsView.y+_scrollsView.height-15, kScreenWidth, 10)];
    _pageControls.backgroundColor = [UIColor clearColor];
    _pageControls.numberOfPages = imageArr.count;
    _pageControls.currentPage = 0;
    [_pageControls addTarget:self action:@selector(pageConTrol:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControls];
     
    
    //收藏&分享
    if ([detailmodel.isAttention isEqualToString:@"1"]) {
        _isAttention = YES;
    }else{
        _isAttention = NO;
    }
    _saveButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveButn.frame = CGRectMake(kScreenWidth-110, _scrollsView.y+_scrollsView.height-20, 40, 40);
    _saveButn.layer.cornerRadius = 20;
    _saveButn.clipsToBounds = YES;
    _saveButn.selected = _isAttention;
    [_saveButn setBackgroundImage:[UIImage imageNamed:@"back_ground_circle"] forState:UIControlStateNormal];
    [_saveButn setImage:[UIImage imageNamed:@"cancle_save"] forState:UIControlStateNormal];
    [_saveButn setImage:[UIImage imageNamed:@"click_save2"] forState:UIControlStateSelected];
    [_saveButn addTarget:self action:@selector(saveButn:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_saveButn];
    
    UILabel *saveLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _saveButn.bottom, kScreenWidth/3, 10)];
    saveLable.center = CGPointMake(_saveButn.centerX, _saveButn.centerY+25);
    if (_isAttention) {
        saveLable.text = @"已关注";
    }else
    saveLable.text = @"关注";
    saveLable.textAlignment = NSTextAlignmentCenter;
    saveLable.textColor = [UIColor colorWithHexString:@"999999"];
    saveLable.font = [UIFont systemFontOfSize:7];
    [_backImageView addSubview:saveLable];
    
    _shareButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _shareButn.frame = CGRectMake(_saveButn.x+_saveButn.width+10, _saveButn.y, 40, 40);
    _shareButn.layer.cornerRadius = 20;
    _shareButn.clipsToBounds = YES;
    [_shareButn setBackgroundImage:[UIImage imageNamed:@"back_ground_circle"] forState:UIControlStateNormal];
    [_shareButn setImage:[UIImage imageNamed:@"click_share"] forState:UIControlStateNormal];
    [_shareButn addTarget:self action:@selector(shareButn:) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_shareButn];
    
    UILabel *shareLable = [[UILabel alloc] initWithFrame:CGRectMake(0, _saveButn.bottom, kScreenWidth/3, 10)];
    shareLable.center = CGPointMake(_shareButn.centerX, _shareButn.centerY+25);
    shareLable.text = @"分享";
    shareLable.textAlignment = NSTextAlignmentCenter;
    shareLable.textColor = [UIColor colorWithHexString:@"999999"];
    shareLable.font = [UIFont systemFontOfSize:7];
    [_backImageView addSubview:shareLable];
    
    _name = [[UILabel alloc] initWithFrame:CGRectMake(0, _scrollsView.bottom+10, kScreenWidth, 20)];
    _name.text = detailmodel.enName;
    _name.textColor = [UIColor colorWithHexString:@"000000"];
    _name.font = [UIFont systemFontOfSize:18];
    if (kScreenWidth<370) {
        _name.font = [UIFont systemFontOfSize:15];
    }
    _name.textAlignment = NSTextAlignmentCenter;
    [_backImageView addSubview:_name];
    
    //county_photo
    _country = [[UILabel alloc] init];
    _country.text = detailmodel.habitualResidence;

    _country.font = [UIFont systemFontOfSize:10];
    _countryImageV = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/2-_country.text.length*12/2-10, _name.bottom+5, 7, 10)];
    _countryImageV.image = [UIImage imageNamed:@"county_photo"];
    [_backImageView addSubview:_countryImageV];
    
    _country.frame = CGRectMake(_countryImageV.x+_countryImageV.width+5, _name.bottom+5, kScreenWidth/2, 10);
    [_backImageView addSubview:_country];
    
    //口号
    _note = [[UILabel alloc] initWithFrame:CGRectMake(10, _country.bottom +5, kScreenWidth-20, 35)];
    _note.font = [UIFont systemFontOfSize:13];
    _note.numberOfLines = 2;
    _note.textColor = [UIColor colorWithHexString:@"666666"];
    _note.textAlignment = NSTextAlignmentCenter;
    _note.text = detailmodel.slogan;
    [_backImageView addSubview:_note];
    
    //分割线
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(20, _note.bottom+7, kScreenWidth-40, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backImageView addSubview:line];
    
    
    //三详情
    NSArray *titleArray = @[detailmodel.advanceCount,detailmodel.counselorReadCount,detailmodel.attentionCount];
    NSArray *titledetil = @[@"人已预约",@"人已看过",@"人已关注"];
    NSArray *imageArray = @[@"ccccccTime",@"ccccccChat2",@"ccccccSave"];
    for (int i = 0; i < 3; i++) {
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(20+kScreenWidth/3*i, line.y+12, 15, 15)];
        imageV.image = [UIImage imageNamed:imageArray[i]];
        [_backImageView addSubview:imageV];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(40+kScreenWidth/3*i, line.y+12, kScreenWidth/3, 15)];
        title.text = [NSString stringWithFormat:@"%@%@",titleArray[i],titledetil[i]];
        title.font = [UIFont systemFontOfSize:9];
        title.textColor = [UIColor colorWithHexString:@"cccccc"];
        [_backImageView addSubview:title];
        
        if (i == 1) {
            imageV.frame = CGRectMake(20+kScreenWidth/3*i, line.y+14, 15, 10);
        }
        
    }
    
}

//收藏
-(void)saveButn:(UIButton *)button
{
    NSLog(@"***点击收藏***");
    if (button.isSelected) {
        _saveButn.selected = NO;
    }else{
        _saveButn.selected = YES;
    }
   
    _attentionBlock(button.isSelected);
}

//分享
-(void)shareButn:(UIButton *)button
{
    NSLog(@"***点击分享***");
    if (_shareBlock) {
        _shareBlock();
    }
}

//点击图片
-(void)tapTouchImage:(UIButton *)butn
{
    DLog(@"***点击第%ld图片***",butn.tag-200);
    if (imageUrlArray.count > 0) {
        
        NSString *type = typeArray[butn.tag - 200];
        NSString *url  = imageUrlArray[butn.tag - 200];
        NSInteger butnTag = butn.tag - 200;
        if ([type isEqualToString:@"1"]) {
            _videoBlock(url,butnTag,_counselorDetailssModel);
        }else{
            _videoBlock(nil,butnTag,_counselorDetailssModel);
        }
        
    }
}

//page
-(void)pageConTrol:(UIPageControl *)page
{
    CGPoint p = {[page currentPage]*kScreenWidth,0};
    [_scrollsView setContentOffset:p animated:YES];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControls.currentPage = index;
}

@end
