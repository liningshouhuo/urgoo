//
//  UGSearchClientViewController2.m
//  UrgooApp
//
//  Created by admin on 16/4/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSearchClientViewController2.h"
#import "UGSearchClientDetailViewController.h"
#import "HttpClientManager.h"
#import "AssistantsModel.h"
#import "AppDelegate.h"
@interface UGSearchClientViewController2 ()
{
     AssistantsModel * model;
}
@property(strong,nonatomic)UIImageView * imageview;
@property(strong,nonatomic)  UIView * uiview;
@property(strong,nonatomic)  UIView * uiview1;
//@property(assign,nonatomic) BOOL hidden;

@end

@implementation UGSearchClientViewController2
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    //[self loadRequest];
}
//-(void)loadRequest{
//    
//    if ([OrderStatus isEqualToString:@"1"]) {
//        NSLog(@"dsds");
//       
//    } else if ([OrderStatus isEqualToString:@"2"]){
//        
//        
//        
//        //        __weak UrgooTabBarController * weakSelf = self;
//        
//        
//        NSMutableDictionary *params = [NSMutableDictionary dictionary];
//        params[@"token"] = kToken;//gfaPvUV+GxQ=
//        //params[@"termType"] =@"2";
//        NSLog(@"%@",kToken);
//        // MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
//        [HttpClientManager getAsyn:UG_USER_SELECT_ORDER_INFO   params:params success:^(id resultData) {
//            
//            AssistantsService * assistantsService=[[AssistantsService alloc] init];
//            MsgModel *msg=[assistantsService getHeaderMsgWithDict:resultData[@"header"]];
//            
//            if ([msg.code isEqualToString:@"200"]){
//                model = [assistantsService getAssistantsWithDict:resultData[@"body"]];
//                
//                NSString * Orderstr =  resultData[@"body"][@"status"];
//                if ([Orderstr isEqualToString:@"1"]) {
//                    
//                   // [[AppDelegate sharedappDelegate]showTabBartest];
//                }
//                if ([Orderstr isEqualToString:@"(null)"]) {
//                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"OrderStatus"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                }else{
//                    //token
//                    [[NSUserDefaults standardUserDefaults] setObject:Orderstr forKey:@"OrderStatus"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
//                }
//                
//                
//                
//                
//                
//                
//            }else if ([msg.code isEqualToString:@"400"]){
//                //[weakSelf showSVString:msg.message];
//                
//                
//                NSLog(@"11111111---------");
//            }
//            
//            
//            
//            
//        } failure:^(NSError *error) {
//            // [weakSelf showSVErrorString:@"Network request failed, please try again later"];
//            NSLog(@"没有网络");
//            
//            
//        }];
//        
//        
//    }
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self needBackAction:NO];
    [self needRightAction:NO];
    
    [self setCustomTitle:@"找顾问"];
   
    
    //self.view.backgroundColor = [UIColor redColor];
   
    
    //[self loadWebViewWithUrlStr:UG_STUDENT_SEARCHCLIENT_URL];
    //注册  提示注册成功显示
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"tongzhi" object:nil];
    
    
    [self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@",UG_STUDENT_SEARCHCLIENT_URL]];
    //[self showSignUP];
    //[self loadWebViewWithUrlStr:[NSString stringWithFormat:@"%@?token=%@",UG_STUDENT_CLINT_URL,kToken_temp]];
}


- (void)tongzhi{
    self.hidden = NO;
     [_uiview setHidden:_hidden];
     [_uiview1 setHidden:_hidden];
     [self performSelector:@selector(imageHidden) withObject:nil afterDelay:2];
    
       NSLog(@"－－－－－接收到通知------");
    
}
-(void)imageHidden{
    self.hidden = YES;
    [_uiview setHidden:_hidden];
    [_uiview1 setHidden:_hidden];

    
}
 // 添加注册成功 提示
-(void)showSignUP{
    
    
    CGFloat X = kScreenWidth * 0.175;
    CGFloat Y = X * 2.2 ;
    CGFloat W = kScreenWidth * 0.65 ;
    CGFloat H = W * 0.59;
    _uiview = [[UIView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
    _uiview.backgroundColor = [UIColor whiteColor];
    _uiview.layer.cornerRadius = 15;
    _imageview = [[UIImageView alloc]init];
    _imageview.center = CGPointMake(CGRectGetWidth(self.uiview.frame)/2, CGRectGetHeight(self.uiview.frame)/2);
    //_imageview.centerY = kScreenHeight/2;
    UIImage * image = [UIImage imageNamed:@"笑脸@3x"];
    _imageview.bounds = CGRectMake(0, 0, H * 0.9, H * 0.9);
    _imageview.image = image;
    
    
    [_uiview addSubview:_imageview];
    [self.view.window addSubview:_uiview];
    [_uiview setHidden:YES];
    _uiview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight + 60)];
    _uiview1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_uiview1];
    _uiview1.alpha = 0.1;
    [self.view insertSubview:_uiview1 belowSubview:_uiview];
    [_uiview1 setHidden:YES];
    _uiview1.userInteractionEnabled = NO;
    _uiview.userInteractionEnabled = NO;
    [self.view.window bringSubviewToFront:_uiview];

    
}
-(void)loadWebViewWithUrlStr:(NSString *)urlStr
{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64-49)];
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    self.webView.delegate =self;
    [self.view addSubview:self.webView];
    //self.view = self.webView;
 
      
    //[self.view addSubview:_imageview];.layer.cornerRadius = 8;
       // _imageview.backgroundColor = [UIColor whiteColor];
       // [self.view addSubview:_imageview];
    
       //[_imageview setHidden:YES];
    //[self.view bringSubviewToFront:_imageview];
//    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
//    _imageview.backgroundColor = [UIColor redColor];

//    [self.view addSubview:_imageview];
//
//    [self.view bringSubviewToFront:_imageview];
//    [_imageview setHidden:YES];
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    DLog(@"path=%@",[[request URL] absoluteString]);
    
    NSString *pathStr = [[request URL] absoluteString];
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:Html5Mark];
    
    NSArray *pathArr = [pathStr componentsSeparatedByCharactersInSet:set];
    
    NSInteger accountObj = [pathArr count];
    
   
    DLog(@"pathArr=%@",pathArr);
    if (pathArr.count>1) {
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",UG_HOST,pathArr[accountObj-1]];
        
        NSString *tokenStr = [NSString stringWithFormat:@"%@",kToken];
        
        if (tokenStr.length!=12) {

           LoginViewController *loginVC = [[LoginViewController alloc]init];
           loginVC.hidesBottomBarWhenPushed = YES;
           UGNavigationController *loginNav = [[UGNavigationController alloc] initWithRootViewController:loginVC];
           [self.navigationController presentViewController:loginNav animated:YES completion:nil];
                                       DLog(@"确定");

        }else{
            DLog(@"urlStr=%@",urlStr);
            UGSearchClientDetailViewController *vc = [[UGSearchClientDetailViewController alloc]init];
            vc.urlStr = urlStr;
            vc.hidesBottomBarWhenPushed = YES;
            [self pushToNextViewController:vc];
        }
      
        
        
    }
    
    return YES;
}



//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}


//-(void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//
//    
//    //    self.navigationController.navigationBarHidden = NO;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
