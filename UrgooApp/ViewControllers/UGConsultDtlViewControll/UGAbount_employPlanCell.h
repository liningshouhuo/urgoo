//
//  UGAbount_employPlanCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"

typedef void(^ChatUBaoBlock)();

@interface UGAbount_employPlanCell : UITableViewCell

@property (strong,nonatomic) UIView   *backGroundView;
@property (strong,nonatomic) UIButton *chatButn;
@property (strong,nonatomic) ChatUBaoBlock chatUBaoBlock;

-(void)initUI;

@end
