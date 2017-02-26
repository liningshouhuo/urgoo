//
//  BasicInfomationViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"

@interface BasicInfomationViewController : BaseViewController


//编辑信息页面可以从进入的时候来，也可以从我的页面的编辑信息来，这里做一个判断
@property(assign,nonatomic)NSInteger fromType;

@end
