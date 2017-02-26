//
//  ServiceAgreementViewController.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/4/15.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ServiceAgreementViewController.h"

@interface ServiceAgreementViewController ()
{
    UILabel    *kuangLable;
    UITextView *text;
}
@end

@implementation ServiceAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setCustomTitle:@"服务协议"];
    
    kuangLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, kScreenWidth - 40, kScreenHeight - 104)];
    kuangLable.layer.borderWidth = 1;
    kuangLable.layer.cornerRadius = 10;
    kuangLable.layer.borderColor = RGB(37, 175, 153).CGColor;
    [self.view addSubview:kuangLable];
    
    text = [[UITextView alloc] initWithFrame:CGRectMake(22, 22, kScreenWidth - 44, kScreenHeight - 108)];
    text.text = @"1、服务条款的确认和接纳\r\r本APP的各项内容和服务的所有权归本公司拥有。用户在接受本服务之前，请务必仔细阅读本条款。用户使用服务，或通过完成注册程序，表示用户接受所有服务条款。\r\r2、用户同意：\r(1) 提供及时、详尽及准确的个人资料。\r(2) 不断更新注册资料、符合及时、详尽、准确的要求。\r如果用户提供的资料不准确，本网站有结束服务的权利。\r\r本APP将公开用户的姓名、电子邮箱等信息。\r\r用户在APP的任何行为必须遵循：\r(1) 传输资料时必须符合中国有关法规。\r(2) 使用信息服务不作非法用途和不道德行为。\r(3) 不干扰或混乱网络服务。\r(4) 遵守所有使用服务的网络协议、规定、程序和惯例。用户的行为准则是以因特网法规，政策、程序和惯例为根据的。\r\r3、服务条款的修改\r本网站及APP有权在必要时修改条款，将会在页面公布。\r如果不接受所改动的内容，用户可以主动取消自己的会员资格。如果您不取消自己的会员资格，则视为接受服务条款的变动。\r\r4、 用户的帐号、密码和安全性\r一旦成功注册成为会员，您将有一个密码和用户名。\r用户将对用户名和密码的安全负全部责任。另外，每个用户都要对以其用户名进行的所有活动和事件负全责。您可以随时改变您的密码。\r用户若发现任何非法使用用户帐号或存在安全漏洞的情况，请立即通告本公司。\r\r5、拒绝提供担保\r用户明确同意使用本公司服务，由用户个人承担风险。\r本APP不担保服务一定满足用户的要求，也不担保服务不会中断，对服务的及时性、安全性、出错发生都不作担保。\r用户理解并接受：任何通过服务取得的信息资料的可靠性有用性取决于用户自己的判断，用户自己承担所有风险和责任。\r\r6、有限责任\r本APP对任何由于使用服务引发的直接、间接、偶然及继起的损害不负责任。\r这些损害可能来自（包括但不限于）：不正当使用服务，或传送的信息不符合规定等。\r\r7、对用户信息的存储和限制\r本APP不对用户发布信息的删除或储存失败负责，本公司有判定用户的行为是否符合服务条款的要求和精神的保留权利。如果用户违背了服务条款的规定，有中断对其提供服务的权利。\r\r8、结束服务\r本APP可随时根据实际情况中断一项或多项服务，不需对任何个人或第三方负责或知会。\r同时用户若反对任何服务条款的建议或对后来的条款修改有异议，或对服务不满，用户可以行使如下权利：\r(1) 不再使用本公司的服务。\r(2) 通知本公司停止对该用户的服务。\r\r9、信息内容的所有权\r本公司的信息内容包括：文字、软件、声音、相片、录象、图表；以及其它信息，所有这些内容受版权、商标、标签和其它财产所有权法律的保护。\r用户只能在授权下才能使用这些内容，而不能擅自复制、再造这些内容、或创造与内容有关的派生产品。\r\r9、隐私保护条款\r本APP将严格保守用户的个人隐私，承诺未经过您的同意不将您的个人信息任意披露。\r但在以下情形下，我们将无法再提供您前述保证而披露您的相关信息。这些情形包括但不限于：\r* 为了您的交易顺利完成，我们不得不把您的某些信息，如您的姓名、联系电话、e-mail等提供给相关方，以便于他们及时与您取得联系，提供服务。\r* 当您的行为违反的服务条款，或可能损害他人权益或导致他人遭受损害，只要我们相信披露您的个人资料是为了辨识、联络或采取法律行动所必要的行动时。\r* 法律法规所规定的必须披露或公开的个人信息。\r* 当司法机关或其它有权机关依法执行公务，要求提供特定个人资料时，我们必须给予必要的配合。\r\r10、适用法律\r上述条款将适用中华人民共和国的法律，所有的争端将诉诸于本网所在地的人民法院。\r如发生服务条款与中华人民共和国法律相抵触时，则这些条款将完全按法律规定重新解释，而其它条款则依旧保持约束力。";
    text.font = [UIFont systemFontOfSize:15];
    text.editable = NO;
    [self.view addSubview:text];
    
    
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
