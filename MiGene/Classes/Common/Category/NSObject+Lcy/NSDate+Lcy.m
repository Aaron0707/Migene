//
//  NSDate+Lcy.m
//  LUSIR
//
//  Created by lusir on 14-9-29.
//  Copyright (c) 2014年 Yuanwei Chen. All rights reserved.
//

#import "NSDate+Lcy.h"

#define kMINUTE 60
#define kHOUR   (60 * kMINUTE)
#define kDAY    (24 * kHOUR)
#define k_5_DAYS (5 * kDAY)
#define kWEEK   (7 * kDAY)
#define kMONTH  (30 * kDAY)
#define kYEAR   (365 * kDAY)

@implementation NSDate (Lcy)

- (NSDate *)getNowDateFromatAnDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
    return destinationDateNow;
}

-(NSString *)formatRelativeTimeDescribe
{
    NSTimeInterval elapsed = [self timeIntervalSinceNow];
    NSString *TimeDescribe;
    if (elapsed > 0) {
        TimeDescribe = @"刚刚";
    }
    else
    {
        elapsed = -elapsed;
        if(elapsed < 1)
        {
            TimeDescribe = @"刚刚";
        }
        else if (elapsed < kMINUTE)
        {
            TimeDescribe = [NSString stringWithFormat:@"%i秒之前", (int)elapsed];
        }
        else if (elapsed < kHOUR)
        {
            TimeDescribe = [NSString stringWithFormat:@"%i分钟之前", (int)elapsed/kMINUTE];
        }
        else if (elapsed < kDAY)
        {
            TimeDescribe = [NSString stringWithFormat:@"%i小时之前", (int)elapsed/kHOUR];
        }
//        else if (elapsed < kMONTH)
//        {
//            TimeDescribe = [NSString stringWithFormat:@"%i天之前", (int)elapsed/kDAY];
//        }
//        else if (elapsed < kYEAR)
//        {
//            TimeDescribe = [NSString stringWithFormat:@"%i个月之前", (int)elapsed/kMONTH];
//        }
        else
        {
            TimeDescribe = [self toStringMDHS];
        }
    }
    return TimeDescribe;
}

-(NSString *)toStringYMD
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}

-(NSString *)toStringMDHS
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:self];
    return strDate;
}
@end
