//
//  UGSystemViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"
#import "UGAssistantViewController.h"
typedef void (^ModelBlock)(InformationModel *model);
@interface UGSystemViewController : BaseViewController

-(void)initUI:(NSArray *)arr andPage:(int)page;

@property(strong,nonatomic)UGAssistantViewController *assistantVC;
@property(strong,nonatomic)InformationModel *informationModel;
@property(strong,nonatomic)NSMutableArray *informationModelArr;
@property(nonatomic,strong)ModelBlock modelBlock;
@end
