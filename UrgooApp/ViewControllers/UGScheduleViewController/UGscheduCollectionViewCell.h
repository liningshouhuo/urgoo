//
//  UGscheduCollectionViewCell.h
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceDateList.h"
@interface UGscheduCollectionViewCell : UICollectionViewCell
@property (assign,nonatomic) NSInteger cellIndex;
@property(strong,nonatomic) NSString * testlable;
@property(strong,nonatomic) NSString * dateWeek;
@property (assign,nonatomic) int addbuttonIndex;
@property (strong,nonatomic) AdvanceDateList * dateListmodel;
@property (strong,nonatomic) NSMutableArray * buttonIndexArray;
@property (strong,nonatomic) NSMutableArray * indexpathArray;
@property (strong,nonatomic) NSMutableArray * btnarray_last;
@end
