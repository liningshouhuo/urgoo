//
//  UGMyServiceViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/6.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyServiceViewController.h"
#import "UGStarTableViewCell.h"
#import "UGMyreportViewController.h"

@interface UGMyServiceViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic) UITableView * tableview;
@property (strong,nonatomic) UIScrollView * scrollView;
@property (strong,nonatomic) NSArray * testArray;
@property (strong,nonatomic) NSArray * testArray1;
@end

@implementation UGMyServiceViewController
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTranslucent:YES];
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController.navigationBar setTranslucent:NO];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.navigationController.navigationBar setTranslucent:YES];
    //[self.navigationController.navigationBar setHidden:YES];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0.0];

    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    button.backgroundColor =[UIColor redColor];
    [button addTarget:self action:@selector(click_backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [self setUpUI];
    [self needBackAction:YES];
    
    //self.view.backgroundColor = RGBAlpha(1, 14, 39, 0.7);
}
-(NSArray *)testArray{
    if (_testArray == nil) {
        _testArray =[NSArray arrayWithObjects:@"反倒是个梵蒂冈",@"广泛的广告的股份的",@"股份大股东",@"滚动",@"滚动",@"方法", nil];
    }
    
    
    return _testArray;
    
}
-(NSArray *)testArray1{
    if (_testArray1 == nil) {
        _testArray1 =[NSArray arrayWithObjects:@"考虑客户呢",@"红包一天后你会看",@"给他任何风格", nil];
    }
    
    
    return _testArray1;
    
}

-(void)setUpUI{
    
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _scrollView.backgroundColor = RGBAlpha(1, 14, 39, 0.7);
    [self.view addSubview:_scrollView];
    
    
    _tableview = [[UITableView alloc]init];
    _tableview.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _tableview.backgroundColor = [UIColor clearColor];
    _tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.estimatedRowHeight = 120;
    _tableview.rowHeight = UITableViewAutomaticDimension;
    [_tableview registerClass:[UGStarTableViewCell class] forCellReuseIdentifier:@"UG_star"];
    UIView * headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    UIView * headLineview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.377, 40, 2, 24)];
    
    
    [headview addSubview:headLineview];
    
    [self drawDashLine:headLineview lineLength:5 lineSpacing:3 lineColor:RGB(153, 153, 153)];
    headview.backgroundColor = [UIColor clearColor];
    
    _tableview.tableHeaderView = headview;
    [_scrollView addSubview:_tableview];
    UIImageView *backImageView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [backImageView setImage:[UIImage imageNamed:@"MyService_photo"]];
    _tableview.backgroundView=backImageView;
//    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
//    button.backgroundColor =[UIColor clearColor];
//    [button setImage:[UIImage imageNamed:@"nav_back-n"] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(click_backBtn) forControlEvents:UIControlEventTouchUpInside];
//    [_scrollView addSubview:button];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 44,  20, 44, 44)];
    button1.backgroundColor =[UIColor clearColor];
    [button1 setImage:[UIImage imageNamed:@"click_share"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(click_backBtn) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:button1];

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.testArray.count + self.testArray1.count +1;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UGStarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UG_star"];
    if (cell ==nil) {
        cell = [[UGStarTableViewCell alloc]initWithFrame:CGRectZero];
        
    }
    //(@"%@",self.consultantArray);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row <self.testArray1.count) {
        if (indexPath.row == 0) {
            
            cell.fisrtCell= @"第一个";
        }else{
            cell.fisrtCell = @"";
        }
        cell.test2Str = self.testArray1[indexPath.row];
        
    }else if (indexPath.row ==self.testArray1.count){
        
        
        cell.test1Str = @"dsad";
        
        
    }else{
        
        if (indexPath.row == self.testArray.count + self.testArray1.count) {
            cell.lastCell= @"最后一个";
            
        }else{
            cell.lastCell= @"";
            
        }
        cell.testStr = self.testArray[indexPath.row - self.testArray1.count - 1];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;

    
   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 120;
    
}
    
    
    
    

-(void)click_backBtn{
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CGFloat hight = lineView.size.height;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(lineView.width/2 , lineView.height /2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:2.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0,hight);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
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
