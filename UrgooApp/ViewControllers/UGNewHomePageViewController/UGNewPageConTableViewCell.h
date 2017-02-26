//
//  UGNewPageConTableViewCell.h
//  UrgooApp
//
//  Created by UrgooDev on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CounselorListModel.h"

@interface UGNewPageConTableViewCell : UITableViewCell
@property (strong,nonatomic) CounselorListModel * ListModel;
@property (nonatomic,assign) CGFloat totleHight;

@end
