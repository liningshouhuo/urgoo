//
//  UGAcountViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"
#import "UGAssistantViewController.h"
typedef void (^AmodelBlock)(MesgAccountModel *model);
@interface UGAcountViewController : BaseViewController
@property(strong,nonatomic)UGAssistantViewController *assistantVC;
@property(strong,nonatomic)MesgAccountModel *MesgAccountModel;
@property(strong,nonatomic)NSMutableArray *informationModelArr;
@property(nonatomic,strong)AmodelBlock modelBlock;

-(void)initUI:(NSArray *)arr andPage:(int)page;

@end
