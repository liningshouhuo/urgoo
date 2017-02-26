//
//  UGServeDtlViewController.h
//  UrgooApp
//
//  Created by UrgooDev on 16/8/11.
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
#import "CounselorDedailDataModel.h"
typedef void(^isUpBlock)();
@interface UGServeDtlViewController : BaseViewController
{
    CGFloat firstHeight;
}

@property (strong,nonatomic) UIScrollView   *backGroundView;
@property (strong,nonatomic) UIButton *bottomButn;
@property (assign,nonatomic) BOOL      isUp;
@property (strong,nonatomic) isUpBlock isUpBlock;
@property (strong,nonatomic) NSMutableArray *isDownArr;
@property (strong,nonatomic) CounselorDetailssModel *counselorModel;
@property (strong,nonatomic) ExperienceListsModel   *experienceModel;
@property (strong,nonatomic) ServiceLongListsModel  *serviceModel;
@property (strong,nonatomic) LableListssModel       *lableModel;
@property (strong,nonatomic) WorkssModel            *WorksModel;
@property (strong,nonatomic) NSString *  expectStr;


@property (strong,nonatomic) NSString * serviceType;
@property (strong,nonatomic) NSString * grade;
@property (strong,nonatomic) NSString * counselorId;
@property (strong,nonatomic) NSString * serviceid;
@property (strong,nonatomic) CounselorDedailDataModel * dataModel;



@end
