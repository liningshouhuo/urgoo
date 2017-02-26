//
//  UGcounselorDetailHeardView.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageControl.h"
#import "CounselorDetailSubListModel.h"
#import "CounselorDetailssModel.h"

typedef void(^VideoBlock)(NSString *url,NSInteger butnTag,CounselorDetailssModel *model);
typedef void(^AttentionBlock)(BOOL selectButn);
typedef void(^ShareBlock)();

@interface UGcounselorDetailHeardView : UIView<UIScrollViewDelegate>
{
    NSMutableArray *imageUrlArray;
    NSMutableArray *typeArray;
    NSMutableArray *videoArr;
}

@property(strong,nonatomic)UIImageView *backImageView; //背景图片
@property(strong,nonatomic)MyPageControl *pageControls;
@property(strong,nonatomic)UIScrollView *scrollsView; //
@property(strong,nonatomic)UIButton *saveButn;//收藏,分享
@property(strong,nonatomic)UIButton *shareButn;
@property(strong,nonatomic)UILabel *saveNum;
@property(strong,nonatomic)UILabel *name;
@property(strong,nonatomic)UILabel *country;
@property(strong,nonatomic)UILabel *note;
@property(strong,nonatomic)UIImageView *countryImageV;
@property(assign,nonatomic)BOOL isAttention;

@property (strong,nonatomic) VideoBlock videoBlock;
@property (strong,nonatomic) AttentionBlock attentionBlock;
@property (strong,nonatomic) ShareBlock shareBlock;
@property (strong,nonatomic) CounselorDetailssModel *counselorDetailssModel;


-(void)initUI:(NSArray *)subListArr detialModel:(CounselorDetailssModel *)detailmodel;

@end
