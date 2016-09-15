//
//  NSDate+Lcy.h
//  LUSIR
//
//  Created by lusir on 14-9-29.
//  Copyright (c) 2014年 Yuanwei Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Lcy)
/**
 *  时间间隔描述(之前的时间)
 *
 *  @return 时间描述
 */
-(NSString *)formatRelativeTimeDescribe;

/**
 *  UTC转当前时区时间
 *
 *  @return 当前时区时间
 */
- (NSDate *)getNowDateFromatAnDate;

/**
 *  时间转字符串
 *
 *  @return 字符串
 */
-(NSString *)toStringYMD;

-(NSString *)toStringMDHS;
@end
