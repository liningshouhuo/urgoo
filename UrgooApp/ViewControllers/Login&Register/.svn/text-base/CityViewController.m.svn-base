//
//  CityViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/4/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "CityViewController.h"
#import "RequestManager.h"

#import "ProfileService.h"
#import "MsgModel.h"
#import "HttpClientManager.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface CityViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"城市"];
    self.cityArray = [NSMutableArray array];
    
    [self creatTableView];
    [self GetNetData];
    
    
    
    
    
    
}

-(void)creatTableView{
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64) style:UITableViewStylePlain];
    self.cityTableView.rowHeight = 44;
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate   = self;
    self.cityTableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark --tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return self.cityArray.count;
    if (self.cityArray.count != 0) {
        return self.cityArray.count;
    }
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    UGCityModel *cityModel = [[UGCityModel alloc] init];
    cityModel = self.cityArray [indexPath.row];
    cell.textLabel.text = cityModel.CityName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [_cityDeledate seleCity:self.cityArray[indexPath.row]];

}

-(void)GetNetData{
    
    
    // 1.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    
    [HttpClientManager getAsyn:UG_CityList_URL params:params success:^(id resultData) {
        
        ProfileService *service=[[ProfileService alloc] init];
        MsgModel *msg=[service getHeaderMsgWithDict:resultData[@"header"]];
        NSString *code=msg.code;
        
        
        if ([code isEqualToString:@"200"]) {
            NSArray *dataArray = [NSArray array];
            NSDictionary *bodyDic = resultData[@"body"];
            dataArray = [bodyDic objectForKey:@"cityList"];
            for (id obj in dataArray) {
                self.cityModel = [[UGCityModel alloc] init];
                self.cityModel.CityID = [obj objectForKey:@"id"];
                self.cityModel.CityName = [obj objectForKey:@"cityName"];
                [self.cityArray addObject:self.cityModel];
                
            }
            [self.view addSubview:self.cityTableView];
        }
        
        
    } failure:^(NSError *error) {
        
         NSLog(@"请求失败。。。");
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
