//
//  UGPayViewController.h
//  UrgooApp
//
//  Created by UrgooDev on 16/6/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HRSDK.h"  //此类为通用基础类，可在此接口中找到所有的需要调用的接口
#import "HRCallBackModel.h" //此类为回调类，要接受SDK的响应信息，要遵守协议

@interface UGPayViewController : BaseViewController<HRRespDelegate>

@property (copy,nonatomic) NSString * orderId;

@end
