//
//  Tools.h
//  Wallet
//
//  Created by Lcyu on 14-7-23.
//  Copyright (c) 2014年 BoEn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
static void (^touchUpInsideForButtons)(NSInteger  index);
@interface Tools : NSObject

#pragma mark 数据操作
#pragma mark NSUserDefaults方式操作数据
/**
 *  保存数据
 *
 *  @param key        key键
 *  @param dataString 数据串
 */
+(void)save:(NSString *)key data:(NSString *) dataString;

/**
 *  删除数据
 *
 *  @param key key键
 */
+(void)remove:(NSString *)key;

/**
 *  读取数据
 *
 *  @param key key键
 *
 *  @return 数据串
 */
+(NSString *)read:(NSString *)key;

#pragma mark 导航栏操作
#pragma mark 导航栏跳转
/**
 *  弹出到指定的vc
 *
 *  @param vcClass 指定的vcClass
 *  @param nvc     导航控制器
 */
+(void)popVCClass:(Class)vcClass withNvc:(UINavigationController *)nvc;

/**
 *  推到指定页面
 *
 *  @param vc  目标vc
*  @param nvc 导航栏控制器
 */
+(void)pushToVC:(UIViewController *)vc withNvc:(UINavigationController *)nvc;

/**
 *  推到指定页面
 *
 *  @param name 目标vc类名
 *  @param nvc  导航栏控制器
 */
+(void)pushToVCClassName:(NSString *)name withNvc:(UINavigationController *)nvc;

/**
 *  根据vc在soryboard 上面到ID push  到VC
 *
 *  @param name  push vc的  storyboard id
 *  @param nvc   导航控制器
 */
+(void)pushToVCStoryId:(NSString *)name withNvc:(UINavigationController *)nvc;

#pragma mark 弹出窗操作
#pragma mark 确认框
/**
 *  确认框
 *
 *  @param message 消息
 */
+(void)showMessageWithMessage:(NSString *)message;
/**
 *  确认框
 *
 *  @param title   title
 *  @param message 消息
 */
+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message;

/**
 *  确认框
 *
 *  @param title    title
 *  @param message  消息
 *  @param btnTitle 按钮title
 */
+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle;

/**
 *  Hud加载效果
 *
 *  @param message 提示文字
 *  @param view    需要显示的view
 */
+(void)showHudWithMessage:(NSString *)message view:(UIView *)viev;

/**
 *  Hud隐藏
 *
 *  @param view 需要隐藏的view
 */
+(void)hideHudMessageWithView:(UIView *)view;

/**
 *  Hud加载效果
 *
 *  @param message 提示文字
 */
+(void)showHudWithMessage:(NSString *)message;

+(void)showRequestHud;

+(void)showRequestHudWithMessage:(NSString *)message;

/**
 *  Hud隐藏
 */
+(void)hideHudMessage;

/**
 *  Hud提示
 *
 *  @param message 提示内容
 *  @param viev    提示View
 *  @param delay   消失时间段
 */
+(void)showHudWithMessage:(NSString *)message view:(UIView *)view hideAfterDelay:(NSTimeInterval)delay;

/**
 *  提示框，自动消失
 *
 *  @param message 提示信息
 */
+(void)showToastWithMessage:(NSString *)message;

/**
 *  提示框，自动消失
 *
 *  @param message 提示信息
 *  @param view    承载View
 */
+(void)showToastWithMessage:(NSString *)message view:(UIView *)view;

/**
 *  打开指定url
 *
 *  @param urlString
 */
+(void)openUrlString:(NSString *)urlString;

/**
 *  是否有照相机权限
 *
 *  @return <#return value description#>
 */
+(BOOL)isCameraPermissions;

+(BOOL)isHaveChinese:(NSString *)inputString;

+(BOOL)isPhoneNumber:(NSString *)inputString;




/**
 *  正则匹配
 *
 *  @param inputString 输入字符
 *  @param regex       正则
 *
 *  @return 如果匹配yes
 */
+(BOOL)isVerifyWithString:(NSString *)inputString regex:(NSString *)regex;

/**
 *  友盟添加别名，即推送标示
 *
 *  @param alias 标示
 */
//+(void)UMessageAddAlias:(NSString *)alias;

/**
 *  友盟删除别名，即推送标示
 *
 *  @param alias 标示
 */
//+(void)UMessageRemoveAlias:(NSString *)alias;

/**
 *  数据汉字拼音分组
 *
 *  @return 拼音（A~Z,#）
 */
+(NSMutableDictionary *)pinyinGroupWithData:(NSArray *)sourcedata hanziKey:(NSString *)hanziKey;

/**
 *  数据汉字拼音分组 该方法为深度定制 只能用户本项目的通讯录
 *
 *  @return 拼音（A~Z,#）
 */

+(NSMutableDictionary *)pinyinGroupWithData:(NSArray *)sourcedata fristHanZiKey:(NSString *)fristHanZiKey secondHanZiKey:(NSString *)secondHanZiKey;

/**
 *  时间转换
 *
 */
+ (NSString*)timeStringWith:(NSTimeInterval)timestamp;
+ (NSString *)timeStringWithInput:(NSString *)timestring;


/**
 *  获取生成的设备标示符
 *
 */
+ (NSString*)getKeyChainIdentifier;

/**
 *
 *  通过title数组展示button到maskView
 *
 */

+(void)showButtonsIntoView:(UIView *)view titleArray:(NSArray *)titleArray iconName:(NSArray*)name bgColor:(NSArray *)bgColors TouchUpInside:(void (^)(NSInteger index))touchUp;


+(void)popupAnimation:(UIView *)outView duration:(CFTimeInterval)duration;
+(void)dismissAnimation:(UIView *)outView duration:(CFTimeInterval)duration;
@end
