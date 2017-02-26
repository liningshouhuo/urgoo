//
//  UGCommanControl.h
//  UrgooApp
//
//  Created by admin on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SureBlock)();
typedef void(^CancelBlock)();

@interface UGCommanControl : NSObject

+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title
                                              message:(NSString *)message;



+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                                 sure:(SureBlock)sure
                                               cancel:(CancelBlock)cancel;

@end
