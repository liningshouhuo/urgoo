//
//  NewUsersViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewUsersViewController.h"
#import "NewRegistViewController.h"
#import "QuestionDataModel.h"
#import "SelectContentModel.h"

@interface NewUsersViewController ()
{
    NSMutableArray *buttonArr;
    NSMutableArray *buttonSelectArr;
    NSMutableArray *buttonSelectTitleArr;
    
    //数据处理
    NSMutableArray *titleList;
    NSMutableArray *typeList;
    NSMutableArray *typeAllList;
    NSMutableArray *nameList;//问题 -> 选项list
    NSMutableArray *nameDicList;//选项 -> id
    NSMutableArray *idList;
    
    NSInteger questionNum;
    NSString *type;
    BOOL      isBack;
    BOOL      isClickNotUpButnState;
    //NSMutableArray *butnStateArr;
    NSMutableArray *butnStatesList;
    NSMutableArray *questionsList;
}

@property(strong,nonatomic)UIImageView *bgImageView;
@property(strong,nonatomic)UILabel  *question;
@property(strong,nonatomic)UIButton *tureButn;
@property(strong,nonatomic)QuestionDataModel  *questionModel;
@property(strong,nonatomic)SelectContentModel *contentModel;

@end

@implementation NewUsersViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [User_Default removeObjectForKey:@"REPLACELOCTION"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    
    [self NetErrorback];
    [self getNetData];
    questionNum = 0;
    //butnStateArr = [NSMutableArray array];
    butnStatesList = [NSMutableArray array];
}

-(void)NetErrorback
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    leftButton.frame = CGRectMake(10, 30, 30, 20);
    [leftButton setImage:[UIImage imageNamed:@"BackChevron"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
}

-(void)leftButtonBack
{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)initUIQuestion:(NSString *)question selectList:(NSArray *)selectList
{
    buttonArr = [NSMutableArray array];
    
    
    
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _bgImageView.userInteractionEnabled = YES;
    _bgImageView.image = [UIImage imageNamed:@"bg_question_icon"];
    [self.view addSubview:_bgImageView];
    
     [self hiddenNavigationNeedLeftBackButtonImageName:@"BackChevron"];
    
    _question = [[UILabel alloc] init];
    _question.frame = CGRectMake(0, kScreenHeight/6, kScreenWidth, 26);
    _question.textAlignment = NSTextAlignmentCenter;
    _question.font = [UIFont systemFontOfSize:24];
    _question.text = question;
    if (kScreenWidth < 370) {
        _question.frame = CGRectMake(0, kScreenHeight/6 - 20, kScreenWidth, 26);
        _question.font = [UIFont systemFontOfSize:22];
    }
    //CGFloat *f = [_question getHeightWithContent:@"你是" width:kScreenWidth font:26];
    _question.textColor = [UIColor colorWithHexString:@"4e4e4e"];
    [_bgImageView addSubview:_question];
    
    NSArray *title = selectList;
    for (int i = 0; i < title.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(30, kScreenHeight-147-45-i*(45+18), kScreenWidth-30*2, 45);
        if (kScreenWidth < 370) {
            button.frame = CGRectMake(30, kScreenHeight-147-35-i*(35+18), kScreenWidth-30*2, 35);
        }
        if (kScreenHeight > 670) {
            button.frame = CGRectMake(30, kScreenHeight-147-45-i*(45+18)-20, kScreenWidth-30*2, 45);
        }
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.layer.cornerRadius = 4;
        button.layer.borderWidth = 0.6;
        button.layer.borderColor = [UIColor colorWithHexString:@"26bcaa"].CGColor;
        button.layer.masksToBounds = YES;
        button.tag = 200 + i;
        [button setTitle:title[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"616161"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor colorWithHexString:@"ffffff"] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"26bcaa"]] forState:UIControlStateHighlighted];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"26bcaa"]] forState:UIControlStateSelected];
        [button setBackgroundImage:[UIImage createImageWithColor:[UIColor colorWithHexString:@"ffffff"]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectQuestion:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArr addObject:button];
        [_bgImageView addSubview:button];
        
    }
    
    _tureButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _tureButn.frame = CGRectMake(0, kScreenHeight-56, kScreenWidth, 56);
    _tureButn.titleLabel.font = [UIFont systemFontOfSize:16];
    _tureButn.enabled = NO;
    _tureButn.hidden = YES;
    _tureButn.layer.borderColor = [UIColor colorWithHexString:@"26bcaa"].CGColor;
    [_tureButn setTitle:@"确认" forState:UIControlStateNormal];
    [_tureButn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tureButn setTitleColor:[UIColor colorWithHexString:@"26bcaa"] forState:UIControlStateHighlighted];
    [_tureButn setBackgroundImage:[UIImage imageNamed:@"New_ture_button"] forState:UIControlStateNormal];
    [_tureButn setBackgroundImage:[UIImage createImageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted];
    [_tureButn addTarget:self action:@selector(clickTrueButn:) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:_tureButn];
    
    if ([User_Default objectForKey:@"REPLACELOCTION"]) {
        
            [self upButtonSate];
    }
}

-(void)clickTrueButn:(UIButton *)button
{
    
    
    if (isBack) {
        if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] >= questionNum-1) {
            [butnStatesList replaceObjectAtIndex:questionNum withObject:buttonSelectArr];
        }
        if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] == questionNum){
            isBack = NO;
            [User_Default removeObjectForKey:@"REPLACELOCTION"];
        }
        
    }else{
        [butnStatesList addObject:buttonSelectArr];
    }
    DLog(@"多选：%ld+++%@",butnStatesList.count,butnStatesList);
    
    [self upData];
}

-(void)selectQuestion:(UIButton *)button
{
    isClickNotUpButnState = YES;
    buttonSelectArr = [NSMutableArray array];
    buttonSelectTitleArr = [NSMutableArray array];
    
    if ([type isEqualToString:@"1"]) {
        
        _tureButn.enabled = YES;
        _tureButn.hidden = NO;
        if (questionNum == 9) {
            [_tureButn setTitle:@"完成" forState:UIControlStateNormal];
        }
        button.selected = !button.isSelected;
        for (int i = 0; i < buttonArr.count; i ++) {
            UIButton *butn = (UIButton *)buttonArr[i];
            if (butn.selected == 1) {
                NSInteger butnTag = butn.tag - 200;
                [buttonSelectTitleArr addObject:butn.titleLabel.text];
                [buttonSelectArr addObject:[NSString stringWithFormat:@"%ld",butnTag]];
            }
        }
        DLog(@"******多项选择的按钮：%@===%@",buttonSelectArr,buttonSelectTitleArr);
    }
    else if ([type isEqualToString:@"0"]){
        
        for (int i = 0; i < buttonArr.count; i ++) {
            UIButton *butn = (UIButton *)buttonArr[i];
            butn.selected = NO;
        }
        button.selected = YES;
        [buttonSelectTitleArr addObject:button.titleLabel.text];
        NSInteger butnTag = button.tag - 200;
        [buttonSelectArr addObject:[NSString stringWithFormat:@"%ld",butnTag]];
        
        DLog(@"-----单项选择的按钮：%@",buttonSelectArr);
        [self upData];
        
        
        if (isBack) {
            if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] >= questionNum-1) {
                [butnStatesList replaceObjectAtIndex:questionNum-1 withObject:buttonSelectArr];
            }
            if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] == questionNum-1){
                isBack = NO;
                [User_Default removeObjectForKey:@"REPLACELOCTION"];
            }
            
        }else{
            [butnStatesList addObject:buttonSelectArr];
        }
        DLog(@"单选：%ld+++%@",butnStatesList.count,butnStatesList);
        
    }
    /*
    if (isBack) {
        if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] >= questionNum-1) {
            [butnStatesList replaceObjectAtIndex:questionNum-1 withObject:buttonSelectArr];
        }
        if ([[User_Default objectForKey:@"REPLACELOCTION"] integerValue] == questionNum-1){
            isBack = NO;
            [User_Default removeObjectForKey:@"REPLACELOCTION"];
        }
        
    }else{
        [butnStatesList addObject:buttonSelectArr];
    }
    
    DLog(@"%ld+++%@",butnStatesList.count,butnStatesList);
    */
    
}

-(void)upButtonSate
{
    if (butnStatesList.count > 0) {
        
        if (butnStatesList.count != questionNum) {
            
            NSArray *buttonState = butnStatesList[questionNum];
            
            for (int i = 0; i < buttonState.count; i ++) {
                NSInteger butnTag = [buttonState[i] integerValue];
                UIButton *butn = (UIButton *)buttonArr[butnTag];
                butn.selected = YES;
            }
            
        }
        
    }

}

-(void)upData
{
    if (questionNum < titleList.count-1) {
        questionNum = questionNum + 1;
        type = typeList[questionNum];
        
        [_bgImageView removeFromSuperview];
        [self initUIQuestion:titleList[questionNum] selectList:nameList[questionNum]];
    
    }else{
        DLog(@"*********结束******");
        
        NSMutableDictionary *dic_type = [NSMutableDictionary dictionary];
        for (int i = 0; i < butnStatesList.count; i ++) {
            NSArray *arr_typeIndex = butnStatesList[i];
            NSArray *arr_typeId = idList[i];
            NSString *type_name = typeAllList[i];
            NSMutableArray *dicArr = [NSMutableArray array];
            
            //DLog(@"选择的下表：%ld----%@",arr_typeIndex.count ,arr_typeIndex);
            for (int i = 0; i < arr_typeIndex.count; i ++) {
                
                NSString *index = arr_typeIndex[i];
                NSDictionary *dicId = arr_typeId[[index integerValue]];
                [dicArr addObject:dicId];
                
            }
            //DLog(@"添加的数据：%@",dicArr);
            [dic_type setObject:dicArr forKey:type_name];
        }
        
        //DLog(@"%@",dic_type);
        [self ObjectDataTypeToJsonStr:dic_type];
    }
}

-(void)ObjectDataTypeToJsonStr:(id)object
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:object options:kNilOptions error:nil];
    NSString *JsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"JsonString转化数据:%@",JsonString);
    
    NewRegistViewController *NewRegistVC = [[NewRegistViewController alloc] init];
    NewRegistVC.JsonQuestionStr = JsonString;
    [self pushToNextViewController:NewRegistVC];
}

-(void)leftButtonAction
{
    if (questionNum != 0) {
        
        questionNum = questionNum - 1;
        type = typeList[questionNum];
        
        [_bgImageView removeFromSuperview];
        [self initUIQuestion:titleList[questionNum] selectList:nameList[questionNum]];
        
        
        if (!isBack) {
            [User_Default setObject:[NSString stringWithFormat:@"%ld",questionNum] forKey:@"REPLACELOCTION"];
            [User_Default synchronize];
        }
        
        isBack = YES;
        [self upButtonSate];
        
    }else if (questionNum == 8){
        //[butnStatesList addObject:buttonSelectArr];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 获取网络数据
-(void)getNetData{
    
    typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    DLog(@"%@",UG_selectQuestionListAll_URL);
    
    [HttpClientManager postAsyn:UG_selectQuestionListAll_URL params:params success:^(id json) {
        
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            [QuestionDataModel mj_setupObjectClassInArray:^NSDictionary *{
                return @{
                         @"content":@"SelectContentModel"
                         };
            }];
            
            NSArray *questionList = [QuestionDataModel mj_objectArrayWithKeyValuesArray:json[@"body"][@"questionList"]];

            
            titleList = [NSMutableArray array];
            typeList  = [NSMutableArray array];
            typeAllList = [NSMutableArray array];
            nameList    = [NSMutableArray array];
            nameDicList = [NSMutableArray array];
            
            idList = [NSMutableArray array];
            
            if (questionList) {
                for (QuestionDataModel *model in questionList) {
                    [titleList addObject:model.title];
                    [typeList addObject:model.selectType];
                    [typeAllList addObject:model.type];
                    NSMutableArray *subNameList = [NSMutableArray array];
                    //NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    NSMutableDictionary *subNameDic = [NSMutableDictionary dictionary];
                    NSMutableArray      *subIdArr = [NSMutableArray array];
                    for (SelectContentModel *content in model.content) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                        [subNameList addObject:content.name];
                        [dic setObject:content.anId forKey:@"anId"];
                        [subNameDic setObject:dic forKey:content.name];
            
                        [subIdArr addObject:dic];
                    }
                    [nameList addObject:subNameList];
                    [nameDicList addObject:subNameDic];
                    
                    [idList addObject:subIdArr];
                }
                
                //DLog(@"问题：%@",titleList);
                //DLog(@"选择项：%@",typeAllList);
                //DLog(@"选择对应id：%@",idList);
                //DLog(@".....");
                
                type = typeList[questionNum];
                [self initUIQuestion:titleList[questionNum] selectList:nameList[questionNum]];
            }
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [weakSelf showSVErrorString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时, 请稍后再试！"];
    }];
    
}




#pragma mark --  导航条隐藏后的左侧按钮
-(void)hiddenNavigationNeedLeftBackButtonImageName:(NSString *)imagename
{
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:12];
    leftButton.frame = CGRectMake(10, 30, 30, 20);
    [leftButton setImage:[UIImage imageNamed:imagename] forState:UIControlStateNormal];
    
    
    [leftButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_bgImageView addSubview:leftButton];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
