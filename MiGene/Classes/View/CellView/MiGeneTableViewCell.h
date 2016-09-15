//
//  MiGeneTableViewCell.h
//  MiGene
//
//  Created by Aaron on 15/7/28.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class MiGene;

@interface MiGeneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (nonatomic, assign) CLLocationCoordinate2D currentLocation;
-(void)setMiGene:(MiGene *)migene;
@end
