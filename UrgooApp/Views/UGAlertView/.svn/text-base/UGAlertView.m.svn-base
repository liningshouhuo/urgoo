//
//  UGAlertView.m
//  UrgooApp
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAlertView.h"

@implementation UGAlertView

+(void)showAlert:(NSString*)content{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Tips" message:content delegate:self cancelButtonTitle:@"Sure" otherButtonTitles: nil];
    [alertView show];
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    [alertView show];
}

+(void)showAlert:(NSString*)content cancelTitle:(NSString*)title delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:content delegate:self cancelButtonTitle:title otherButtonTitles: nil];
    alertView.delegate = delegate;
    [alertView show];
}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:content message:title delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    [alertView show];
}

+(void)showAlert:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate viewTag:(NSInteger)viewTag
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.tag = viewTag;
    [alertView show];
}

+(void)showAlertWithInputNumView:(NSString*)content title:(NSString*)title cancleTitle:(NSString*)cancleTitle okTitle:(NSString*)okTitle delegate:(id)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:content delegate:self cancelButtonTitle:cancleTitle otherButtonTitles:okTitle, nil];
    alertView.delegate = delegate;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

@end
