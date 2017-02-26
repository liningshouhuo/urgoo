//
//  SeaveNewHeadView.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanHeaderModel.h"
#import "PlanDataModel.h"

typedef void(^TypeBlock)(NSString *type,NSString *title);
typedef void(^ReportBlock)(NSString *reportId);

@interface SeaveNewHeadView : UIView
{
    NSArray *titles;
}

@property (nonatomic, strong) UIView *backGroundV;
@property (nonatomic, strong) UILabel  *title;
@property (nonatomic, strong) UIButton *reportButn;
@property (nonatomic, strong) TypeBlock typeBlock;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) ReportBlock     reportBlock;
@property (nonatomic, strong) NSString       *reportId;

-(void)initUI:(PlanDataModel *)planDataModel;

@end
