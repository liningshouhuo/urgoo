 //
//  UGscheduCollectionViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGscheduCollectionViewCell.h"
#import "AdanceTimeList.h"
@interface UGscheduCollectionViewCell()<UITableViewDelegate,UITableViewDataSource>;

@property(strong,nonatomic) UITableView * tableview;
@property(strong,nonatomic) UIView * headView;
@property(strong,nonatomic) UIView * backBView;
@property(strong,nonatomic) UIView * xulineview;
@property (strong,nonatomic) UIButton * cellBtn;
@property (assign,nonatomic) int buttonIndex;

@property (strong,nonatomic)NSMutableArray * timeListArrayM;
@property (strong,nonatomic)AdanceTimeList * timeListModel;
@property (strong,nonatomic)NSMutableArray * timeListModelArray;
@property (strong,nonatomic)NSMutableArray * button_ArrayM;
@property (strong,nonatomic)NSMutableArray * button_statueArrayM;
@property (strong,nonatomic)UITableViewCell * cell;
@property (strong,nonatomic)NSMutableArray * btnTagArray;
@property (strong,nonatomic)NSArray * stackArray;

@end

@implementation UGscheduCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self setUI];
    self.backgroundColor = [UIColor yellowColor];
    
    return self;
}
//_btnTagArray
-(NSMutableArray *)btnTagArray{
    if (_btnTagArray == nil) {
        _btnTagArray = [NSMutableArray array];
    }
    
    return _btnTagArray;
    
}
-(NSArray *)stackArray{
    if (_stackArray == nil) {
        _stackArray = [NSArray array];
    }
    return _stackArray;
}

-(NSMutableArray *)buttonIndexArray{
    if (_buttonIndexArray == nil) {
        _buttonIndexArray = [NSMutableArray array];
    }
    
    return _buttonIndexArray;
    
}
-(NSMutableArray *)button_ArrayM{
    if (_button_ArrayM == nil) {
        _button_ArrayM = [NSMutableArray array];
    }
    
    return _button_ArrayM;
    
}
-(NSMutableArray *)button_statueArrayM{
    if (_button_statueArrayM == nil) {
        _button_statueArrayM = [NSMutableArray array];
    }
    
    return _button_statueArrayM;
    
}


//-(void)setTestlable:(NSString *)testlable{
//    
//    
//    _buttonIndex =0;
//    [self.buttonIndexArray removeAllObjects];
//    
//}
-(void)yansendbtnindex:(NSNotification *)notification{
    
      NSString * bottonindex = notification.userInfo[@"addbottonindex"];
    int intbottonindex = [bottonindex intValue];
    self.addbuttonIndex =intbottonindex;
   // NSLog(@"self.addbuttonIndex====uvjhv==%d",self.addbuttonIndex);
    
    
}
-(void)setDateListmodel:(AdvanceDateList *)dateListmodel{
    
    
    _dateListmodel = dateListmodel;
     _timeListArrayM = [NSMutableArray array];
    _timeListModelArray = [NSMutableArray array];
   // _btnTagArray = [NSMutableArray array];
    
    NSString * busyday =_dateListmodel.busyDay;
    
    for (NSDictionary * dict in _dateListmodel.timeList) {
       
        AdanceTimeList * model = [AdanceTimeList mj_objectWithKeyValues:dict];
       // NSLog(@"%@",_timeListModel.type);
       // NSString * str = [NSString stringWithFormat:@"%@-%@(美国时间 %@-%@)",dict[@"cnStartTime"],dict[@"cnEndTime"],dict[@"otherStartTime"],dict[@"otherEndTime"]];
       NSString * str = [NSString stringWithFormat:@"%@-%@",dict[@"cnStartTime"],dict[@"cnEndTime"]];
       
        [self.timeListArrayM addObject:str];
        [self.timeListModelArray addObject:model];
    }
    
    
     [self.tableview reloadData];
    
    _buttonIndex =0;
    [self.buttonIndexArray removeAllObjects];
     [self.button_ArrayM removeAllObjects];
    

}
-(void)setCellIndex:(NSInteger)cellIndex{
    _cellIndex = cellIndex;
    
}
-(void)setIndexpathArray:(NSMutableArray *)indexpathArray{
    [self.btnTagArray removeAllObjects];
    _indexpathArray = [NSMutableArray arrayWithArray: indexpathArray];
    if (_indexpathArray.count >0) {
        NSString * cellindexstr = [NSString stringWithFormat:@"%ld",(long)self.cellIndex];
        for (NSArray * arraybtn in _indexpathArray) {
            NSString * weekindex = arraybtn[0];
            NSString * cellindex_last =arraybtn[1];
            
            if ([weekindex isEqualToString:self.dateWeek] && [cellindex_last isEqualToString:cellindexstr] ) {
                
                if (arraybtn.count==3) {
                    NSString * indexStr1 =arraybtn[2];
                    NSInteger  indexpath_row1 = [indexStr1 intValue];
                    
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row1]];
                }else if (arraybtn.count==4){
                    NSString * indexStr1 =arraybtn[2];
                    NSInteger  indexpath_row1 = [indexStr1 intValue];
                    NSString * indexStr2 =arraybtn[3];
                    NSInteger  indexpath_row2 = [indexStr2 intValue];
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row1]];
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row2]];
                }else if (arraybtn.count==5){
                    NSString * indexStr1 =arraybtn[2];
                    NSInteger  indexpath_row1 = [indexStr1 intValue];
                    NSString * indexStr2 =arraybtn[3];
                    NSInteger  indexpath_row2 = [indexStr2 intValue];
                    NSString * indexStr3 =arraybtn[4];
                    NSInteger  indexpath_row3 = [indexStr3 intValue];
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row1]];
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row2]];
                    [self.btnTagArray addObject:[NSNumber numberWithInteger:indexpath_row3]];
                    
                    
                    
                }
            }
        }
    }
    
  
    
}
-(void)setUI{
    _backBView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.size.height)];
    [self.contentView addSubview:_backBView];
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    
    _headView.backgroundColor =[UIColor colorWithHexString:@"#ffffff"];
    UILabel * timeChoose = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 28, 14, 57, 14)];
    //timeChoose.center = _headView.center;
//    timeChoose.centerX = kScreenWidth/2;
//    timeChoose.centerY = 22;
//    timeChoose.size = CGSizeMake(57, 14);
    timeChoose.text = @"选择时间";
    timeChoose.textAlignment = NSTextAlignmentLeft;
    timeChoose.font = [UIFont systemFontOfSize:14];
    [timeChoose setTextColor:[UIColor colorWithHexString:@"#383838"]];
    [_headView addSubview:timeChoose];
    
    UILabel * warnninglable = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 11 -84, 16, 85, 11)];
    warnninglable.text =@"最多选择3个时段";
    warnninglable.textAlignment = NSTextAlignmentLeft;
    [warnninglable setTextColor:[UIColor colorWithHexString:@"#9d9d9d"]];
    warnninglable.font = [UIFont systemFontOfSize:11];
    [_headView addSubview:warnninglable];
    UIView * lineview =[[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    lineview.backgroundColor = [UIColor colorWithHexString:@"#9d9d9d"];
    [_headView addSubview:lineview];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.contentView.frame.size.height )];
    //[_tableview setTableHeaderView:_headView];
    self.tableview.separatorStyle =   UITableViewCellSeparatorStyleNone;

    _tableview.delegate = self;
    _tableview.dataSource = self;
    [_backBView addSubview: _tableview];
    [self.tableview setContentOffset:CGPointMake(0, 0)];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.timeListArrayM.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        
        
    }
   
   
    
    _xulineview = [[UIView alloc]initWithFrame:CGRectMake(10, 43.5, kScreenWidth -10, 0.5)];
    [self drawDashLine:_xulineview lineLength:5 lineSpacing:5 lineColor:[UIColor colorWithHexString:@"#9d9d9d"]];
    [cell.contentView addSubview:_xulineview];
    cell.textLabel.text = self.timeListArrayM[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#383838"]];
    cell.textLabel.textAlignment =  NSTextAlignmentLeft ;
    cell.accessoryType = UITableViewCellAccessoryNone;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(kScreenWidth- 46 , 0.0, 41, 44)];
    _timeListModel =  self.timeListModelArray[indexPath.row];
    button.tag = indexPath.row +10;
    if ([_timeListModel.type isEqualToString:@"2"]) {
       
        [button setImage:[UIImage imageNamed:@"button_defaul"] forState:UIControlStateNormal];
        [cell.textLabel setTextColor:[UIColor colorWithHexString:@"#b7b7b7"]];
    }else{
        
        [button setImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@"button_normal"] forState:UIControlStateNormal];
               //[button setImage:[UIImage imageNamed:@"tap_highlight.png"] forState:UIControlStateHighlighted];
        
       // button.selected = NO;
        //NSLog(@"%ld",(long)indexPath.row);
        if (_btnTagArray.count>0) {
        for (int i = 0; i<_btnTagArray.count; i++) {
            NSString * btnindexstr = [NSString stringWithFormat:@"%@",_btnTagArray[i]];
            NSLog(@"btnindex%@",btnindexstr);
           NSInteger btnindex = [btnindexstr intValue] - 10;
            
            if (btnindex == indexPath.row) {
                button.selected = YES;
            }
//            if (btnindex == indexPath.row) {
//                button.selected = YES;
//            }
                          }
            
            
        }else{
            
            if (_indexpathArray.count >0) {
                
                
                
                for (int i = 0; i< _indexpathArray.count; i++) {
                    NSArray * indexArray1 = [NSArray arrayWithArray:_indexpathArray[i]];
                    NSString * weekindex = indexArray1[0];
                    if (indexArray1.count ==3) {
                        if ([weekindex isEqualToString:self.dateWeek]) {
                            
                            NSString * indexStr =indexArray1[1];
                            NSInteger  indexpath_row = [indexStr intValue] ;
                            if (indexpath_row == _cellIndex) {
                                NSString * indexStr1 =indexArray1[2];
                                NSInteger  indexpath_row1 = [indexStr1 intValue]-10;
                                
                                if (indexpath_row1 == indexPath.row) {
                                    button.selected = YES;
                                }
                            }
                        }
                        
                    }else if (indexArray1.count ==4){
                        if ([weekindex isEqualToString:self.dateWeek]) {
                            
                            
                            
                            NSString * indexStr =indexArray1[1];
                            NSInteger  indexpath_row = [indexStr intValue];
                            if (indexpath_row == _cellIndex) {
                                NSString * indexStr1 =indexArray1[2];
                                NSInteger  indexpath_row1 = [indexStr1 intValue]-10;
                                NSString * indexStr2 =indexArray1[3];
                                NSInteger  indexpath_row2 = [indexStr2 intValue]-10;
                                
                                if (indexpath_row2 == indexPath.row ||  indexpath_row1 == indexPath.row) {
                                    button.selected = YES;
                                }
                            }
                            
                        }
                        
                    }else if (indexArray1.count ==5){
                        if ([weekindex isEqualToString:self.dateWeek]) {
                            
                            
                            NSString * indexStr =indexArray1[1];
                            NSInteger  indexpath_row = [indexStr intValue];
                            if (indexpath_row == _cellIndex) {
                                NSString * indexStr1 =indexArray1[2];
                                NSInteger  indexpath_row1 = [indexStr1 intValue]-10;
                                NSString * indexStr2 =indexArray1[3];
                                NSInteger  indexpath_row2 = [indexStr2 intValue]-10;
                                NSString * indexStr3 =indexArray1[4];
                                NSInteger  indexpath_row3 = [indexStr3 intValue]-10;
                                
                                if (indexpath_row2 == indexPath.row ||  indexpath_row1 == indexPath.row ||  indexpath_row3 == indexPath.row) {
                                    button.selected = YES;
                                }
                            }
                        }
                        
                        
                    }
                    
                }
                
                
            }
        }
       


        
   
        
        
        
        [button addTarget:self action:@selector(btnClicked:event:)  forControlEvents:UIControlEventTouchUpInside];
        
        [button setBackgroundColor:[UIColor clearColor]];
    }
    [cell.contentView addSubview:button];
    
   
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
    return cell;
    
}
- (void)btnClicked:(UIButton *)sender event:(id)event{
    NSString * cellindex = [NSString stringWithFormat:@"%ld",(long)self.cellIndex];
    NSMutableArray * button_array = [NSMutableArray array];
   
        if (sender.selected) {
            sender.selected = NO;
            
            [self.btnTagArray removeObject:[NSNumber numberWithInteger:sender.tag ]];
                   }else{
           
            sender.selected = YES;
            [self.btnTagArray addObject:[NSNumber numberWithInteger:sender.tag ]];
                       
                    }
    
    NSLog(@"_btnTagArray====%@",self.btnTagArray);
    for (NSInteger x= 10; x<29; x++) {
        NSInteger row = [self.tableview numberOfRowsInSection:0];
       // NSLog(@"======%ld",(long)row);
        for (int row = 0; row <18; row++) {
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:row inSection:0];
            UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:index];
            
            UIButton * index_button = (UIButton * )[cell.contentView viewWithTag:x];
            // NSLog(@"index_button---------%@",index_button);
            if (index_button.selected == YES) {
                
                [button_array addObject:[NSNumber numberWithInteger:x]];
                
            }
        }
        
        
        //NSLog(@"button_array====%@",button_array);
        
    }

    
    NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:self.btnTagArray,@"button_array",cellindex,@"cellindex",_dateWeek,@"dateWeek",nil];
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"buttonIndexArraynotice" object:self userInfo:dict];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
  


    
    
    
}
//wuyong
- (void)btnClickd:(UIButton *)sender event:(id)event{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yansendbtnindex:) name:@"yansendbtnindex" object:nil];
    NSString * cellindex = [NSString stringWithFormat:@"%ld",(long)self.cellIndex];
    NSMutableArray * button_array = [NSMutableArray array];
      // NSLog(@"button_array---最终解决方案---%@",button_array);
    if (self.addbuttonIndex >3 ) {
       // NSLog(@"--------%@",cellindex);
       // NSLog(@"========%d",self.addbuttonIndex);
        
        
    }else{
        
        if(_buttonIndex < 3 ){
            
            if (sender.selected) {
                sender.selected = NO;
                int num = (int)sender.tag;
                _buttonIndex -=1;
                [self.button_ArrayM lastObject];
                [self.buttonIndexArray removeObject:[NSNumber numberWithInt:num]];
            }else{
                _buttonIndex +=1;
                sender.selected = YES;
                int num = (int)sender.tag;
               // NSLog(@"---------%d",num);
                [self.button_ArrayM addObject:cellindex];
                [self.buttonIndexArray addObject:[NSNumber numberWithInt:num]];
                
            }
        }else if (_buttonIndex ==3){
            if (sender.selected) {
                sender.selected = NO;
                _buttonIndex -=1;
                int num = (int)sender.tag;
                [self.button_ArrayM addObject:cellindex];
                [self.buttonIndexArray removeObject:[NSNumber numberWithInt:num]];
            }
            
            
            
            
            
        }
        
        if (_buttonIndexArray.count == 0) {
            [self.button_ArrayM removeLastObject];
           // NSLog(@"self.button_ArrayM--%@",self.button_ArrayM);
            NSString * bottonindex = [NSString stringWithFormat:@"%d",self.buttonIndex];
            NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:cellindex,@"selsect",self.button_ArrayM,@"cellIndex",bottonindex,@"bottonindex", nil];
            //创建一个消息对象
            
            NSNotification * notice = [NSNotification notificationWithName:@"buttonIndexArraynotice" object:self userInfo:dict];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        }
        
        if (_buttonIndexArray.count>0) {
            
            if (_buttonIndexArray.count == 1) {
                
              
                NSString * bottonindex = [NSString stringWithFormat:@"%d",self.buttonIndex];
                NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:_buttonIndexArray[0],@"indexone",self.button_ArrayM,@"cellIndex",bottonindex,@"bottonindex", nil];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"buttonIndexArraynotice" object:self userInfo:dict];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }
            else if (_buttonIndexArray.count == 2){
                NSString * bottonindex = [NSString stringWithFormat:@"%d",self.buttonIndex - 1];
                NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:_buttonIndexArray[0],@"indexone",_buttonIndexArray[1],@"indextwo",self.button_ArrayM,@"cellIndex",bottonindex,@"bottonindex", nil];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"buttonIndexArraynotice" object:self userInfo:dict];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }
            else if (_buttonIndexArray.count == 3){
                NSString * bottonindex = [NSString stringWithFormat:@"%d",self.buttonIndex - 2];
                NSDictionary * dict =[[NSDictionary alloc]initWithObjectsAndKeys:_buttonIndexArray[0],@"indexone",_buttonIndexArray[1],@"indextwo",_buttonIndexArray[2],@"indexthere",self.button_ArrayM,@"cellIndex", bottonindex,@"bottonindex",nil];
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"buttonIndexArraynotice" object:self userInfo:dict];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
            }
            
        }

        
        
           }
//    NSSet *touches =[event allTouches];
//    UITouch *touch =[touches anyObject];
//    [touch locationInView:self.tableview];
//    CGPoint  currentTouchPosition = [touch locationInView:self.tableview];
//
//    NSIndexPath *indexPath= [self.tableview indexPathForRowAtPoint:currentTouchPosition];
//    if (indexPath!= nil)
//    {
//
//        NSLog(@"点击 button 之后 的  %ld",(long)indexPath.row);
//
//
//        //[self tableView: self.tableview accessoryButtonTappedForRowWithIndexPath:indexPath];
//    }
    for (NSInteger x= 10; x<29; x++) {
        NSInteger row = [self.tableview numberOfRowsInSection:0];
        //NSLog(@"%ld",(long)row);
        for (int row = 0; row <18; row++) {
            
            NSIndexPath * index = [NSIndexPath indexPathForRow:row inSection:0];
            UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:index];
            
            UIButton * index_button = (UIButton * )[cell.contentView viewWithTag:x];
           // NSLog(@"index_button---------%@",index_button);
            if (index_button.selected == YES) {
                
                [button_array addObject:[NSNumber numberWithInteger:x]];
                
            }
        }
        
        
       // NSLog(@"button_array====%@",button_array);
        
    }
}
#pragma _make 选中行的代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"选中了 %ld",(long)indexPath.row);
    
    
}
#pragma mark 虚线的绘制
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
