//
//  ProgramSettings.h
//  MiJi
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#ifndef MiJi_ProgramSettings_h
#define MiJi_ProgramSettings_h
//===================== 其它 =====================
#define kCompressionQuality 0.2
//判断系统是否等于某个版本
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
//屏幕尺寸是否是长屏
#define iPhoneLong  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define YLImageDefault @"image_default"
#define YLHeaderImage @""

//===================== 颜色 =====================
#define ColorRGBA(r,g,b,a) ([UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a])
#define MiGene_Color_Purple ColorRGBA(104, 0, 105, 1)  //紫色
#define MiGene_Color_Black ColorRGBA(48, 48, 48, 1) //黑色
#define MiGene_Color_GrayTime ColorRGBA(156, 156, 156, 1) //时间灰色
#define MiGene_Color_GrayTimeLength ColorRGBA(150, 150, 150, 1) //时间长度灰色

//===================== 第三方key =====================
#define MAMapApiKey @"c0d155fbfcd796dc544ee74e7d70ef04"


//===================== 屏幕变量 =====================
#define kMainScreenFrame   ([UIScreen mainScreen].bounds)
#define kMainScreenNoStatusFrame   ([UIScreen mainScreen].applicationFrame)
#define kMainApplicationWidth    kMainScreenNoStatusFrame.size.width    //应用程序的宽度
#define kMainApplicationHeight   kMainScreenNoStatusFrame.size.height   //应用程序的高度
#define kMainScreenWidth         kMainScreenFrame.size.width              //屏幕的宽度
#define kMainScreenHeight        kMainScreenFrame.size.height             //屏幕的高度
#define kMainScreenResolutionSize ([[UIScreen mainScreen] currentMode].size)

//====================比例适配=====================
#define iphone5s_ScreenWidth (320.f)
#define iphone5s_ScreenHeight (568.f)

#define kWindowWidth ([UIScreen mainScreen].bounds.size.width)
#define kWindowHeight ([UIScreen mainScreen].bounds.size.height)

#define kWidthRatio (kWindowWidth/iphone5s_ScreenWidth)
#define kHeightRatio (kWindowHeight/iphone5s_ScreenHeight)


//============== NETWORK=======================

#define AppServerBaseURLString @"http://115.29.242.13:8081"


//============== 工具 =======================
//操作系统iOS7
#define iOS7 (([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? YES : NO)
//操作系统iOS8
#define iOS8 (([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) ? YES : NO)
// 判断字符串是否为空
#define STRINGHASVALUE(str)		(str && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)

//============== DEBUG=======================
#ifdef DEBUG
#define ProLog(...) NSLog(__VA_ARGS__);
#else
#define ProLog
#endif
// 判断字符串是否为空
#define STRINGHASVALUE(str)		(str && [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length > 0)


//============== 字体相关=======================
#define FONTNORMAL @"Helvetica"
#define FONTBOLD   @"Helvetica-Bold"
#define FontRegular @"Nobel"

#define NobelFont_22            [UIFont fontWithName:FontRegular size:22]
#define NobelFont_20            [UIFont fontWithName:FontRegular size:20]
#define NobelFont_18            [UIFont fontWithName:FontRegular size:18]
#define NobelFont_15            [UIFont fontWithName:FontRegular size:15]
#define NobelFont_14            [UIFont fontWithName:FontRegular size:14]
#define NobelFont_13            [UIFont fontWithName:FontRegular size:13]
#define NobelFont_12            [UIFont fontWithName:FontRegular size:12]
#define NobelFont_10            [UIFont fontWithName:FontRegular size:10]

#define Helvetica_22_Bold       [UIFont fontWithName:FONTBOLD size:22]
#define Helvetica_22            [UIFont fontWithName:FONTNORMAL size:22]

#define Helvetica_18_Bold       [UIFont fontWithName:FONTBOLD size:18]
#define Helvetica_18            [UIFont fontWithName:FONTNORMAL size:18]

#define Helvetica_14_Bold       [UIFont fontWithName:FONTBOLD size:14]
#define Helvetica_14            [UIFont fontWithName:FONTNORMAL size:14]

#define Helvetica_10            [UIFont fontWithName:FONTNORMAL size:10]

#define Chinese_Font_22_Bold    [UIFont boldSystemFontOfSize:22]
#define Chinese_Font_22         [UIFont systemFontOfSize:22]

#define Chinese_Font_18_Bold    [UIFont boldSystemFontOfSize:18]
#define Chinese_Font_18         [UIFont systemFontOfSize:18]

#define Chinese_Font_16_Bold    [UIFont boldSystemFontOfSize:16]
#define Chinese_Font_16         [UIFont systemFontOfSize:16]

#define Chinese_Font_15         [UIFont systemFontOfSize:15]
#define Chinese_Font_15_Bold    [UIFont boldSystemFontOfSize:15]

#define Chinese_Font_14_Bold    [UIFont boldSystemFontOfSize:14]
#define Chinese_Font_14         [UIFont systemFontOfSize:14]

#define Chinese_Font_13         [UIFont systemFontOfSize:13]

#define Chinese_Font_12_Bold    [UIFont boldSystemFontOfSize:12]
#define Chinese_Font_12         [UIFont systemFontOfSize:12]

#define Chinese_Font_11_Bold    [UIFont boldSystemFontOfSize:11]
#define Chinese_Font_11         [UIFont systemFontOfSize:11]

#define Chinese_Font_10_Bold    [UIFont boldSystemFontOfSize:10]
#define Chinese_Font_10         [UIFont systemFontOfSize:10]

#define Chinese_Font_9_Bold    [UIFont boldSystemFontOfSize:9]
#define Chinese_Font_9         [UIFont systemFontOfSize:9]

#define Chinese_Font_8         [UIFont systemFontOfSize:8]
#endif
