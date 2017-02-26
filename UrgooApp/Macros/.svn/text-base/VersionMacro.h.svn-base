//
//  VersionMacro.h
//  UrgooApp
//
//  Created by admin on 16/3/1.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#ifndef VersionMacro_h
#define VersionMacro_h
//1. 打印日志
#ifdef DEBUG
#    define DLog(...) NSLog(__VA_ARGS__)
#else
#    define DLog(...)
#endif

//2. 获取屏幕 宽度、高度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Frame (CGRectMake(0, 0 ,kScreen_Width,kScreen_Height))
#define kScreen_CenterX kScreen_Width/2
#define kScreen_CenterY kScreen_Height/2

//3. 颜色
#define RGB(r, g, b) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) /255.0) alpha:1.0]
#define RGBAlpha(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]

#define HexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:1.0]
#define HexRGBAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >>8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:(a)]


//背景色
#define Background_Color [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]
//清除背景色
#define Clear_Color [UIColor clearColor]

//4.加载图片宏：
#define LoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
//5. NavBar高度
#define NavigationBar_Height 44
//6. 获取系统版本
#define iOS ([[[UIDevice currentDevice] systemVersion] floatValue])
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

//7. 判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//8. 设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]

//9. GCD
#define GCD_Back(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define GCD_Main(block) dispatch_async(dispatch_get_main_queue(),block)

//10. NSUserDefaults 实例化
#define User_Default [NSUserDefaults standardUserDefaults]
#endif /* VersionMacro_h */
