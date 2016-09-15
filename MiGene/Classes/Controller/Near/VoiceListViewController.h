//
//  VoiceListViewController.h
//  MiGene
//
//  Created by Aaron on 15/7/28.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "BaseTableViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface VoiceListViewController : BaseTableViewController

@property (nonatomic, assign) CLLocationCoordinate2D location;
@end
