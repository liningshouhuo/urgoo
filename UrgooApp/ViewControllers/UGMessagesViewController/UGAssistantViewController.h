//
//  UGAssistantViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"

@interface UGAssistantViewController : BaseViewController

@property (nonatomic,copy) NSString *isJPush;

-(void)getNet_InformationData_system:(int)page;//系统消息
-(void)getNet_InformationData_task:(int)page;//task消息
-(void)getNet_InformationData_account:(int)page;//account消息

@end
