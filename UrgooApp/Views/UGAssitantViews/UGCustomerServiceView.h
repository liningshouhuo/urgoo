//
//  UGCustomerServiceView.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CustomerServiceBlock)();

@interface UGCustomerServiceView : UIView
@property(strong,nonatomic)UITextView *detailTextView;
@property(copy,nonatomic)CustomerServiceBlock block;
@property(strong,nonatomic) NSString * nameText;
-(void)initUI;
@end
