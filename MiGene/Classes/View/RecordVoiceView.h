//
//  RecordVoiceView.h
//  MiGene
//
//  Created by Aaron on 15/7/22.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface RecordVoiceView : UIView{
    UIView * centerView;
    BOOL isClose;
}

@property (nonatomic, strong) MAUserLocation *userLocation;
@property (nonatomic, strong) UIViewController *parentVc;

-(id)initInView:(UIView *)view;

-(void)show;



-(void)stepOne;
@end
