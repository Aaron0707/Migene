//
//  User.h
//  MiJi
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "BaseModel.h"

@interface User : BaseModel
@property (nonatomic, assign) NSInteger  userId;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString<Optional> * phone;
@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, strong) NSString * signature;
@property (nonatomic, assign) NSString * sex;

@end
