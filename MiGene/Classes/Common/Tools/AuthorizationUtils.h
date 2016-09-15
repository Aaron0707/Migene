//
//  AuthorizationUtils.h
//  SuperCard
//
//  Created by x1371 on 15/4/2.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthorizationUtils : NSObject
- (BOOL)authorizationCamera;
- (BOOL)authorizationPhotoLibrary;
@property (nonatomic, weak) UIViewController *presentVC;
@end
