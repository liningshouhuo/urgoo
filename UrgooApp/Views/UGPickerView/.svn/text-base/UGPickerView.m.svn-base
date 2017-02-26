//
//  UGPickerView.m
//  UrgooApp
//
//  Created by admin on 16/3/4.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGPickerView.h"

@implementation UGPickerView

-(instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr
{
    if (self = [super initWithFrame:frame]) {
        
        if (self.titleArray.count  > 0 ) {
            self.chooseType = self.titleArray[0];
        }
        
        [self createMyPickerView];
    }
    return self;
    
}



- (void)reloadData {
    [_pv reloadAllComponents];
}

- (void)createMyPickerView {
    _pv = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _pv.delegate = self;
    _pv.dataSource = self;
    _pv.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self addSubview:_pv];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _titleArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}



- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    label.text = _titleArray[row];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithHexString:@"4c4c4c"];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.chooseType = _titleArray[row];
}


@end
