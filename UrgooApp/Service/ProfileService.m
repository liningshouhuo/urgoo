//
//  ProfileService.m
//  UrgooApp
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ProfileService.h"
#import "AccountModel.h"


@implementation ProfileService


-(instancetype)getAccountWithDict:(NSDictionary *)dict{
    
    AccountModel *cmodel=[[AccountModel alloc] init];
    //NSString *str=dict[@"cnName"];
    cmodel.cnName=dict[@"cnName"];
    cmodel.enName=dict[@"enName"];
    cmodel.cityName=dict[@"cityName"];
    cmodel.grade=dict[@"grade"];
    cmodel.gender=dict[@"gender"];
    cmodel.nickName=dict[@"nickName"];
    cmodel.userIcon=dict[@"userIcon"];
    cmodel.countryName = dict[@"countryName"];
    
    return cmodel;
}


-(NSMutableArray *)getCountryListWithDict:(NSMutableArray *)mArray{
    
    
   NSMutableArray *marry=[[NSMutableArray alloc] init];
   /**  for (NSDictionary *dic in mArray) {
        UGCountryModel *model = [[UGCountryModel alloc] init];
        model.CountryID= [dic objectForKey:@"countryId"];
        model.CountryMC=[dic objectForKey:@"name"];
        
        //self.CountryModel.countryId= [dic objectForKey:@"countryId"];
        [marry addObject:model];
    }
    **/
    return mArray;
    
}
@end
