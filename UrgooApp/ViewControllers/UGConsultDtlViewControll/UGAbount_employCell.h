//
//  UGAbount_employCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EmployServiceModel.h"
#import "CounselorDetailssModel.h"

typedef void(^EmplyBlock)(EmployServiceModel *employServiceModel);

@interface UGAbount_employCell : UITableViewCell

@property (strong,nonatomic) UIView   *backGroundView;
@property (strong,nonatomic) NSMutableArray   *serviceIdArr;
@property (strong,nonatomic) EmplyBlock emplyBlock;
@property (nonatomic,strong) EmployServiceModel *employServiceModel;

@property (strong,nonatomic) NSArray * employArray;
-(void)initUI:(NSArray *)employArr CounselorDetailModel:(CounselorDetailssModel *)model;

@end
