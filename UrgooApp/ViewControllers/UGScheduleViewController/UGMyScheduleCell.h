//
//  UGMyScheduleCell.h
//  UrgooApp
//
//  Created by UrgooDev on 16/6/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AdvanceTypeBlock)(NSString *type);

@interface UGMyScheduleCell : UICollectionViewCell

@property(strong,nonatomic) NSString * testlable;

@property(strong,nonatomic) AdvanceTypeBlock advanceTypeBlock;

@end
