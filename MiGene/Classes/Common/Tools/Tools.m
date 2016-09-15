//
//  Tools.m
//  Wallet
//
//  Created by Lcyu on 14-7-23.
//  Copyright (c) 2014年 BoEn. All rights reserved.
//

#import "Tools.h"
#import "UINavigationController+Lcyu.h"
#import "pinyin.h"
#import "UIView+MJExtension.h"
#import <AVFoundation/AVFoundation.h>
#define MainWindow  ([UIApplication sharedApplication].keyWindow)
#define appIdentifierOfKeyChain @"com.daqian.MiGene"
@implementation Tools
+(void)save:(NSString *)key data:(NSString *) dataString
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:dataString forKey:key];
    [ud synchronize];
}

+(void)remove:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:key];
    [ud synchronize];
}

+(NSString *)read:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}

+(void)popVCClass:(Class)vcClass withNvc:(UINavigationController *)nvc
{
    [nvc popToViewControllerWithClass:vcClass animated:YES];
}

+(void)pushToVC:(UIViewController *)vc withNvc:(UINavigationController *)nvc
{
    [nvc pushToVC:vc];
}

+(void)pushToVCClassName:(NSString *)name withNvc:(UINavigationController *)nvc
{
    [nvc pushToVCClassName:name];
}

+(void)pushToVCStoryId:(NSString *)name withNvc:(UINavigationController *)nvc
{
    [nvc pushToVCStoryId:name];
}

+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message
{
    [Tools showMessageWithTitle:title message:message btnTitle:@"确定"];
}

+(void)showMessageWithMessage:(NSString *)message
{
    [Tools showMessageWithTitle:nil message:message btnTitle:@"确定"];
}

+(void)showMessageWithTitle:(NSString *)title message:(NSString *)message btnTitle:(NSString *)btnTitle
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:btnTitle otherButtonTitles:nil];
    [view show];
}

+(void)showHudWithMessage:(NSString *)message view:(UIView *)view
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
}

+(void)hideHudMessageWithView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

+(void)showHudWithMessage:(NSString *)message
{
    [Tools showHudWithMessage:message view:MainWindow];
}

+(void)showRequestHud
{
    [self showRequestHudWithMessage:@"加载中..."];
}

+(void)showRequestHudWithMessage:(NSString *)message
{
    [[MBProgressHUD class] hideAllHUDsForView:MainWindow animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:MainWindow animated:YES];
    hud.labelText = message;
    hud.labelFont = [UIFont boldSystemFontOfSize:12.0f];
    hud.margin = 12.0f;
    //    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
}

+(void)hideHudMessage
{
    [MBProgressHUD hideHUDForView:MainWindow animated:YES];
}

+(void)showHudWithMessage:(NSString *)message view:(UIView *)view hideAfterDelay:(NSTimeInterval)delay
{
    [[MBProgressHUD class] hideAllHUDsForView:MainWindow animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    BOOL cantains = NO;
    if (iOS7) {
        NSRange range = [message rangeOfString:@"\n"];
        cantains =  range.length > 0;
    }else{
        cantains = [message containsString:@"\n"];
    }
    if (cantains) {
        NSArray * array = [message componentsSeparatedByString:@"\n"];
        hud.labelText = array[0];
        hud.detailsLabelText = array[1];
    }else{
        hud.labelText = message;
    }
    hud.labelFont = [UIFont boldSystemFontOfSize:12.0f];
    hud.margin = 12.0f;
    hud.yOffset = 150.0f;
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.userInteractionEnabled = NO;
    [hud hide:YES afterDelay:delay];
}

+(void)showToastWithMessage:(NSString *)message
{
    [Tools showToastWithMessage:message view:MainWindow];
}

+(void)showToastWithMessage:(NSString *)message view:(UIView *)view
{
    [Tools showHudWithMessage:message view:view hideAfterDelay:1.7];
}

+(void)openUrlString:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}

+(BOOL)isCameraPermissions
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusDenied){
        return false;
    }
    return true;
}

+(BOOL)isHaveChinese:(NSString *)inputString
{
    NSString * regex = @"^[a-z][a-z0-9_]{2,19}$";
    return ![Tools isVerifyWithString:inputString regex:regex];
}

+(BOOL)isPhoneNumber:(NSString *)inputString
{
    NSString *regex = @"^1(3|5|7|8|4)\\d{9}";
    return [Tools isVerifyWithString:inputString regex:regex];
}

+(BOOL)isVerifyWithString:(NSString *)inputString regex:(NSString *)regex
{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:inputString];
}

//+(void)UMessageAddAlias:(NSString *)alias
//{
//    [UMessage addAlias:alias type:kUMessageAliasTypeApp response:nil];
//}
//
//+(void)UMessageRemoveAlias:(NSString *)alias
//{
//    [UMessage removeAlias:alias type:kUMessageAliasTypeApp response:nil];
//}

+(NSMutableDictionary *)pinyinGroupWithData:(NSArray *)sourcedata hanziKey:(NSString *)hanziKey
{
    NSMutableDictionary *sectionDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < 26; i++)
        [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    
    for (int k=0;k<sourcedata.count;k++) {
        NSString *hanzi = [sourcedata[k] valueForKey:hanziKey];
        char first=pinyinFirstLetter([hanzi characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([hanzi characterAtIndex:0])] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        
        [[sectionDic objectForKey:sectionName] addObject:sourcedata[k]];
    }
    return sectionDic;
}

+(NSMutableDictionary *)pinyinGroupWithData:(NSArray *)sourcedata fristHanZiKey:(NSString *)fristHanZiKey secondHanZiKey:(NSString *)secondHanZiKey{
    NSMutableDictionary *sectionDic = [NSMutableDictionary dictionary];
    for (int i = 0; i < 26; i++)
        [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'A'+i]];
    [sectionDic setObject:[NSMutableArray array] forKey:[NSString stringWithFormat:@"%c",'#']];
    
    for (int k=0;k<sourcedata.count;k++) {
        NSString *hanzi = [[sourcedata[k] valueForKey:@"friendShip"] valueForKey:fristHanZiKey];
        if (!STRINGHASVALUE(hanzi)) {
            hanzi = [sourcedata[k] valueForKey:secondHanZiKey];
        }
        char first=pinyinFirstLetter([hanzi characterAtIndex:0]);
        NSString *sectionName;
        if ((first>='a'&&first<='z')||(first>='A'&&first<='Z')) {
            sectionName = [[NSString stringWithFormat:@"%c",pinyinFirstLetter([hanzi characterAtIndex:0])] uppercaseString];
        }
        else {
            sectionName=[[NSString stringWithFormat:@"%c",'#'] uppercaseString];
        }
        
        [[sectionDic objectForKey:sectionName] addObject:sourcedata[k]];
    }
    return sectionDic;
}

+ (NSString*)timeStringWith:(NSTimeInterval)timestamp {
    NSString *_timestamp;
    time_t now;
    time(&now);
    
    int distance = (int)difftime(now, timestamp);
    if (distance < 0) distance = 0;
    
    if (distance < 10) {
        _timestamp = [NSString stringWithFormat:@"刚刚"];
    } else if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"秒前"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"分钟前"];
    } else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, @"小时前"];
    } else if (distance < 60 * 60 * 24 * 4) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%d%@", distance, (distance == 1) ? @"天前" : @"天前"];
    } else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd hh:mm"];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}

+ (NSString *)timeStringWithInput:(NSString *)timestring
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSZ";
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:localTimeZone];
    NSDate *date = [formatter dateFromString:timestring];
    NSDate *now = [NSDate date];
    // 比较大圈发送时间和当前时间
    NSInteger distance = [now timeIntervalSinceDate:date];
    NSString *_timestamp = nil;
    
    if (distance < 0) distance = 0;
    
    if (distance < 60) {
        _timestamp = [NSString stringWithFormat:@"刚刚"];
    }
    else if (distance < 60 * 60) {
        distance = distance / 60;
        _timestamp = [NSString stringWithFormat:@"%ld%@", (long)distance, @"分钟前"];
    } else if (distance < 60 * 60 * 24) {
        distance = distance / 60 / 60;
        _timestamp = [NSString stringWithFormat:@"%ld%@", (long)distance, @"小时前"];
    } else if (distance < 60 * 60 * 24 * 30) {
        distance = distance / 60 / 60 / 24;
        _timestamp = [NSString stringWithFormat:@"%ld%@", (long)distance, (distance == 1) ? @"天前" : @"天前"];
    } else {
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MM-dd HH:mm"];
            NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
            [dateFormatter setTimeZone:localTimeZone];
        }
        _timestamp = [dateFormatter stringFromDate:date];
    }
    return _timestamp;
}

+(NSString *)getKeyChainIdentifier{
    NSString * key = [self loadFromKeyChain:appIdentifierOfKeyChain];
    
    if (![key isEqualToString:@"(null)"]) {
        return key;
    }else{
        NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [self saveToKeyChain:appIdentifierOfKeyChain data:identifierForVendor];
        return identifierForVendor;
    }
}

+ (void)saveToKeyChain:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
}

+(NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge id)kSecClassGenericPassword,(__bridge id)kSecClass,
            service, (__bridge id)kSecAttrService,
            service, (__bridge id)kSecAttrAccount,
            (__bridge id)kSecAttrAccessibleAfterFirstUnlock,(__bridge id)kSecAttrAccessible,
            nil];
}

+ (NSString *)loadFromKeyChain:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return [NSString stringWithFormat:@"%@",ret];
}


+ (void)deleteFromKeyChain:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+ (void)showButtonsIntoView:(UIView *)view titleArray:(NSArray *)titleArray iconName:(NSArray*)names bgColor:(NSArray *)bgColors TouchUpInside:(void (^)(NSInteger index))touchUp{
    touchUpInsideForButtons = touchUp;
    NSInteger buttonCount = [titleArray count];
    if (buttonCount==0 || buttonCount!=names.count || buttonCount!=bgColors.count) {
        return;
    }
    CGFloat height = 24+buttonCount*50;
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight)];
    [bgView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.5]];
    [view.window addSubview:bgView];
    
    UIView * buttonView = [[UIView alloc]initWithFrame:CGRectMake(61, (kMainScreenHeight-height)/2, kMainScreenWidth-122, height)];
    buttonView.layer.cornerRadius = 10;
    [buttonView setBackgroundColor:[UIColor whiteColor]];
    [bgView addSubview:buttonView];

    [titleArray enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL *stop) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(20, 17+(idx*50), buttonView.width-40, 40);
        button.layer.cornerRadius = 10;
        [button setTintColor:[UIColor whiteColor]];
        [button setBackgroundColor:bgColors[idx]];
        [button setTitle:title forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:names[idx]] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(10, 15, 10, 25)];
        [buttonView addSubview:button];
        button.tag = idx;
        [button addTarget:self action:@selector(buttonsTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    UITapGestureRecognizer *addFriendClickGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackClick:)];
    bgView.userInteractionEnabled = YES;
    [bgView addGestureRecognizer:addFriendClickGR];

    [self popupAnimation:bgView duration:0.1];
}

+(void)buttonsTouchUp:(UIButton *)button{
    [button.superview.superview removeFromSuperview];
    if (touchUpInsideForButtons) {
        touchUpInsideForButtons(button.tag);
    }
}

+(void)blackClick:(UIGestureRecognizer *)gr{
//    [self dismissAnimation:gr.view duration:0.1];
    [gr.view removeFromSuperview];
}

+(void)popupAnimation:(UIView *)outView duration:(CFTimeInterval)duration
{
    outView.hidden = NO;
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.delegate = outView;
    animation.duration = duration;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    
    NSMutableArray * values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
//    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    
    [outView.layer addAnimation:animation forKey:nil];
}

+(void)dismissAnimation:(UIView *)outView duration:(CFTimeInterval)duration
{
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = duration;
    animation.delegate = outView;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:@"easeInEaseOut"];
    NSMutableArray * values = [NSMutableArray array];
    
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.0, 0.0, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    animation.values = values;
    [outView.layer addAnimation:animation forKey:nil];
}

//+(void)removeView:(UIView *)view{
//    [view removeFromSuperview];
//}

@end
