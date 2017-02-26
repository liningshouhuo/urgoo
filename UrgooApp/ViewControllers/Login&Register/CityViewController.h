//
//  CityViewController.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/4/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGCityModel.h"

@protocol cityDelegate <NSObject>

-(void)seleCity:(UGCityModel *)cityModel;

@end

@interface CityViewController : BaseViewController

@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) UITableView *cityTableView;
@property (nonatomic, strong) UGCityModel *cityModel;
@property (nonatomic,strong) id<cityDelegate> cityDeledate;

@end
