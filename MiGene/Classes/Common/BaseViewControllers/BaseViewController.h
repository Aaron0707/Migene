//
//  BaseViewController.h
//  MiGene
//
//  Created by 0001 on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^backAction)(void);
@interface BaseViewController : UIViewController
@property (nonatomic, copy) backAction back;
@end
