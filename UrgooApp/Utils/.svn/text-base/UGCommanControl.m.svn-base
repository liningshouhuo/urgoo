//
//  UGCommanControl.m
//  UrgooApp
//
//  Created by admin on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCommanControl.h"

@implementation UGCommanControl

//创建UIAlterController
+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alterAction = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    [alterController addAction:alterAction];
    return alterController;
}
+ (UIAlertController *)commonAlterControllerWithTitle:(NSString *)title
                                              message:(NSString *)message
                                                 sure:(SureBlock)sure
                                               cancel:(CancelBlock)cancel{
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            sure();
                                                        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                          style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            cancel();
                                                        }];
    
    
    [alterController addAction:sureAction];
    [alterController addAction:cancelAction];

    return alterController;
    
}



@end
