//
//  UGAdvanCancleReasonViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAdvanCancleReasonViewController.h"
#import "UGMyScheduleViewController.h"
@interface UGAdvanCancleReasonViewController ()<UITextViewDelegate>
{
    NSArray *reasonArr;
    NSArray *reasonIdArr;
    NSString *advanceReasonId;
    NSString * reasonStr;
}

@property (nonatomic,strong)UITextView *resonText;
@property (nonatomic,strong)UIView *groundView;
@property (nonatomic,strong)UIButton *subButn;

@end

@implementation UGAdvanCancleReasonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    [self setCustomTitle:@"请选择取消的理由"];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Show:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboard_Hidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [self KgetNetData];
    
    //[self initUI];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}


-(void)KgetNetData{
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"token"] = kToken;
    
    [HttpClientManager postAsyn:UG_advanceReasonList_URL params:params success:^(id json) {
        NSLog(@"%@",json);
        AssistantsService *service=[[AssistantsService alloc] init];
        MsgModel *msg=(MsgModel *)[service getHeaderMsgWithDict:json[@"header"]];
        
        if ([msg.code isEqualToString:@"200"]) {
            
            NSArray *reasonList = json[@"body"][@"reasonList"];
            NSMutableArray *resonArray = [NSMutableArray array];
            NSMutableArray *resonIdArray = [NSMutableArray array];
            for (NSDictionary *dic in reasonList) {
                [resonArray addObject:dic[@"reason"]];
                [resonIdArray addObject:dic[@"advanceReasonId"]];
            }
    
            reasonIdArr = resonIdArray;
            [self initUI:resonArray];
            
        }else if ([msg.code isEqualToString:@"400"]) {
            [self showSVString:msg.message];
        }
        
    } failure:^(NSError *error) {
        [weakSelf showSVErrorString:@"网络请求超时，请稍后再试！"];
    }];

}

-(void)KSubmit{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"token"] = kToken;
    params[@"advanceId"] =self.advanceId;
    if (_resonText.text.length < 1) {
        params[@"reason"] =[NSString stringWithFormat:@"%@",_resonText.text];
    }else{
        //params[@"reason"] =[NSString stringWithFormat:@"%@。%@",reasonStr,_resonText.text];
        params[@"reason"] =[NSString stringWithFormat:@"%@",reasonStr];

    }
    
    typeof(self)  weakSelf = self;
    NSLog(@"%@",params);
    [SVProgressHUD show];
    [HttpClientManager getAsyn:cancelAdvanceClient params:params success:^(id json) {
        MsgModel * msgmodel = [MsgModel mj_objectWithKeyValues:json[@"header"]];
        NSLog(@"%@",msgmodel.code);
        [SVProgressHUD dismiss];
        if ([msgmodel.code isEqualToString:@"200"]) {
            
            [weakSelf showSVSuccessWithStatus:msgmodel.message];
            UGMyScheduleViewController * vc = [[UGMyScheduleViewController alloc]init];
            
            vc.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if ([msgmodel.code isEqualToString:@"400"]){
            [weakSelf showSVSuccessWithStatus:msgmodel.message];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [weakSelf showSVSuccessWithStatus:@"网络错误"];
    }];
}


-(void)initUI:(NSArray *)array
{
    //reasonArr = @[@"时间冲突",@"临时有事",@"时间选错啦",@"与顾问联系后取消",@"其它原因：填写详情"];
    reasonArr = array;
    
    _groundView = [[UIView alloc] init];
    _groundView.frame = CGRectMake(0, 12, kScreenWidth, kScreenHeight);
    _groundView.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTouch)];
    [_groundView addGestureRecognizer:tap];
    [self.view addSubview:_groundView];
    
    
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 53*reasonArr.count);
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [_groundView addSubview:backGroundView];
    
    

    for (int i = 0; i < reasonArr.count; i ++) {
        
        UIView *line =[[UIView alloc]initWithFrame:CGRectMake(22, 53+i*53, kScreenWidth, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [backGroundView addSubview:line];
        
        UILabel *title =[[UILabel alloc]initWithFrame:CGRectMake(22, 0+i*53, kScreenWidth-100, 53)];
        title.text = reasonArr[i];
        title.font = [UIFont systemFontOfSize:15];
        title.textColor = [UIColor colorWithHexString:@"5c5c5c"];
        [backGroundView addSubview:title];
        
        UIButton *seleButn = [UIButton buttonWithType:UIButtonTypeCustom];
        seleButn.frame = CGRectMake(kScreenWidth-41, 15+i*53, 20, 20);
        seleButn.tag = 100 + i;
        [seleButn setImage:[UIImage imageNamed:@"button_noSelect"] forState:UIControlStateNormal];
        [seleButn setImage:[UIImage imageNamed:@"pay_select"] forState:UIControlStateSelected];
        [seleButn addTarget:self action:@selector(clickSeleButn:) forControlEvents:UIControlEventTouchUpInside];
        [backGroundView addSubview:seleButn];
        
    }
    
    
    UIView *backTextView = [[UIView alloc] init];
    backTextView.frame = CGRectMake(0, backGroundView.bottom+13, kScreenWidth, 116);
    backTextView.backgroundColor = [UIColor whiteColor];
    backTextView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [_groundView addSubview:backTextView];
    
    _resonText =[[UITextView alloc]  init];
    _resonText.frame = CGRectMake(15, 0, kScreenWidth-30, 116);
    _resonText.font = [UIFont systemFontOfSize:14];
    _resonText.text = @"请填写取消理由 1~25 个字";
    _resonText.editable = NO;
    _resonText.delegate = self;
    _resonText.textColor = [UIColor colorWithHexString:@"b7b7b7"];
    [backTextView addSubview:_resonText];
    
    
    _subButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _subButn.frame = CGRectMake(0, kScreenHeight-44-64, kScreenWidth, 44);
    _subButn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_subButn setTitle:@"提交" forState:UIControlStateNormal];
    [_subButn setBackgroundColor:[UIColor colorWithHexString:@"26bdab"]];
    [_subButn addTarget:self action:@selector(clickSubButn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_subButn];
    
}

-(void)clickSubButn
{
    //DLog(@"点击提交按钮:%@",_resonText.text);
    //[self showSVString:[NSString stringWithFormat:@"点击提交按钮:%@",_resonText.text]];
    if (advanceReasonId) {
        [self KSubmit];
    }
}

-(void)clickSeleButn:(UIButton *)button
{
    for (int i = 0; i < reasonArr.count ; i ++) {
        UIButton *temButn = (UIButton *)[self.view viewWithTag:100+i];
        temButn.selected = NO;
    }
    button.selected = YES;
    
    if (button.tag == 100 + reasonArr.count - 1) {
        _resonText.editable = YES;
    }else{
        _resonText.editable = NO;
        [self.view endEditing:YES];
    }
    
    advanceReasonId = [NSString stringWithFormat:@"%ld",button.tag - 100 ];
    
    
    int advanceReasonIdint = [advanceReasonId intValue];
    reasonStr = reasonArr[advanceReasonIdint];
    
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    return YES;
}

-(void)tapTouch
{
    [self.view endEditing:YES];
}


#pragma mark -监听键盘的升降
- (void)keyboard_Show:(NSNotification *)nf {
    //获取键盘的高度
    NSDictionary *info = [nf userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    if (keyboardSize.height > 200) {
        
        [UIView animateWithDuration:0.25 animations:^{
            if (kScreenHeight < 660) {
                _groundView.frame = CGRectMake(0, -140, kScreenWidth, kScreenHeight);
            }else{
                _groundView.frame = CGRectMake(0, -70, kScreenWidth, kScreenHeight);
            }
        } completion:^(BOOL finished) {
        }];
    }
    
}
- (void)keyboard_Hidden:(NSNotification *)nf {
    
    [UIView animateWithDuration:0.25 animations:^{
    } completion:^(BOOL finished) {
        _groundView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
