//
//  EditTextViewController.m
//  UrgooApp
//
//  Created by admin on 16/3/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "EditTextViewController.h"

@interface EditTextViewController ()<UITextViewDelegate,UIAlertViewDelegate>
@property(strong,nonatomic)UITextView *textView;
@property(strong,nonatomic)UILabel *placeHolderLabel;
@property(strong,nonatomic)UILabel *numLabel;
@property(strong,nonatomic)UIButton *saveBtn;
@end

@implementation EditTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (_fromType ==100) {
        [self setCustomTitle:@"意见反馈"];
    }
    
    self.view.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];

    [self initUI];
}
#pragma mark - initUI
-(void)initUI
{
    _textView =[[UITextView alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 100)];
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 5;
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _placeHolderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 100, 30)];
    _placeHolderLabel.text = @"请输入...";
    _placeHolderLabel.font = [UIFont systemFontOfSize:12];
    _placeHolderLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_placeHolderLabel];
    
    _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textView.width-65, _textView.height-30, 60, 30)];
    _numLabel.textAlignment = NSTextAlignmentRight;
    _numLabel.text = @"0/100";
    _numLabel.font = [UIFont systemFontOfSize:12];
    _numLabel.textColor = [UIColor lightGrayColor];
    [_textView addSubview:_numLabel];
    
    _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveBtn.frame = CGRectMake(30, _textView.y+_textView.height+20, kScreenWidth-60, 40);
    _saveBtn.layer.masksToBounds = YES;
    _saveBtn.layer.cornerRadius = 5;
    [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveBtn setBackgroundColor:RGB(37, 175, 153)];
    [_saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    _saveBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_saveBtn];

}
-(void)saveAction
{
    if (_fromType==100) {
        //post feedbackMessage
        DLog(@"------------->意见反馈");
    }
    
    DLog(@"保存信息");
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    [_textView becomeFirstResponder];
    DLog(@"文本开始编辑");
    _placeHolderLabel.hidden = YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    DLog(@"文本在变化");
    _numLabel.text = [NSString stringWithFormat:@"%d/100",100-(int)textView.text.length];
    
    if (textView.text.length >= 100) {
        [UGAlertView showAlert:@"提醒" title:@"您输入的文字已经超过了100个字" cancleTitle:@"取消" okTitle:@"确定" delegate:self];
        _textView.text = [textView.text substringToIndex:100];
         _numLabel.text = [NSString stringWithFormat:@"0/100"];
    }else if (textView.text.length ==0){
        _placeHolderLabel.hidden = NO;
    }
    
    DLog(@"==%d",(int)textView.text.length);
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex ==1) {
        DLog(@"确定");
    }else{
        DLog(@"取消");
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
     DLog(@"文本结束编辑");
    
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
