//
//  UGConsultHeadView.h
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvanceCounselorInfo.h"
typedef void (^ClickWenHaoBlock)();
@interface UGConsultHeadView : UIView
@property (strong,nonatomic) AdvanceCounselorInfo * advanceInfo;
@property(copy,nonatomic)ClickWenHaoBlock clickWenHaoBlock;
@end
