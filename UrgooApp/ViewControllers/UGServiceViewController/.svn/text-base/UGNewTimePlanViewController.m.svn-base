//
//  UGNewTimePlanViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGNewTimePlanViewController.h"
#import "UGTimeplanTableViewCell.h"
#import "TimePlanModel.h"
@interface UGNewTimePlanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView * timeplanView;
@property (strong,nonatomic) NSMutableArray * hightArray;
@property (strong,nonatomic) NSMutableArray * testArray;
@property (strong,nonatomic) NSMutableArray * testArray1;
@end

@implementation UGNewTimePlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setCustomTitle:_titleName];
    [self loadRequest];
   // [self setUI];
    
}
-(NSMutableArray *)testArray{
    if (_testArray == nil) {
        _testArray = [NSMutableArray array];
    }
    
    return _testArray;
    
}
-(NSMutableArray *)testArray1{
    if (_testArray1 == nil) {
        _testArray1 = [NSMutableArray array];
    }
    
    return _testArray1;
    
}

-(void)loadRequest{
    
    
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    
    
    
    pramas[@"token"] = kToken;
    
    pramas[@"type"] = _type;
    
    [HttpClientManager getAsyn:newTimeLine params:pramas success:^(id json) {
        
        if ([json[@"header"][@"code"]  isEqualToString:@"200"]) {
            NSArray * timeLine = json[@"body"][@"timeLine"];
            
            
            for (NSDictionary * dict in timeLine) {
                
                TimePlanModel * model = [TimePlanModel mj_objectWithKeyValues:dict];
                
                
                
                if ([model.status isEqualToString:@"3"]) {
                    NSLog(@"%@",model.subjectCn);
                    [self.testArray addObject:model.subjectCn];
                }else if ([model.status isEqualToString:@"1"]){
                     NSLog(@"%@",model.subjectCn);
                    [self.testArray1 addObject:model.subjectCn];
                    
                    
                }
                
                
                
            }
            
            [self setUI];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    

    
    
    
    
}
-(NSMutableArray *)hightArray{
    
    if (_hightArray ==nil) {
        _hightArray = [NSMutableArray array];
    }
    
    
    return _hightArray;
    
    
}

-(void)setUI{
    
//       _testArray = @[@"凤凰体育讯 北京时间8月21日09：15，在里约奥运女排决赛中，中国女排在先输一局的情况下加强发球和拦网，连扳三局3-1逆转获胜，时隔12年再度荣膺奥运冠军。在第一时间，国际排联祝贺中国女排夺冠，并盛赞朱婷是第一功臣",@"国际排联官网写道：“夺冠时刻，数千名中国球迷为他们的球队欢呼，中国女排加盟冠军，今天的比赛，她们的胜利当之无愧！",@"中国女排第三次登上奥运之巅",@"1984年洛杉矶奥运会"];
//    _testArray1 = @[@"带着兴奋和不舍，里约奥运最后一个比赛日结束。中国军团最终获得26金18银26铜，总计70枚奖牌，列金牌榜第三位。",@"本届赛事，中国军团金牌总数为1996年亚特兰大奥运会以来的最低，在跆拳道、自行车等项目上迎来突破，六大梦之队半数下滑，乒乓球、跳水等项目延续统治地位，体操、射击等项目上也遭遇滑铁卢，羽毛球队曝出内乱传闻。",@"金牌和爆冷、撕逼和逗比、兴奋与眼泪，里约奥运带给人们一个难忘的夏天。我们通过几大关键词，总结里约奥运会。",@"金牌：六大“梦之队”半数下滑"];
//    
    
    
    for (int i = 0; i<self.testArray.count + self.testArray1.count; i++) {
        
       
        
        if (i <self.testArray.count) {
            
            NSString * hightStr=  self.testArray[i];
            
            CGFloat hight = [self getHeightWithContent:hightStr width:kScreenWidth * 0.75 font:13];
            
            [self.hightArray addObject:[NSNumber numberWithFloat:hight]];

            
            
        }else  {
            
            
            NSString * hightStr=  self.testArray1[i -self.testArray.count];
            
            CGFloat hight = [self getHeightWithContent:hightStr width:kScreenWidth * 0.75 font:13];
            
            [self.hightArray addObject:[NSNumber numberWithFloat:hight]];
            
        }
        
    }
    
    
    
    
    
   // UIView * titleView = [UIView alloc]initWithFrame:<#(CGRect)#>
    for (int i = 0; i<2; i++) {
        UIView * titileCycleView = [[UIView alloc]init];
        titileCycleView.layer.cornerRadius = 5;
        
        
        [self.view addSubview:titileCycleView];
        
        
        UILabel * lable1 = [[UILabel alloc]init];
        lable1.font = [UIFont systemFontOfSize:11];
        lable1.textColor = [UIColor colorWithHexString:@"#434343"];
        lable1.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:lable1];
        
        
        if (i ==0) {
            
            titileCycleView.frame = CGRectMake((kScreenWidth - 250)/2, 21.5, 10, 10);
            titileCycleView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
            lable1.text = @"已完成的任务";
            lable1.frame = CGRectMake(titileCycleView.x +14, 20, 67, 13);
        }else  if (i ==1) {
            
            titileCycleView.frame = CGRectMake((kScreenWidth - 250)/2 +81 +94, 21.5, 10, 10);
            titileCycleView.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
            lable1.text = @"未完成的任务";
            lable1.frame = CGRectMake(titileCycleView.x +14, 20, 67, 13);
        }

        
    }
    
    
    _timeplanView = [[UITableView alloc]init];
    _timeplanView.frame = CGRectMake(0, 64, kScreenWidth, kScreenHeight - 128);
   // _timeplanView.backgroundColor = [UIColor clearColor];
    _timeplanView.separatorStyle =   UITableViewCellSeparatorStyleNone;
    _timeplanView.delegate = self;
    _timeplanView.dataSource = self;
    _timeplanView.bounces = NO;
    //_timeplanView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [_timeplanView registerClass:[UGTimeplanTableViewCell class] forCellReuseIdentifier:@"UG_timePlan"];
    
    [self.view addSubview:_timeplanView];

    
//    UIImage * bubble = [UIImage imageNamed:@"New_plan_bubble"];
//    
//    UIImageView * bubbleImage = [[UIImageView alloc]init];
//    bubbleImage.frame = CGRectMake(20, 100, kScreenWidth - 50, 200);
//   //bubbleImage.backgroundColor = [UIColor redColor];
//    
//  // [bubble resizableImageWithCapInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
//   bubble = [bubble resizableImageWithCapInsets:UIEdgeInsetsMake(50, 10, 100, bubble.size.height * 0.5) resizingMode:UIImageResizingModeTile];
//    
//    [bubbleImage setImage:bubble];
//    [self.view addSubview:bubbleImage];
    
    
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (self.testArray.count >0 && self.testArray1.count>0) {
        
        return self.testArray.count + self.testArray1.count +1;
    }else if (self.testArray.count >0){
        
        return self.testArray.count +1;
        
        
        
    }else if(self.testArray1.count>0){
        
          return self.testArray1.count +1;
    }
    
    return 0;
    
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UGTimeplanTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UG_timePlan"];
    if (cell ==nil) {
        cell = [[UGTimeplanTableViewCell alloc]initWithFrame:CGRectZero];
        
    }
    if (indexPath.row >0) {
        
        NSString *  hight = self.hightArray[indexPath.row -1];
        CGFloat hightfloat = [hight intValue];
        cell.height = hightfloat;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.testArray.count >0) {
            
            if (indexPath.row < self.testArray.count +1) {
                
                if (indexPath.row == self.testArray.count) {
                    cell.type1 = @"1";
                    
                }else{
                    
                    cell.type1 = @"4";
                    
                    
                }
                cell.type = @"1";
                cell.testStr = self.testArray[indexPath.row -1];
                
            }else{
                
                
                cell.type = @"2";
                cell.testStr = self.testArray1[indexPath.row -self.testArray.count -1];
            }
            
        }else{
            
            if (self.testArray1.count >0) {
                
                
                
//                
//                if (indexPath.row < self.testArray1.count +1) {
//                
//                if (indexPath.row == self.testArray1.count) {
//                    cell.type1 = @"1";
//                    
//                }else{
//                    
//                    cell.type1 = @"4";
//                    
//                    
//                }
//                cell.type = @"1";
//                cell.testStr = self.testArray1[indexPath.row -1];
//                
//            }
                
            }
            
            
            
            
            
            
        }

    }else if(indexPath.row == 0){
        
        cell.height = 44;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
           cell.type = @"3";
        
        cell.testStr = @"998";
        
    }
    
    
    
   
    return cell;

    
    
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        NSString *  hight = self.hightArray[indexPath.row-1];
        CGFloat hightfloat = [hight intValue];
        return hightfloat +40;
        
    }
    
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}  context:nil];
    return rect.size.height;
    
    
    
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
