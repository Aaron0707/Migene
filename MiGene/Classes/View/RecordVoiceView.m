//
//  RecordVoiceView.m
//  MiGene
//
//  Created by Aaron on 15/7/22.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "RecordVoiceView.h"
#import "Tools.h"
//#import "ZLHistogramAudioPlot.h"
//#import "EZAudio.h"
#import "TextView.h"
#import "MiGeneService.h"
#import "AuthorizationUtils.h"
#import "UIImage+FixOrientation.h"
#import "UIBarButtonItem+Lcy.h"
#import "ImagesView.h"
#import <AVFoundation/AVFoundation.h>
#define L 25                //左边距
#define W kMainApplicationWidth-2*L //宽度

@interface RecordVoiceView ()<AVAudioPlayerDelegate,AVAudioRecorderDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSTimer *timer;
    NSTimer *timer2;
    NSInteger count;
    UIView *purple;
}
@property (nonatomic, strong)  UINavigationController * nav;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL *recordedTmpFile;


//=====上半部分view===
@property (nonatomic,strong)    UILabel  * explainLabel;
@property (nonatomic,strong)    UILabel  * latLabel;
@property (nonatomic,strong)    UILabel  * lngLabel;

@property (nonatomic,strong)    UIImageView *imageView;
@property (nonatomic,strong)    UILabel  * timeLabel;

//=====下半部分view===
@property (nonatomic,strong)    UIButton * nextStepButton;
@property (nonatomic,strong)    UIButton * repeatButton;
@property (nonatomic,strong)    UIButton * centerButton;

@property (nonatomic,strong)    UILabel  * nextStepLabel;
@property (nonatomic,strong)    UILabel  * repeatLabel;
@property (nonatomic,strong)    UILabel  * centerLabel;

@property (nonatomic,strong)    UIButton * photoButton;
@property (nonatomic,strong)    UIButton * eiditContentButton;
@property (nonatomic,strong)    UIButton * publicButton;
@property (nonatomic,strong)    UIButton * privateButton;
@property (nonatomic,strong)    UILabel  * publicLabel;
@property (nonatomic,strong)    UILabel  * privateLabel;
@property (nonatomic,strong)    UIButton * saveButton;
@property (nonatomic,strong)    TextView * contentView;
@property (nonatomic,strong)    ImagesView  * editImageView;

@end

@implementation RecordVoiceView

-(id)initInView:(UIView *)view{
    self = [super init];
    if (self) {
        self.size = view.size;
        self.center = view.center;
        self.hidden = YES;
        [self setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
        [view.window addSubview:self];
        
        centerView = [[UIView alloc] init];
        centerView.size = CGSizeMake(W, W);
        centerView.center = self.center;
        centerView.layer.cornerRadius = 10;
        purple = [[UIView alloc]initWithFrame:CGRectMake(0, -1, centerView.width, centerView.height*3/5)];
        [purple setBackgroundColor:MiGene_Color_Purple];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:purple.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(6, 6)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = purple.bounds;
        maskLayer.path = maskPath.CGPath;
        purple.layer.mask = maskLayer;
        
        
        [centerView addSubview:purple];
        [centerView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:centerView];
        
        UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(-5, -5, 40, 40)];
        closeButton.layer.cornerRadius = closeButton.width/2;
//        [closeButton setBackgroundColor:[UIColor grayColor]];
        [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [centerView addSubview:closeButton];
        
    }
    
    return self;
}



#pragma mark -bussness
-(void)stepOne{
    centerView.height = W;
    purple.height = centerView.height*3/5;
    [self.centerButton setBackgroundImage:[UIImage imageNamed:@"red-Microphone"] forState:UIControlStateNormal];
    self.centerButton.tag = 1;
    self.centerButton.hidden = NO;
    
    self.centerLabel.text = @"点击开始录音";
    self.centerLabel.hidden = NO;
    
    self.explainLabel.hidden = NO;
    self.lngLabel.hidden = NO;
    NSString * longitudestr = [NSString stringWithFormat:@"%f",self.userLocation.coordinate.longitude];
    self.lngLabel.text =  [NSString stringWithFormat:@"%@ %.0f° %@' %@\"",self.userLocation.coordinate.longitude>0?@"东经":@"西经",self.userLocation.coordinate.longitude,    [longitudestr substringWithRange:NSMakeRange(4, 2)],[longitudestr substringWithRange:NSMakeRange(6, 2)]];
    
    
    self.latLabel.hidden = NO;
    NSString * latitudestr = [NSString stringWithFormat:@"%f",self.userLocation.coordinate.latitude];
    self.latLabel.text =  [NSString stringWithFormat:@"%@  %.0f°  %@' %@\"",self.userLocation.coordinate.latitude>0?@"北纬":@"南纬",self.userLocation.coordinate.latitude,    [latitudestr substringWithRange:NSMakeRange(3, 2)],[latitudestr substringWithRange:NSMakeRange(5, 2)]];
}

-(void)stepTwo{
    centerView.height = W;
    
    self.repeatButton.hidden =
    self.repeatLabel.hidden =
    self.nextStepButton.hidden =
    self.nextStepLabel.hidden =
    self.explainLabel.hidden =
    self.latLabel.hidden =
    self.lngLabel.hidden = YES;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    [self.audioRecorder prepareToRecord];
    [self.audioRecorder record];
    
    self.imageView.hidden = NO;
    
    self.timeLabel.hidden = NO;
    
    self.centerButton.hidden = NO;
    self.centerButton.tag = 2;
    [self.centerButton setBackgroundImage:[UIImage imageNamed:@"Complete"] forState:UIControlStateNormal];
    self.centerLabel.text = @"点击结束录音";
    
    timer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(setVoiceImage)
                                            userInfo:nil
                                             repeats:YES];
    timer2 =  [NSTimer scheduledTimerWithTimeInterval:0.01
                                              target:self
                                            selector:@selector(setTimeLabelText)
                                            userInfo:nil
                                             repeats:YES];


}

-(void)stepThird{
    centerView.height = W;
    self.explainLabel.hidden =
    self.latLabel.hidden =
    self.lngLabel.hidden = YES;
    self.centerButton.hidden =
    self.timeLabel.hidden = NO;
    
    self.centerButton.tag = 3;
    [self.centerButton setBackgroundImage:[UIImage imageNamed:@"org-play"] forState:UIControlStateNormal];
    self.centerLabel.text = @"试听";
    
    self.nextStepButton.hidden = NO;
    self.nextStepLabel.hidden = NO;
    
    self.repeatButton.tag = 1;
    self.repeatButton.hidden = NO;
    self.repeatLabel.hidden = NO;
    
    
    //关闭录音
    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    [timer invalidate];
    timer = nil;
    [timer2 invalidate];
    timer2 = nil;
    
    
}

-(void)stepFour{
    
    [timer invalidate];
    timer = nil;
    [timer2 invalidate];
    timer2 = nil;
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
    self.centerButton.hidden =
    self.centerLabel.hidden =
    self.repeatLabel.hidden =
    self.repeatButton.hidden =
    self.nextStepLabel.hidden =
    self.nextStepButton.hidden =YES;
    
    self.saveButton.hidden =
    self.photoButton.hidden =
    self.eiditContentButton.hidden =
    self.publicButton.hidden =
    self.privateButton.hidden =
    self.publicLabel.hidden =
    self.privateLabel.hidden = NO;
    
    centerView.centerY = self.centerY;
}


-(void)centerbuttonAction:(UIButton *)button{
    switch (button.tag) {
        case 1:{
            [self stepTwo];
            break;
        }
        case 2:{
            [self stepThird];
            break;
        }
        case 3:{
            [self play];
            break;
        }
        default:
            break;
    }
}

-(void)repeatButtonAction:(UIButton *)button{
    [self.audioRecorder deleteRecording];
    [self stepOne];
}

-(void)changePhotoAction:(UIButton *)button{
    
    self.editImageView.hidden = !self.editImageView.hidden;
    if (self.editImageView.hidden) {
        centerView.height -=self.editImageView.height+30;
    }else{
        centerView.height +=self.editImageView.height+30;
    }
    [self stepFour];
}

-(void)addContentAction:(UIButton *)button{
    self.contentView.hidden = !self.contentView.hidden;
    if (self.contentView.hidden) {
        centerView.height -=self.contentView.height+20;
    }else{
        centerView.height +=self.contentView.height+20;
    }
    [self stepFour];
}

-(void)nextButtonAction{
    centerView.height =kMainScreenFrame.size.height!=480? W-50 :W-30;
    purple.height = centerView.height*2.3/5;
    [self stepFour];
}


-(void)play{
    
    timer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(setVoiceImage)
                                            userInfo:nil
                                             repeats:YES];
    timer2 =  [NSTimer scheduledTimerWithTimeInterval:0.01
                                               target:self
                                             selector:@selector(setPlayTimeLabelText)
                                             userInfo:nil
                                              repeats:YES];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
    }else{
        NSError * error;
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordedTmpFile error:&error];
        _audioPlayer.meteringEnabled = YES;
        _audioPlayer.delegate = self;
        [self.audioPlayer play];
    }
}

-(void)setVoiceImage{
    if (count==2) {
        count =0;
    }else {
        count ++;
    }
    [_imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_melody_%li",(long)count]]];
}
-(void)setTimeLabelText{
    if ([self.audioRecorder isRecording]) {
     _timeLabel.text = [NSString stringWithFormat:@"%.2f \"",self.audioRecorder.currentTime];
    }
}
-(void)setPlayTimeLabelText{
    if ([self.audioPlayer isPlaying]) {
     _timeLabel.text = [NSString stringWithFormat:@"%.2f \"",self.audioPlayer.currentTime];
    }
}

-(void)pushMigene{
    MiGene *migene = [MiGene new];
//    migene.vasible = !self.privateButton.selected;
    migene.voiceUrl = self.recordedTmpFile;

    __weak __typeof(self) weakSelf = self;
//    [MiGeneService createMiGene:migene Success:^(MiGene *MiGene) {
        [Tools showToastWithMessage:@"发布成功"];
        [weakSelf close];
//    } failure:^(NSError *error) {
//        
//    }];
}


#pragma mark -audio delegate
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [timer invalidate];
    timer = nil;
    [timer2 invalidate];
    timer2 = nil;
}

#pragma mark -private

-(void)takePhoto
{
    AuthorizationUtils *authorization = [[AuthorizationUtils alloc] init];
    authorization.presentVC = self.parentVc;
    if ([authorization authorizationCamera]) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        [self showPhoto:sourceType];
    }
}

-(void)localPhoto
{
    AuthorizationUtils *authorization = [[AuthorizationUtils alloc] init];
    authorization.presentVC = self.parentVc;
    if ([authorization authorizationPhotoLibrary]) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self showPhoto:sourceType];
    }
}

-(void)showPhoto:(UIImagePickerControllerSourceType) sourceType
{
    if([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = sourceType;
        imagePickerController.videoQuality=UIImagePickerControllerQualityTypeLow;
        [self.parentVc presentViewController:imagePickerController animated:YES completion:nil];
    }
    else
    {
        [Tools showToastWithMessage:@"不支持相机."];
    }
}

-(void)show{
    isClose = NO;
    [Tools popupAnimation:self duration:0.3];
}

-(void)close{
    _saveButton.hidden =
    _publicButton.hidden =
    _publicLabel.hidden =
    _privateLabel.hidden =
    _privateButton.hidden =
    _photoButton.hidden =
    _eiditContentButton.hidden =
    _editImageView.hidden =
    _imageView.hidden =
    _repeatButton.hidden =
    _nextStepLabel.hidden =
    _nextStepButton.hidden =
    _timeLabel.hidden =
    _repeatLabel.hidden = YES;

    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer stop];
    }
    if (self.recordedTmpFile) {
        [self.audioRecorder deleteRecording];
    }

    if ([self.audioRecorder isRecording]) {
        [self.audioRecorder stop];
    }
    isClose = YES;
    [Tools dismissAnimation:self duration:0.3];
}

-(void)animationDidStart:(CAAnimation *)anim{
    if (isClose) {
        [self performSelector:@selector(hideMySelf) withObject:nil afterDelay:0.2];
    }
}

-(void)hideMySelf{
    self.hidden = YES;
}

#pragma mark -setter & getter
-(UIButton *)centerButton{
    if (!_centerButton) {
        _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_centerButton setBackgroundColor:[UIColor whiteColor]];
        [centerView addSubview:_centerButton];
        [_centerButton addTarget:self action:@selector(centerbuttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _centerButton.size = CGSizeMake(centerView.width*8/27, centerView.width*8/27);
        _centerButton.layer.cornerRadius = _centerButton.width/2;
        [_centerButton setImageEdgeInsets:UIEdgeInsetsMake(7.5, 7.5, 7.5, 7.5)];
    }
    _centerButton.center = CGPointMake(centerView.width/2, centerView.height*3/5);
    return _centerButton;
}

-(UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = Chinese_Font_14;
        [centerView addSubview:_centerLabel];
        _centerLabel.size = CGSizeMake(_centerButton.width, 20);
    }
    _centerLabel.center = CGPointMake(_centerButton.centerX, _centerButton.centerY+_centerButton.height/2+20);
    return _centerLabel;
}

-(UILabel *)explainLabel{
    if (!_explainLabel) {
        _explainLabel = [[UILabel alloc]init];
        _explainLabel.textAlignment = NSTextAlignmentCenter;
        _explainLabel.font = Chinese_Font_14;
        _explainLabel.textColor = [UIColor whiteColor];
        _explainLabel.size = CGSizeMake(200, 20);
        [centerView addSubview:_explainLabel];
        _explainLabel.text = @"你的声音对应的坐标位置是";
    }
    _explainLabel.center = CGPointMake(centerView.width/2, 40);
    return _explainLabel;
}

-(UILabel *)lngLabel{
    
    if (!_lngLabel) {
        _lngLabel = [[UILabel alloc]init];
        _lngLabel.textAlignment = NSTextAlignmentCenter;
        _lngLabel.font = Chinese_Font_16;
        _lngLabel.textColor = [UIColor whiteColor];
        _lngLabel.size = CGSizeMake(200, 20);
        [centerView addSubview:_lngLabel];
        _lngLabel.center = CGPointMake(centerView.width/2, CGRectGetMaxY(_explainLabel.frame)+10);
        
    }
    
    return _lngLabel;
}

-(UILabel *)latLabel{
    if (!_latLabel) {
        _latLabel = [[UILabel alloc]init];
        _latLabel.textAlignment = NSTextAlignmentCenter;
        _latLabel.font = Chinese_Font_16;
        _latLabel.textColor = [UIColor whiteColor];
        _latLabel.size = CGSizeMake(200, 20);
        [centerView addSubview:_latLabel];
        _latLabel.center = CGPointMake(centerView.width/2, CGRectGetMaxY(_lngLabel.frame)+10);
        _latLabel.text = [NSString stringWithFormat:@"%.0f°",self.userLocation.coordinate.latitude];
        
    }
    return _latLabel;
}

-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
        
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        //Now that we have our settings we are going to instanciate an instance of our recorder instance.
        //Generate a temp file for use by the recording.
        //This sample was one I found online and seems to be a good choice for making a tmp file that
        //will not overwrite an existing one.
        //I know this is a mess of collapsed things into 1 call.  I can break it out if need be.
        _recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"mp4"]]];
        //Setup the recorder to use this file and record to it.
        NSError *error;
        _audioRecorder = [[ AVAudioRecorder alloc] initWithURL:_recordedTmpFile settings:recordSetting error:&error];
        //Use the recorder to start the recording.
        //Im not sure why we set the delegate to self yet.
        //Found this in antother example, but Im fuzzy on this still.
        [_audioRecorder setDelegate:self];
    }

    return _audioRecorder;
}


-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_melody_0"]];
        _imageView.size = CGSizeMake(centerView.width*85/270, centerView.width*2/9);
        [purple addSubview:_imageView];
    }
    _imageView.center = CGPointMake(centerView.width/2, 50);
    return _imageView;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = Chinese_Font_16;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.size = CGSizeMake(80, 20);
        [centerView addSubview:_timeLabel];
        _timeLabel.text = @"0.00 \"";
    }
    _timeLabel.center = CGPointMake(_imageView.centerX+5, CGRectGetMaxY(_imageView.frame)+10);
    return _timeLabel;
}
-(UIButton *)nextStepButton{
    if (!_nextStepButton) {
        _nextStepButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextStepButton setBackgroundImage:[UIImage imageNamed:@"green-Right"] forState:UIControlStateNormal];
        [_nextStepButton setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [_nextStepButton setBackgroundColor:[UIColor whiteColor]];
        [centerView addSubview:_nextStepButton];
        _nextStepButton.size = CGSizeMake(37.5, 37.5);
        _nextStepButton.layer.cornerRadius = _nextStepButton.width/2;
        [_nextStepButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    _nextStepButton.center = CGPointMake(CGRectGetMaxX(_centerButton.frame)+50, _centerButton.centerY+20);
    return _nextStepButton;
}

-(UILabel *)nextStepLabel{
    if (!_nextStepLabel) {
        _nextStepLabel = [[UILabel alloc]init];
        _nextStepLabel.textAlignment = NSTextAlignmentCenter;
        _nextStepLabel.font = Chinese_Font_12;
        _nextStepLabel.textColor = _centerLabel.textColor;
        _nextStepLabel.size = CGSizeMake(80, 20);
        [centerView addSubview:_nextStepLabel];
        _nextStepLabel.text = @"下一步";
    }
    _nextStepLabel.center = CGPointMake(_nextStepButton.centerX, CGRectGetMaxY(_nextStepButton.frame)+20);
    return _nextStepLabel;
}

-(UIButton *)repeatButton{
    if (!_repeatButton) {
        _repeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repeatButton setBackgroundImage:[UIImage imageNamed:@"red-repeat"] forState:UIControlStateNormal];
        [_repeatButton setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        [_repeatButton setBackgroundColor:[UIColor whiteColor]];
        [centerView addSubview:_repeatButton];
        _repeatButton.size = CGSizeMake(37.5, 37.5);
        _repeatButton.layer.cornerRadius = _repeatButton.width/2;
        [_repeatButton addTarget:self action:@selector(repeatButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _repeatButton.center = CGPointMake(CGRectGetMinX(_centerButton.frame)-50, _centerButton.centerY+20);
    return _repeatButton;
}

-(UILabel *)repeatLabel{
    if (!_repeatLabel) {
        _repeatLabel = [[UILabel alloc]init];
        _repeatLabel.textAlignment = NSTextAlignmentCenter;
        _repeatLabel.font = Chinese_Font_12;
        _repeatLabel.textColor = _centerLabel.textColor;
        _repeatLabel.size = CGSizeMake(80, 20);
        [centerView addSubview:_repeatLabel];
        _repeatLabel.text = @"重复";
    }
    _repeatLabel.center = CGPointMake(_repeatButton.centerX, CGRectGetMaxY(_repeatButton.frame)+20);
    return _repeatLabel;
}

-(UIButton *)photoButton{
    if (!_photoButton) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoButton setBackgroundImage:[UIImage imageNamed:@"icon-camera"] forState:UIControlStateNormal];
        [_photoButton setBackgroundColor:[UIColor whiteColor]];
        [centerView addSubview:_photoButton];
        _photoButton.size = CGSizeMake(21, 16);
        [_photoButton addTarget:self action:@selector(changePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _photoButton.center = CGPointMake(centerView.width-60,!self.editImageView.hidden?CGRectGetMaxY(self.editImageView.frame)+30:!self.contentView.hidden?CGRectGetMaxY(self.contentView.frame)+20 :purple.height+20);
    return _photoButton;
}

-(UIButton *)eiditContentButton{
    if (!_eiditContentButton) {
        _eiditContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eiditContentButton setBackgroundImage:[UIImage imageNamed:@"icon-edit"] forState:UIControlStateNormal];
        [_eiditContentButton setBackgroundColor:[UIColor whiteColor]];
        [centerView addSubview:_eiditContentButton];
        _eiditContentButton.size = CGSizeMake(21, 18);
        [_eiditContentButton addTarget:self action:@selector(addContentAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    _eiditContentButton.center = CGPointMake(centerView.width-15,!self.editImageView.hidden?CGRectGetMaxY(self.editImageView.frame)+30:!self.contentView.hidden?CGRectGetMaxY(self.contentView.frame)+20 :purple.height+20);
    return _eiditContentButton;

}

-(UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.size = CGSizeMake(centerView.width-20, 41);
        UIImage *bcImage = [UIImage imageNamed:@"save-migene"];
        [_saveButton setBackgroundImage:bcImage forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:[UIImage imageNamed:@"save-migene-dis"] forState:UIControlStateHighlighted];
        [_saveButton setBackgroundColor:[UIColor whiteColor]];
        [_saveButton setTitle:@"发 布" forState:UIControlStateNormal];
        [_saveButton setTitleColor:MiGene_Color_Purple forState:UIControlStateNormal];
        [centerView addSubview:_saveButton];
        [_saveButton addTarget:self action:@selector(pushMigene) forControlEvents:UIControlEventTouchUpInside];
    }
    _saveButton.center = CGPointMake(centerView.width/2, centerView.height-40);
    return _saveButton;

}

-(UIButton *)publicButton{
    if (!_publicButton) {
        _publicButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_publicButton setImage:[UIImage imageNamed:@"choice-2"] forState:UIControlStateNormal];
        [_publicButton setImage:[UIImage imageNamed:@"choice-1"] forState:UIControlStateSelected];
        _publicButton.selected = YES;
        [centerView addSubview:_publicButton];
    }
    _publicButton.frame = CGRectMake(30, CGRectGetMinY(_saveButton.frame)-40, 30, 30);
    return _publicButton;
}
-(UIButton *)privateButton{
    if (!_privateButton) {
        _privateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_privateButton setImage:[UIImage imageNamed:@"choice-2"] forState:UIControlStateNormal];
        [_privateButton setImage:[UIImage imageNamed:@"choice-1"] forState:UIControlStateSelected];
        [centerView addSubview:_privateButton];
    }
    _privateButton.frame = CGRectMake(centerView.width-125, CGRectGetMinY(_saveButton.frame)-40, 30, 30);
    return _privateButton;
}

-(UILabel *)publicLabel{
    if (!_publicLabel) {
        _publicLabel = [UILabel new];
        _publicLabel.textAlignment = NSTextAlignmentLeft;
        _publicLabel.font = Chinese_Font_12;
        [centerView addSubview:_publicLabel];
        _publicLabel.text = @"所有人可见";
    }
    _publicLabel.frame = CGRectMake(CGRectGetMaxX(_publicButton.frame), CGRectGetMinY(_publicButton.frame)+5, 80, 20);
    
    return _publicLabel;
}

-(UILabel *)privateLabel{
    if (!_privateLabel) {
        _privateLabel = [UILabel new];
        _privateLabel.font = Chinese_Font_12;
        [centerView addSubview:_privateLabel];
        _privateLabel.text = @"仅自己可见";
    }
    _privateLabel.frame = CGRectMake(CGRectGetMaxX(_privateButton.frame), CGRectGetMinY(_privateButton.frame)+5, 80, 20);
    return _privateLabel;
}

-(ImagesView *)editImageView{
    if (!_editImageView) {
        CGRect rect = CGRectMake(10, self.contentView.hidden?CGRectGetMaxY(purple.frame)+10:CGRectGetMaxY(self.contentView.frame)+10, centerView.width-20, 80);
        _editImageView = [[ImagesView alloc] initWithFrame:rect imagesType:ImagesTypeEdit marginX:10];
        _editImageView.parentVC = self.parentVc;
        _editImageView.hidden = YES;
        [_editImageView setBackgroundColor:ColorRGBA(234, 234, 234, 1)];
        _editImageView.layer.cornerRadius = 4;
        [centerView addSubview:_editImageView];
    }
    CGRect rect = CGRectMake(10, self.contentView.hidden?CGRectGetMaxY(purple.frame)+10:CGRectGetMaxY(self.contentView.frame)+10, centerView.width-20, 80);
    _editImageView.frame = rect;
    return _editImageView;
}

-(UITextView *)contentView{
    if (!_contentView) {
        _contentView = [[TextView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(purple.frame)+20, centerView.width-20, 60)];
        _contentView.placehoder = @"想说点什么";
        _contentView.hidden = YES;
        _contentView.layer.cornerRadius = 4;
        [_contentView setBackgroundColor:ColorRGBA(234, 234, 234, 1)];
        [centerView addSubview:_contentView];
    }
    return _contentView;
}

@end
