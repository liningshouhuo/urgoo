//
//  UGSettingViewController.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSettingViewController.h"
#import "ClientChangePasswordViewController.h"
#import "UGAboutUrgooViewController.h"
#import "EditTextViewController.h"

@interface UGSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)NSArray *dataArr;
@property (strong, nonatomic)UITableView *tableView;
@end

@implementation UGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setCustomTitle:@"设置"];
    
    self.view.backgroundColor = RGB(247, 247, 247);
    
    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{
//    self.dataArr =@[@[@"推送"],@[@"修改密码"],@[@"意见反馈",@"关于优顾"]];
    self.dataArr =@[@[@"修改密码"],@[@"关于优顾"]];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-49) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    
    
    [self.view addSubview:self.tableView];
}

#pragma mark -tableView delegate&dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 3;
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section ==2) {
//        return 2;
//    }
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    if (indexPath.section ==0) {
        UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(kScreenWidth - 70, 7, 60, 30)];
        [sw addTarget:self action:@selector(SwitchAction:) forControlEvents:UIControlEventValueChanged];
//        [cell addSubview:sw];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    else{
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"434343"];
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}
#pragma mark   - SwitchAction
-(void)SwitchAction:(UISwitch *)sw
{
    NSLog(@"==%d",sw.on);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 10.0f;
    }
    return 10.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section ==1) {
        return 63.0f;
    }
    return 3.0f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        ClientChangePasswordViewController *vc = [[ClientChangePasswordViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:vc];
//    }else if (indexPath.section==2&&indexPath.row==0){
//        EditTextViewController *vc = [[EditTextViewController alloc] init];
//        vc.fromType = 100;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self pushToNextViewController:vc];
//    }else if (indexPath.section==2&&indexPath.row==1){
    }else if (indexPath.section==1){

        UGAboutUrgooViewController *vc = [[UGAboutUrgooViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self pushToNextViewController:vc];
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20+43)];
        footerView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:footerView];
        
        
        UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOutBtn.frame = CGRectMake(0, 20, footerView.width, 43);
        [loginOutBtn setTitle:@"退出" forState:UIControlStateNormal];
        [loginOutBtn setTintColor:[UIColor colorWithHexString:@"434343"]];
        [loginOutBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [loginOutBtn setBackgroundColor:[UIColor whiteColor]];
        [loginOutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [loginOutBtn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:loginOutBtn];
        
        
        for (NSInteger i=0; i<2; i++) {
            UILabel *line1 =[[UILabel alloc]initWithFrame:CGRectMake(0, 42.5*i, kScreenWidth, 0.5)];
            line1.backgroundColor =[UIColor colorWithHexString:@"d4d4d4"];
            [loginOutBtn addSubview:line1];
        }
        
        return footerView;
    }
    return nil;
}
-(void)loginOutAction
{

    DLog(@"loginout");
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                DLog(@"退出成功");

                //退出登录后清除token
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                
                DLog(@"清除token--%@",kToken);
                
                //推出登陆，切换到登录页面
//                [[AppDelegate sharedappDelegate] showLogin];
                [AppDelegate sharedappDelegate].tabbar.selectedIndex=0;

            }
            else{
                DLog(@"退出登陆的error%@",error.errorDescription);

                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
            }
        });
    });

    
    
 
    
    
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
