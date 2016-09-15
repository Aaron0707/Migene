//
//  AAEnum.h
//  MiJi
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#ifndef MiJi_AAEnum_h
#define MiJi_AAEnum_h
//性别枚举
typedef enum {
    FEMALE=0,
    MALE,
    UNDEFINE
}USERSEXENUM;

const NSArray *_USERSEXENUM;
#define USERSEXENUMGET (_USERSEXENUM == nil ? _USERSEXENUM = [[NSArray alloc] initWithObjects:\
@"f",\
@"m",\
@"u",\
nil] : _USERSEXENUM)
#define USERSEXENUM(string) ((USERSEXENUM)[USERSEXENUMGET indexOfObject:string])
#define USERSEXENUMSTRING(type) ([USERSEXENUMGET objectAtIndex:type])








#endif
