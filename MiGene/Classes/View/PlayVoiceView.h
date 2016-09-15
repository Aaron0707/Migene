//
//  PlayVoiceView.h
//  MiGene
//
//  Created by Aaron on 15/7/23.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiGene.h"
@interface PlayVoiceView : UIView{
    UIView * centerView;
    BOOL isClose;
}

@property (nonatomic, strong) NSString *playType;//类型，音乐，文字，图片
@property (nonatomic, strong)   MiGene *migene;

@property (nonatomic, strong) UIViewController *parentVc;

-(id)initInView:(UIView *)view;

-(void)show;

- (void)playFile:(id)sender;
@end
