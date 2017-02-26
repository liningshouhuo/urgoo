//
//  UGTasksViewController.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "BaseViewController.h"
#import "UGAssistantViewController.h"
typedef void (^TmodelBlock)(MesgAccountModel *model);
@interface UGTasksViewController : BaseViewController
@property(strong,nonatomic)UGAssistantViewController *assistantVC;
@property(strong,nonatomic)NSMutableArray *informationModelArr;
@property(strong,nonatomic)MesgAccountModel *MesgAccountModel;
@property(nonatomic,strong)TmodelBlock modelBlock;
-(void)initUI:(NSArray *)arr andPage:(int)page;

@end
