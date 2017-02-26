//
//  UGSanfangAgreementViewController.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/16.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSanfangAgreementViewController.h"
#import "UgComordViewController.h"
#import "OrderInfoModel.h"
@interface UGSanfangAgreementViewController ()<UITextViewDelegate>
@property (strong,nonatomic) UIScrollView * scrollView;
@property (assign,nonatomic) CGFloat  totlehight;

@property (strong,nonatomic) OrderInfoModel * orderModel;
@property (strong,nonatomic)  UITextView * textView;
@property (strong,nonatomic)  UITextField * paraentName;
@property (strong,nonatomic)  UITextField * studentName;
@property (strong,nonatomic)  UITextField * paraentIdcard;
@property (strong,nonatomic)  UITextField * studentIdcard;
@property (strong,nonatomic)  UITextField * phoneNumber;
@property (strong,nonatomic)  UITextField * emlNumber;
@property (strong,nonatomic)   NSArray * main_body;
@property (strong,nonatomic)  NSArray * main_body1;
@property (strong,nonatomic) NSString * firstStr;
@property (strong,nonatomic) NSString * twoStr;
@property (strong,nonatomic) NSString * thereoStr;
@property (strong,nonatomic) NSString * fourStr;
@property (strong,nonatomic) UILabel * placeholderStr;
@property (strong,nonatomic) NSArray * Aarray;
@property (strong,nonatomic) NSArray * Barray;
@end

@implementation UGSanfangAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"三方协议"];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenHeight, kScreenHeight - 64 - 44)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    
    
    [self addTapGestureOnView:_scrollView target:self selector:@selector(call_back_tap)];
    [self.view addSubview:_scrollView];

    
    
    UIButton  * button  = [[UIButton alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 , kScreenWidth, 44)];
    
    
    button.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [button setTitle: @"同意" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [button addTarget:self action:@selector(click_sanfangBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    
    [self loadrequest];
    [self setNewUI:3];
   
    
}
-(void)loadrequest{
    
    NSMutableDictionary * pramas = [NSMutableDictionary dictionary];
    
    pramas[@"token"] = kToken;
    pramas[@"serviceId"] = self.serviceid;
    pramas[@"counselorId"] =self.counselorId;
    
    NSLog(@"%@  %@ %@",pramas[@"token"],pramas[@"serviceId"],pramas[@"counselorId"]);
    [HttpClientManager getAsyn:UG_confirmService_URL params:pramas success:^(id json) {
        
        
        NSLog(@"%@",json);
        if ([json[@"header"][@"code"] isEqualToString:@"200"]) {
            
            _orderModel = [OrderInfoModel mj_objectWithKeyValues:json[@"body"][@"orderInfo"]];
            
            //[self setViewDtl:_orderModel];
            
             [self setUpUI];
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    

    
    
    
    
}
-(void)setNewUI:(CGFloat ) number{
    
    
    
    
    CGFloat spacing = ((kScreenWidth - 60) - 4* 50)/3;
    
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    
    
    CGFloat testNumber= number;
    
    [_scrollView addSubview:headView];
    NSArray * array = @[@"具体服务",@"支付保障",@"三方协议",@"订单",@"付款"];
    for (int i = 0; i<4; i++) {
        UILabel * titilelable = [[UILabel alloc]initWithFrame:CGRectMake(30+ i * (50 + spacing), 10, 50, 20)];
        
        
        //titilelable.backgroundColor = [UIColor blueColor];
        titilelable.tag = 10 +i;
        
        titilelable.text = array[i];
        titilelable.font = [UIFont systemFontOfSize:12];
        [headView addSubview:titilelable];
        
        
        UIButton * cycleView = [[UIButton alloc]initWithFrame:CGRectMake(titilelable.origin.x + 16, titilelable.bottom +10, 18, 18)];
        cycleView.layer.borderWidth = 1.0f;
        cycleView.layer.borderColor = [RGB(153, 153, 153) CGColor];
        NSString * btnStr = [NSString stringWithFormat:@"%d",i+1];
        cycleView.tag  = 20 +i;
        cycleView.titleLabel.font = [UIFont systemFontOfSize:10];
        cycleView.layer.cornerRadius = 9;
        [cycleView setTitle:btnStr forState:UIControlStateNormal];
        [cycleView setTitleColor:RGB(153, 153, 153)  forState:UIControlStateNormal];
        cycleView.backgroundColor = [UIColor clearColor];
        [headView addSubview:cycleView];
        
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(cycleView.origin.x + cycleView.size.width   , cycleView.bottom - cycleView.size.height/2 -1, 50 + spacing - cycleView.size.width, 2)];
        
        lineView.tag = 30+i;
        
        lineView.backgroundColor  =RGB(153, 153, 153);
        
        if (i<3) {
            
            [headView addSubview:lineView];
            
            
            
            
            
            
            
        }
        
        if (i<testNumber) {
            titilelable.textColor = [UIColor colorWithHexString:@"#26bdab"];
            cycleView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
            [cycleView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            cycleView.layer.borderColor = [UIColor colorWithHexString:@"#26bdab"].CGColor;
            
        }
        if (i<(testNumber-1)) {
            
            lineView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        }
        
        
        
        
    }
    
    
    
    
}


-(void)setUpUI{
    
    UILabel * testlable = [[UILabel alloc]init];
//    testlable.text = @"协议编号:
//    
//    海外教育信息咨询服务三方协议
//    
//    本海外教育信息咨询服务协议三方协议（以下称“三方协议”）由下列三方在2016年____月_____日签订。
//    ";
    
    NSString * orderTime = _orderModel.orderTime;
    
    
    
    NSString * testStr =[orderTime substringToIndex:10];
    // 截取 下标之后的字符串
    NSString * monthstr =  [testStr substringFromIndex:5];
    NSString * month= [monthstr substringToIndex:2];
     // 截取 下标之前的字符串
     NSString * str1 =  [testStr substringToIndex:4];
    NSString * dayStr=[testStr substringFromIndex:8];
    NSLog(@"%@",month);
    NSLog(@"%@",str1);
    NSLog(@"%@",dayStr);
    testlable.text =[NSString stringWithFormat:@"协议编号:\n\n海外教育信息咨询服务三方协议\n\n本海外教育信息咨询服务协议三方协议（以下称“三方协议”）由下列三方在 %@ 年 %@ 月 %@ 日签订。",str1,month,dayStr];
    _firstStr = testlable.text;
    testlable.font = [UIFont systemFontOfSize:13];
    testlable.numberOfLines = 0;
    CGRect rect = [testlable.text boundingRectWithSize:CGSizeMake(kScreenWidth, 1000)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:testlable.font}  context:nil];
    
    testlable.frame = CGRectMake(10, 64, kScreenWidth -20, rect.size.height);
    [_scrollView addSubview:testlable];
    
    _Aarray = @[@"乙方:",@"护照或身份证号:",@"联系地址:",@"联系电话:",@"电子邮件:"];
      NSArray * Aarray1 = @[@"请输入家长姓名:",@"输入护照或身份证号:",@"输入联系地址:",@"输入联系电话:",@"输入电子邮件:"];
    _Barray = @[@"甲方:",@"护照或身份证号:",@"联系地址:",@"联系电话:",@"电子邮件:"];
//    NSArray * Barray1 = @[@"请输入家长姓名和学生姓名:",@"输入护照或身份证号:",@"输入联系地址:",@"输入联系电话:",@"输入电子邮件:"];
    NSArray * Carray = @[@"丙方：上海畅航信息科技有限公司",@"联系地址：淮海西路570号红坊C3-202室",@"联系电话:  021-61157323",@"电子邮件：customer@urgoo.cn"];
    _fourStr = @"";
    for (int i = 0; i<4; i++) {
        
        
        NSString  * four = [NSString stringWithFormat:@"%@\n",Carray[i]];
        _fourStr = [_fourStr stringByAppendingString:four];
        
        
    }
    
    _totlehight = testlable.bottom +14;
    _twoStr = @"";
   
    for (int i = 0; i<5; i++) {
        
        if (i ==0) {
            
            CGSize size = [_Barray[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
            UILabel * lable1 = [[UILabel alloc]init];
            lable1.font = [UIFont systemFontOfSize:15];
            lable1.text = _Barray[i];
            lable1.frame = CGRectMake(10, _totlehight +14, size.width +3, 15);
            
            [_scrollView addSubview:lable1];
            
            
            _paraentName = [[UITextField alloc]init];
            _paraentName.placeholder = Aarray1[i];
            //        textField.layer.borderWidth = 0.5;
            //        textField.layer.borderColor = [UIColor grayColor].CGColor;
            _paraentName.font = [UIFont systemFontOfSize:13];
            _paraentName.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, (kScreenWidth-lable1.origin.x - lable1.size.width +5)*0.5 - 20, 25);
            
            [_scrollView addSubview:_paraentName];
 
            
           _studentName = [[UITextField alloc]init];
            _studentName.placeholder = @"请输入学生姓名";
            //        textField.layer.borderWidth = 0.5;
            //        textField.layer.borderColor = [UIColor grayColor].CGColor;
            _studentName.font = [UIFont systemFontOfSize:13];
            _studentName.frame = CGRectMake(_paraentName.origin.x + _paraentName.size.width +15, lable1.y - 5, (kScreenWidth-lable1.origin.x - lable1.size.width +5)*0.5 - 20, 25);
            
            [_scrollView addSubview:_studentName];

            
            
            _totlehight = _studentName.bottom ;
            
            
            
        }else if(i ==1){
            
            CGSize size = [_Barray[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
            UILabel * lable1 = [[UILabel alloc]init];
            lable1.font = [UIFont systemFontOfSize:15];
            lable1.text = _Barray[i];
            lable1.frame = CGRectMake(10, _totlehight, size.width +3, 15);
            
            [_scrollView addSubview:lable1];
            
            
            _paraentIdcard= [[UITextField alloc]init];
            _paraentIdcard.placeholder = @"请输入家长身份证号";
            //        textField.layer.borderWidth = 0.5;
            //        textField.layer.borderColor = [UIColor grayColor].CGColor;
            _paraentIdcard.font = [UIFont systemFontOfSize:13];
            _paraentIdcard.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, kScreenWidth-lable1.origin.x - lable1.size.width +5, 25);
            
            [_scrollView addSubview:_paraentIdcard];
            _studentIdcard = [[UITextField alloc]init];
            _studentIdcard.placeholder = @"请输入学生身份证号";
            //        textField.layer.borderWidth = 0.5;
            //        textField.layer.borderColor = [UIColor grayColor].CGColor;
            _studentIdcard.font = [UIFont systemFontOfSize:13];
            _studentIdcard.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, _paraentIdcard.bottom +3, kScreenWidth-lable1.origin.x - lable1.size.width +5, 25);
            
            [_scrollView addSubview:_studentIdcard];
           _totlehight = _studentIdcard.bottom  ;
        }else {
            CGSize size = [_Barray[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
            UILabel * lable1 = [[UILabel alloc]init];
            lable1.font = [UIFont systemFontOfSize:15];
            lable1.text = _Barray[i];
            lable1.frame = CGRectMake(10, _totlehight , size.width +3, 15);
            
            [_scrollView addSubview:lable1];
            
            if (i ==2) {
                
                _textView = [[UITextView alloc]init];
              
                //        textField.layer.borderWidth = 0.5;
                //        textField.layer.borderColor = [UIColor grayColor].CGColor;
                
                _textView.font = [UIFont systemFontOfSize:13];
                _textView.delegate = self;
                _textView.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, (kScreenWidth-lable1.origin.x - lable1.size.width +5) - 20, 40);
                
                [_scrollView addSubview:_textView];
               _placeholderStr = [[UILabel alloc]init];
                _placeholderStr.text = @"请输入地址:";
                
                CGSize size1 = [ _placeholderStr.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil]];
                _placeholderStr.textColor = RGB(201, 201, 205);
                _placeholderStr.font = [UIFont systemFontOfSize:13];
                _placeholderStr.textAlignment = NSTextAlignmentLeft;
                _placeholderStr.frame =CGRectMake(_textView.origin.x +3, _textView.origin.y +8, size1.width, 14);
                [_scrollView addSubview:_placeholderStr];

                
                _totlehight = _textView.bottom;
            }else{
                if (i==3) {
                   _phoneNumber = [[UITextField alloc]init];
                    _phoneNumber.placeholder = Aarray1[i];
                    _phoneNumber.tag = 995 +i;
                    //        textField.layer.borderWidth = 0.5;
                    //        textField.layer.borderColor = [UIColor grayColor].CGColor;
                    
                    _phoneNumber.font = [UIFont systemFontOfSize:13];
                    _phoneNumber.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, kScreenWidth-lable1.origin.x - lable1.size.width +5, 25);
                    
                    [_scrollView addSubview:_phoneNumber];
                     _totlehight = _phoneNumber.bottom ;

                }else{
                    
                 _emlNumber = [[UITextField alloc]init];
                    _emlNumber.placeholder = Aarray1[i];
                    _emlNumber.tag = 995 +i;
                    //        textField.layer.borderWidth = 0.5;
                    //        textField.layer.borderColor = [UIColor grayColor].CGColor;
                    
                    _emlNumber.font = [UIFont systemFontOfSize:13];
                    _emlNumber.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, kScreenWidth-lable1.origin.x - lable1.size.width +5, 25);
                    
                    [_scrollView addSubview:_emlNumber];
                    _totlehight = _emlNumber.bottom ;
                }

                
                
                
            }
            
        }
        _totlehight += 14 ;
        
    }
    _twoStr = @"";
    for (int i = 0; i<5; i++) {
               UILabel * lable1 = [[UILabel alloc]init];
        lable1.font = [UIFont systemFontOfSize:15];
        if (i ==0) {
           lable1.text = [NSString stringWithFormat:@"%@  %@",_Aarray[i],_orderModel.enName];
        }else{
            
            lable1.text = _Aarray[i];
        }
        CGSize size = [ lable1.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];

        lable1.frame = CGRectMake(10, _totlehight +14, size.width +3, 15);
        
        [_scrollView addSubview:lable1];
        
        
        _totlehight = lable1.bottom ;
        NSLog(@"%f",_totlehight);
        
        NSString * str = [NSString stringWithFormat:@"%@\n",lable1.text];
        _twoStr = [_twoStr stringByAppendingString:str];
        
    }
    _totlehight = _totlehight + 14;

    _totlehight = _totlehight + 14;
    for (int i = 0; i<4; i++) {
        CGSize size = [Carray[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil]];
        UILabel * lable1 = [[UILabel alloc]init];
        lable1.font = [UIFont systemFontOfSize:15];
        lable1.text = Carray[i];
        lable1.frame = CGRectMake(10, _totlehight +14, size.width +3, 15);
        
        [_scrollView addSubview:lable1];
        
        
//        UITextField * textField = [[UITextField alloc]init];
//        textField.placeholder = Aarray1[i];
////        textField.layer.borderWidth = 0.5;
////        textField.layer.borderColor = [UIColor grayColor].CGColor;
//        textField.font = [UIFont systemFontOfSize:13];
//        textField.frame = CGRectMake(lable1.origin.x + lable1.size.width +5, lable1.y - 5, kScreenWidth-lable1.origin.x - lable1.size.width +5, 25);
//        
//        [_scrollView addSubview:textField];
         _totlehight = lable1.bottom ;
        NSLog(@"%f",_totlehight);
        
    }

   //条款内容
    UILabel * titleLable = [[UILabel alloc]init];
    
    titleLable.text = @"鉴于：\n\n1.上海畅航信息科技有限公司是一家在中国境内合法注册并具备独立经营资格的企业法人，负责运营优顾全球留学顾问共享平台（以下简称“优顾平台”）。\n\n2. 甲方是提供有偿海外教育信息咨询服务（以下简称“咨询服务”）的自然人\n\n3. 乙方是通过优顾平台与甲方签订本协议的付费客户。\n\n4. 甲方为乙方指定的留学对象（以下简称“留学对象”）提供本协议约定的服务。\n\n依据《中华人民共和国合同法》及相关法律的规定，经由丙方撮合，甲乙双方友好协商，就甲方向乙方提供咨询服务事宜，达成如下条款：\n\n";
    
    CGFloat hight = [self getHeightWithContent:titleLable.text width:kScreenWidth -20 font:13];
    
    titleLable.numberOfLines = 0;
    titleLable.font = [UIFont systemFontOfSize:13];
    
    titleLable.frame = CGRectMake(10, _totlehight +30, kScreenWidth -20, hight);
    
    
    
    [_scrollView addSubview:titleLable];
    
    
    _totlehight = titleLable.bottom;
    
    //  正文
    NSString * picestr = _orderModel.servicePrice;
    
    NSString * daxiepicestr = [self changetochinese:picestr];
    
    NSString * sixStr = [NSString stringWithFormat:@"第一条 乙方应向甲方支付咨询服务费为人民币      %@     元（大写：      %@        ）。\n\n本协议所收取的留学服务费，不包括考试注册费、学校申请费、国际快递费、英文成绩寄送费、公证费、翻译费、护照办理申请费、领馆签证申请费、体检费、学校定金以及学杂费等支付给第三方的费用。上述费用均由乙方按时足额自行向第三方机构支付。\n\n第二条 乙方须在本协议签订后5个工作日向丙方支付全额咨询服务费用。\n\n收款账号信息如下：\n\n户名：上海畅航信息科技有限公司\n\n开户行：平安银行上海分行营业部\n\n账号：11015028780004\n\n",picestr,daxiepicestr];
     _main_body = @[@"第一章 服务基本条款",@"第二章 服务内容",@"第三章 甲方的权利和义务",@"第四章 乙方的权利和义务",@"第五章   丙方的权利和义务",@"第六章 整体服务费用和支付方式",@"第七章 违约责任",@"第八章  协议生效及期限",@"第九章 法律适用及争议解决",@"第十章  补充条款",@"\n\n",@"\n\n",@"\n\n"];
    
    _main_body1 = @[@"第一条 甲乙双方仅在本协议规定的咨询服务上存在双方约定的法律关系，甲方不对留学对象与申请的海外院校之间发生的任何纠纷负责，不对留学对象留学后的人身等合法权益承担任何直接或连带责任。\n\n第二条 甲方为留学对象在准备留学过程中提出专业建议，制定个性化的留学规划方案，指导留学对象确定合理的留学目标并进行准备。\n\n",@"甲方为留学对象提供的咨询服务包含以下基本服务项目，并遵守工作内容规范（见附件一）。\n\n",@"第一条  甲方有权要求乙方或留学对象提供真实信息和资料。\n\n第二条  甲方为留学对象制定个性化的留学方案。\n\n第三条  甲方根据留学对象的执行进度和效果进行评估，并与乙方或留学对象进行沟通，对留学方案进行调整。\n\n第四条 甲方对留学对象的个人信息和申请材料保密。\n\n",@"第一条 乙方或留学对象应提供真实信息。\n\n第二条 乙方对录取结果有最终选择权。\n\n第三条 乙方对甲方提供的未在公开媒体上发布的资料和信息进行保密。\n\n",@"第一条 丙方有权督促甲方及时履行本协议所承诺的服务项目。\n\n第二条 当乙方对甲方所提供的服务提出书面投诉后，丙方有权决定是否启动调查流程，调查流程可能导致以下结果：\n\n1丙方认为甲方没有违约责任。\n\n2丙方认为甲方没有违约责任，但是在服务提供过程中存在瑕疵，要求甲方提高服务质量。\n\n3丙方认为甲方存在违约责任，要求甲方立刻采取措施改正，同时此违约责任将录入甲方在优顾平台的信用档案。\n\n4丙方认为甲方存在重大违约责任，有权暂停支付剩余的款项。\n\n第三条 咨询服务费监管\n\n丙方应在整个服务过程中，对乙方缴纳的海外教育信息咨询服务费（以下简称“咨询服务费”） 进行监管并按照“服务费用支付时间表”支付给甲方。\n\n",sixStr,@"第一条  甲方在本协议有效期内，若决定终止为乙方提供咨询服务，必须以书面形式通知丙方，并接受丙方调查服务过程。若无约定原因或者法定理由终止为乙方提供咨询服务，则甲方需向乙方赔偿咨询服务费用两倍的金额。\n\n第二条  乙方中途放弃留学计划，乙方支付的咨询服务费不予退还，本协议自行终止。\n\n",@"本协议自甲方、乙方、丙方签字或盖章后生效。 服务期从   年   月   日   至    年    月    日截止。本协议一式三份，具有同等法律效力。",@"第一条  本协议的效力、解释、履行、变更、解除和争议解决均适用中国法律任何由于本协议解释和履行所产生的争议应当首先通过三方协商解决。协商不成的，任一方有权向丙方所在地的人民法院提起诉讼。\n\n",@"__________\n\n",@"甲方：                （签字）",@"乙方：                （签字）",@"丙方：上海畅航信息科技有限公司（盖章）"];
    
    _totlehight = _totlehight + 30;
    for (int i = 0; i <10; i++) {
        UILabel * main_bodylable = [[UILabel alloc]init];
        main_bodylable.text= _main_body[i];
        main_bodylable.font = [UIFont systemFontOfSize:17 weight:0.1];
        
       // CGSize size = [ main_bodylable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
        main_bodylable.frame = CGRectMake(10, _totlehight  , kScreenWidth-20,20 );
        [_scrollView addSubview:main_bodylable];
        
        UILabel * main_bodylable1 = [[UILabel alloc]init];
        main_bodylable1.text= _main_body1[i];
        main_bodylable1.numberOfLines = 0;
        main_bodylable1.font = [UIFont systemFontOfSize:13];
        main_bodylable1.textColor = [UIColor colorWithHexString:@"#666666"];
        CGFloat hight1 = [self getHeightWithContent: main_bodylable1.text width:kScreenWidth-20 font:13];
        // CGSize size = [ main_bodylable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:17],NSFontAttributeName, nil]];
        main_bodylable1.frame = CGRectMake(10, main_bodylable.bottom + 20 , kScreenWidth-20,hight1 );
        [_scrollView addSubview:main_bodylable1];

        _totlehight = main_bodylable1.bottom +20;
    }

    
    UILabel * signjia = [[UILabel alloc]init];
    
    signjia.text = @"甲方:";
    signjia.font = [UIFont systemFontOfSize:17];
    signjia.textColor = [UIColor colorWithHexString:@"#000000"];
    
    signjia.frame = CGRectMake(30, _totlehight +10, 45, 20);
    
    [_scrollView addSubview:signjia];
    //qianming
    
    UILabel * qianming = [[UILabel alloc]init];
    
    qianming.text = @"(签名)";
    qianming.font = [UIFont systemFontOfSize:17];
    qianming.textColor = [UIColor colorWithHexString:@"#666666"];
    
    qianming.frame = CGRectMake(signjia.x + signjia.size.width +120,  _totlehight +10, 60, 20);
    
    [_scrollView addSubview:qianming];
//
    
    
    
    UILabel * signjia1 = [[UILabel alloc]init];
    
    signjia1.text = @"乙方:";
    signjia1.font = [UIFont systemFontOfSize:17];
    signjia1.textColor = [UIColor colorWithHexString:@"#000000"];
    
    signjia1.frame = CGRectMake(30, signjia.bottom +30, 45, 20);
    
    [_scrollView addSubview:signjia1];
    
    UILabel * signjia2 = [[UILabel alloc]init];
    ////
    UILabel * qianming1 = [[UILabel alloc]init];
    
    qianming1.text = @"(签名)";
    qianming1.font = [UIFont systemFontOfSize:17];
    qianming1.textColor = [UIColor colorWithHexString:@"#666666"];
    
    qianming1.frame = CGRectMake(signjia.x + signjia.size.width +120,  signjia.bottom +30, 60, 20);
    
    [_scrollView addSubview:qianming1];

    
    //signjia2.text = @"丙方：上海畅航信息科技有限公司（盖章）";
    //signjia2.font = [UIFont systemFontOfSize:17];
    signjia2.textColor = [UIColor colorWithHexString:@"#000000"];
    [self setAttributedString:@"丙方：" with:@"上海畅航信息科技有限公司（盖章)"and:signjia2];
    signjia2.frame = CGRectMake(30, signjia1.bottom +30, kScreenWidth - 30, 40);
    
    [_scrollView addSubview:signjia2];

    _totlehight = signjia2.bottom +50;
    
    
    
    
    
    
    _scrollView.contentSize = CGSizeMake(0, _totlehight);
}

-(CGFloat)getHeightWithContent:(NSString *)content width:(CGFloat)width font:(CGFloat)font{
    
    CGRect rect = [content boundingRectWithSize:CGSizeMake(width, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}  context:nil];
    return rect.size.height;
    
    
    
}
-(NSString *)changetochinese:(NSString *)numstr
{
    double numberals=[numstr doubleValue];
    NSArray *numberchar = @[@"零",@"壹",@"贰",@"叁",@"肆",@"伍",@"陆",@"柒",@"捌",@"玖"];
    NSArray *inunitchar = @[@"",@"拾",@"佰",@"仟"];
    NSArray *unitname = @[@"",@"万",@"亿",@"万亿"];
    //金额乘以100转换成字符串（去除圆角分数值）
    NSString *valstr=[NSString stringWithFormat:@"%.2f",numberals];
    NSString *prefix;
    NSString *suffix;
    if (valstr.length<=2) {
        prefix=@"零元";
        if (valstr.length==0) {
            suffix=@"零角零分";
        }
        else if (valstr.length==1)
        {
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[valstr intValue]]];
        }
        else
        {
            NSString *head=[valstr substringToIndex:1];
            NSString *foot=[valstr substringFromIndex:1];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[head intValue]],[numberchar objectAtIndex:[foot intValue]]];
        }
    }
    else
    {
        prefix=@"";
        suffix=@"";
        int flag=valstr.length-2;
        NSString *head=[valstr substringToIndex:flag-1];
        NSString *foot=[valstr substringFromIndex:flag];
        if (head.length>13) {
            return@"数值太大（最大支持13位整数），无法处理";
        }
        //处理整数部分
        NSMutableArray *ch=[[NSMutableArray alloc]init];
        for (int i = 0; i < head.length; i++) {
            NSString * str=[NSString stringWithFormat:@"%x",[head characterAtIndex:i]-'0'];
            [ch addObject:str];
        }
        int zeronum=0;
        
        for (int i=0; i<ch.count; i++) {
            int index=(ch.count -i-1)%4;//取段内位置
            int indexloc=(ch.count -i-1)/4;//取段位置
            if ([[ch objectAtIndex:i]isEqualToString:@"0"]) {
                zeronum++;
            }
            else
            {
                if (zeronum!=0) {
                    if (index!=3) {
                        prefix=[prefix stringByAppendingString:@"零"];
                    }
                    zeronum=0;
                }
                prefix=[prefix stringByAppendingString:[numberchar objectAtIndex:[[ch objectAtIndex:i]intValue]]];
                prefix=[prefix stringByAppendingString:[inunitchar objectAtIndex:index]];
            }
            if (index ==0 && zeronum<4) {
                prefix=[prefix stringByAppendingString:[unitname objectAtIndex:indexloc]];
            }
        }
        prefix =[prefix stringByAppendingString:@"元"];
        //处理小数位
        if ([foot isEqualToString:@"00"]) {
            suffix =[suffix  stringByAppendingString:@"整"];
        }
        else if ([foot hasPrefix:@"0"])
        {
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@分",[numberchar objectAtIndex:[footch intValue] ]];
        }
        else
        {
            NSString *headch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:0]-'0'];
            NSString *footch=[NSString stringWithFormat:@"%x",[foot characterAtIndex:1]-'0'];
            suffix=[NSString stringWithFormat:@"%@角%@分",[numberchar objectAtIndex:[headch intValue]],[numberchar objectAtIndex:[footch intValue]]];
        }
    }
    return [prefix stringByAppendingString:suffix];
}



-(void)click_sanfangBtn{


    if (_emlNumber.text.length >0 && _phoneNumber.text.length >0 && _studentIdcard.text.length >0 && _paraentIdcard.text>0 && _studentName.text.length >0 && _paraentName.text.length >0 && _textView.text.length >0) {
        
        NSMutableArray * arraynum = [NSMutableArray array];
        for (NSInteger i = 998; i<1000; i++) {
            UITextField * textfield = (UITextField *)[_scrollView viewWithTag:i];
            
            NSString *str = textfield.text;
            [arraynum addObject:str];
            
        }
        
        _thereoStr = @"";
        NSString * therestr1 = [NSString stringWithFormat:@"%@  %@  %@\n",_Barray[0],_paraentName.text,_studentName.text];
        NSString * therestr2 =[NSString stringWithFormat:@"%@\n  %@\n  %@\n",_Barray[1],_paraentIdcard.text,_studentIdcard.text];
        
        NSString * therestr3 =[NSString stringWithFormat:@"%@ %@\n",_Barray[2],_textView.text];
        
        NSString * therestr4 =[NSString stringWithFormat:@"%@ %@\n",_Barray[3],arraynum[0]];
        
        NSString * therestr5 =[NSString stringWithFormat:@"%@ %@\n",_Barray[4],arraynum[1]];
        
        _thereoStr = [NSString stringWithFormat:@"%@%@%@%@%@",therestr1,therestr2,therestr3,therestr4,therestr5];
        
        
        
        
        NSString * headStr = [NSString stringWithFormat:@"%@\n %@ %@ %@",_firstStr,_thereoStr,_twoStr,_fourStr];
        
        
        NSString * protocoloContent1 = @"鉴于：\n\n1.上海畅航信息科技有限公司是一家在中国境内合法注册并具备独立经营资格的企业法人，负责运营优顾全球留学顾问共享平台（以下简称“优顾平台”）。\n\n2. 甲方是提供有偿海外教育信息咨询服务（以下简称“咨询服务”）的自然人\n\n3. 乙方是通过优顾平台与甲方签订本协议的付费客户。\n\n4. 甲方为乙方指定的留学对象（以下简称“留学对象”）提供本协议约定的服务。\n\n依据《中华人民共和国合同法》及相关法律的规定，经由丙方撮合，甲乙双方友好协商，就甲方向乙方提供咨询服务事宜，达成如下条款：\n\n";
        
        NSString * protocoloContent = [NSString stringWithFormat:@"%@",protocoloContent1];
        for (int i = 0; i<13; i++) {
            
            NSString * pingjie  = [NSString stringWithFormat:@"%@\n\n%@",_main_body[i],_main_body1[i]];
            
            protocoloContent = [protocoloContent stringByAppendingString:pingjie];
            
            
            // protocoloContent = [protocoloContent stringByAppendingString:_main_body1[i]];
            
            
            
            
        }
        
        
        
        
        NSString * protocoloContentlast = [NSString stringWithFormat:@"%@\n%@",headStr,protocoloContent];
        
        NSLog(@"%@",protocoloContentlast);
        NSMutableDictionary * pramas1 = [NSMutableDictionary dictionary];
        pramas1[@"token"] =  kToken;
        pramas1[@"counselorId"] =  self.counselorId;
        pramas1[@"paraentName"] =  _paraentName.text;
        pramas1[@"paraentIdcard"] =  _paraentIdcard.text;
        pramas1[@"paraentAddress"] =  _textView.text;
        pramas1[@"paraentMobile"] =  arraynum[0];
        pramas1[@"paraentEmail"] =  arraynum[1];
        pramas1[@"protocoloContent"] = protocoloContentlast;
        pramas1[@"studentIdcard"] =  _studentIdcard.text;
        pramas1[@"studentName"] =  _paraentName.text;
        pramas1[@"consuleorName"] = @"";
        pramas1[@"consuleorIdcard"] =  @"";
        pramas1[@"consuleorAddress"] =  @"";
        pramas1[@"consuleorMobile"] =  @"";
        pramas1[@"consuleorEmail"] =  @"";
        pramas1[@"price"] =  _orderModel.servicePrice;
        DLog(@"%@",pramas1);
         [SVProgressHUD show];
            [HttpClientManager postAsyn:UG_insertOrderProtocol_URL params:pramas1 success:^(id json) {
        
           [SVProgressHUD dismiss];
        
                NSLog(@"%@",json);
        
                UgComordViewController * vc = [[UgComordViewController alloc]init];
        
                vc.serviceid = _serviceid;
                vc.counselorId = _counselorId;
                
                
                NSLog(@"%@    %@", vc.serviceid,vc.counselorId);
                [self pushToNextViewController:vc];
                
            } failure:^(NSError *error) {
                [SVProgressHUD dismiss];
                 NSLog(@"%@",error);
                
                
            }];
            

       
        
        
    }else{
        
        [self showSVErrorString:@"信息填写不完整"];
    }
    
    
    
    
    
    
    
    
    
    

}

-(void)setAttributedString:(NSString *)patr1 with:(NSString * )patr2 and:(UILabel * )lable{
    
    NSString * str = [NSString stringWithFormat:@"%@%@",patr1,patr2];
    ///NSString * str= [NSString stringWithFormat:@"预约倒计时:%@",timeStr];
    
    NSMutableAttributedString *titleLablestr=[[NSMutableAttributedString alloc]initWithString:str];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[titleLablestr string]rangeOfString:patr1];
    [titleLablestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range1];
    
    NSRange range2=[[titleLablestr string]rangeOfString:patr2];
    [titleLablestr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range2];
    lable.attributedText = titleLablestr;
    
    
    
    
}
-(void)call_back_tap{
    
//    for (NSInteger i = 998; i<1000; i++) {
//        UITextField * textfield = (UITextField *)[_scrollView viewWithTag:i];
//        
//        NSString *str = textfield.text;
//        [arraynum addObject:str];
//        
//    }

//    [_textView resignFirstResponder];
//    [_paraentName resignFirstResponder];
//    [_studentName resignFirstResponder];
//    [_paraentIdcard resignFirstResponder];
//    [_studentIdcard resignFirstResponder];
  
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.placeholderStr.alpha = 0;//开始编辑时
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{//将要停止编辑(不是第一响应者时)
    if (textView.text.length == 0) {
        self.placeholderStr.alpha = 1;
    }
    return YES;
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
