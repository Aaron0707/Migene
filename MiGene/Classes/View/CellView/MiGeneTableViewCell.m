//
//  MiGeneTableViewCell.m
//  MiGene
//
//  Created by Aaron on 15/7/28.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "MiGeneTableViewCell.h"
#import "UIImageView+Lcy.h"
#import "MiGene.h"
#import "Tools.h"
#import <AVFoundation/AVFoundation.h>
#import "MiGeneService.h"
#import <CoreLocation/CoreLocation.h>
@interface MiGeneTableViewCell()<AVAudioPlayerDelegate>{
    NSTimer * timer;
    NSInteger count;
    NSURL *fileURL;
}
@property (nonatomic, strong) NSString * voiceUrl;
@property (nonatomic, strong) MiGene *migene;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playButtonHeightConstraints;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playButtonWidthConstraints;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation MiGeneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.playButton setImage:[UIImage imageNamed:@"migene-pause-1"] forState:UIControlStateSelected];
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.cornerRadius = self.headerImageView.width/2;
    [self.praiseButton setImage:[UIImage imageNamed:@"red-heart"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setMiGene:(MiGene *)migene{
    self.migene = migene;
    [self.headerImageView setImageWithURL:migene.user.avatar placeholderImagePathString:YLHeaderImage];
    self.timeLabel.text = [Tools timeStringWithInput:migene.createTime];
    self.nameLabel.text = migene.user.nickname;
    NSInteger imageCount = 0;
    for (MiGeneContent * centent in migene.content) {
        if ([centent.type isEqualToString:@"text"]) {
            self.contentLabel.text =centent.value;
        }else if ([centent.type isEqualToString:@"image"] && STRINGHASVALUE(centent.value)) {
            imageCount ++;
        }else if([centent.type isEqualToString:@"voice"]){
            self.voiceTimeLabel.text = [NSString stringWithFormat:@"%@\"",centent.size];
            self.voiceUrl = centent.value;
        }
        
    }
    self.imageCountLabel.text = [NSString stringWithFormat:@"%ld",(long)imageCount];
    [self.praiseButton setTitle:[NSString stringWithFormat:@"%ld",(long)migene.likeCount] forState:UIControlStateNormal];
    self.praiseButton.selected = migene.currentUserIsLike;
   
    CLLocation * location1 = [[CLLocation alloc] initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude];
    CLLocation * location2 = [[CLLocation alloc] initWithLatitude:migene.lat longitude:migene.lng];
    CLLocationDistance kilometers=[location1 distanceFromLocation:location2]/1000;
    self.locationLabel.text = [NSString stringWithFormat:@"%.2fm",kilometers];
}


- (IBAction)play:(UIButton *)sender {
    sender.enabled = NO;
    if (sender.selected) {
        [timer invalidate];
        timer = nil;
        sender.selected = NO;
        if ([self.audioPlayer isPlaying]) {
            [self.audioPlayer pause];
        }
        sender.enabled = YES;
        return;
    }
    
    sender.selected = YES;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
    }else{
        if (!fileURL) {
            NSURL *url = [[NSURL alloc]initWithString:self.voiceUrl];
            
            NSData * audioData = [NSData dataWithContentsOfURL:url];
            //将数据保存到本地指定位置
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *voiceFile = [NSString stringWithFormat:@"%@/%@.mp4", docDirPath , @"temp"];
            [audioData writeToFile:voiceFile atomically:YES];
            //播放本地音乐
            fileURL = [NSURL fileURLWithPath:voiceFile];
        }
        NSError * error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        _audioPlayer.meteringEnabled = YES;
        _audioPlayer.delegate = self;
        [self.audioPlayer play];
        timer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(setVoiceImage)
                                                userInfo:nil
                                                 repeats:YES];
        self.playButtonWidthConstraints.constant = 52;
        self.playButtonHeightConstraints.constant = 45;
    }
    sender.enabled = YES;

}

#pragma mark - audio delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [timer invalidate];
    timer = nil;
    self.playButtonWidthConstraints.constant = 40;
    self.playButtonHeightConstraints.constant = 40;
    self.playButton.selected = NO;
}

- (IBAction)praiseAction:(id)sender {
    self.praiseButton.enabled = NO;
    if (self.praiseButton.selected) {
        __weak __typeof(self) weakSelf = self;
        [MiGeneService cancelLikeMiGeneWithMiGeneId:self.migene.migeneId Success:^(id response) {
            [Tools showToastWithMessage:@"取消成功"];
            weakSelf.praiseButton.enabled = YES;
        } failure:^(NSError *error) {
            [Tools showToastWithMessage:@"取消失败"];
            weakSelf.praiseButton.enabled = YES;
        }];
    }else{
        __weak __typeof(self) weakSelf = self;
        [MiGeneService likeMiGeneWithMiGeneId:self.migene.migeneId Success:^(id response) {
            [Tools showToastWithMessage:@"点赞成功"];
            weakSelf.praiseButton.enabled = YES;
        } failure:^(NSError *error) {
            [Tools showToastWithMessage:@"点赞失败"];
            weakSelf.praiseButton.enabled = YES;
        }];
    }
}


-(void)setVoiceImage{
    if (count==2) {
        count =0;
    }else {
        count ++;
    }
    [self.playButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"migene-pause-%li",(long)count]] forState:UIControlStateSelected];
}
@end
