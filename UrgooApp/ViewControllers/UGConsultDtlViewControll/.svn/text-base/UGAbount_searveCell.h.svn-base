//
//  UGAbount_searveCell.h
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
#import "ServiceLongListsModel.h"
#import "LableListssModel.h"
#import "WorkssModel.h"

typedef void(^isUpBlock)();

@interface UGAbount_searveCell : UITableViewCell
{
    CGFloat firstHeight;
}

@property (strong,nonatomic) UIView   *backGroundView;
@property (strong,nonatomic) UIButton *bottomButn;
@property (assign,nonatomic) BOOL      isUp;
@property (strong,nonatomic) isUpBlock isUpBlock;
@property (strong,nonatomic) NSMutableArray *isDownArr;
@property (strong,nonatomic) CounselorDetailssModel *counselorModel;
@property (strong,nonatomic) ExperienceListsModel   *experienceModel;
@property (strong,nonatomic) ServiceLongListsModel  *serviceModel;
@property (strong,nonatomic) LableListssModel       *lableModel;
@property (strong,nonatomic) WorkssModel            *WorksModel;

-(void)initUI:(CounselorDedailDataModel *)dataModel;

@end
