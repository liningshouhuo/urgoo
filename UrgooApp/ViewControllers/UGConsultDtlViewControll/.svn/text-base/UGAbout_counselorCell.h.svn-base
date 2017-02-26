//
//  UGAbout_counselorCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"
#import "CounselorDedailDataModel.h"
#import "CounselorDetailssModel.h"
#import "ExperienceListsModel.h"
#import "WorkssModel.h"
#import "LableListssModel.h"
#import "EduListsModel.h"

typedef void(^IsUpBlock)();
typedef void(^VideoLiveBlock)();
typedef void(^MoreWorksBlock)(NSString *counselorId);
typedef void(^VideoDetialBlock)(NSString *liveId);

@interface UGAbout_counselorCell : UITableViewCell
{
    CGFloat firstHeight;
    
    UILabel *success;
    UILabel *tranSuccess;
    UILabel *hope;
    UILabel *tranHope;
    UILabel *works;
    UILabel *worksDetail;
}

@property (strong,nonatomic) UIView   *backImageView;
@property (strong,nonatomic) UIButton *moreButn;
@property (strong,nonatomic) UIButton *bottomButn;
@property (strong,nonatomic) UIButton *videoButn;
@property (assign,nonatomic) BOOL       isUp;
@property (strong,nonatomic) IsUpBlock  isUpBlock;
@property (strong,nonatomic) VideoLiveBlock   videoBlock;
@property (strong,nonatomic) MoreWorksBlock   moreWorksBlock;
@property (strong,nonatomic) VideoDetialBlock videoDetialBlock;
@property (strong,nonatomic) CounselorDetailssModel *counselorModel;
@property (strong,nonatomic) WorkssModel *workssModel;
@property (strong,nonatomic) LableListssModel *lableListModel;

-(void)initUI:(CounselorDedailDataModel *)dataModel;

@end
