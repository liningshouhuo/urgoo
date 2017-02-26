//
//  UGPickerView.h
//  UrgooApp
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface UGPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate> 
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIPickerView *pv;
@property(nonatomic,copy)NSString *chooseType;

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr;
- (void)reloadData;


@end
