//
//  PlayVoiceView.m
//  MiGene
//
//  Created by Aaron on 15/7/23.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "PlayVoiceView.h"
#import "Tools.h"
#import <AVFoundation/AVFoundation.h>
#import "UIButton+EnlargeEdge.h"
#import "UILabel+StringFrame.h"
#import "ImagesView.h"

#import "DetailViewController.h"
#import "BaseNavigationController.h"

#define L 40
#define W (kMainApplicationWidth-2*L)

#define PlayButtonBoardWidth 12

@interface PlayVoiceView()<AVAudioPlayerDelegate, AVAudioRecorderDelegate, UIScrollViewDelegate>{
    NSTimer *_timer;
    NSInteger count;
    UILabel *_timeLabel;//时间 label
    UIImageView *_voiceImageView; // 播放音频的 图片
    UIView *_topView;  //放 图片或者 描述或者 人物信息的view
    UIButton *_playbutton; //播放，暂停按钮
    NSInteger imageCount;
}

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) NSURL *recordedTmpFile;

@property (weak, nonatomic) ImagesView *imagesView;


@end

@implementation PlayVoiceView

-(id)initInView:(UIView *)view{
    self = [super init];
    if (self) {
        self.size = view.size;
        self.center = view.center;
        self.hidden = YES;
        [self setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5]];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        count = 0;
        self.playType = @"all";
        [self addCenterView];
        [self addSubCenterView];
        [self addTapGesture];
    }
    
    return self;
}

//添加中间的view
- (void)addCenterView
{
    centerView = [[UIView alloc] init];
    if ([self.playType isEqualToString:@"all"])
    {
        centerView.size = CGSizeMake(W, W / 18.f * 19);
    }
    else if ([self.playType isEqualToString:@"text"])
    {
        centerView.size = CGSizeMake(W, W / 54.f * 39);
    }else if ([self.playType isEqualToString:@"none"])
    {
        centerView.size = CGSizeMake(W, W / 54.f * 39);
    }
    
    centerView.center = self.center;
    [centerView setBackgroundColor:[UIColor whiteColor]];
    centerView.layer.cornerRadius = 10;
    centerView.layer.masksToBounds = YES;
    [self addSubview:centerView];
}

//添加中间的view的子控件
- (void)addSubCenterView
{
    
    if ([self.playType isEqualToString:@"all"]) {
        //图片，文字，声音 都有
        [self creatAllTypeUI];
    }else if ([self.playType isEqualToString:@"text"])
    {
        [self creatTextUI];
    }else if ([self.playType isEqualToString:@"none"])
    {
        [self creatNoneUI];
    }
    [self creatCommonUI];
}

- (void)creatAllTypeUI
{
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(centerView.frame), CGRectGetHeight(centerView.frame)/57.f * 37)];
    [centerView addSubview:_topView];
    //图片
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:_topView.bounds];
//    imageView.backgroundColor = [UIColor greenColor];
//    imageView.image = [UIImage imageNamed:@"splash_bg.png"];
//    [_topView addSubview:imageView];
    imageCount = 3;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:_topView.bounds];
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(_topView.frame) * imageCount, CGRectGetHeight(_topView.frame));
    scrollView.pagingEnabled = YES;
    [_topView addSubview:scrollView];
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i *CGRectGetWidth(_topView.frame), 0, CGRectGetWidth(_topView.frame), CGRectGetHeight(_topView.frame))];
        imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        imageView.image = [UIImage imageNamed:@"splash_bg.png"];
        imageView.tag = i * 100;
        [scrollView addSubview:imageView];
    }
    
    UILabel *currentPageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(_topView.frame) / 2 - 50, 10, 100, 20)];
    currentPageLabel.font = Chinese_Font_12;
    currentPageLabel.textColor = [UIColor whiteColor];
    currentPageLabel.text = @"1/5";
    currentPageLabel.textAlignment = NSTextAlignmentCenter;
    [_topView addSubview:currentPageLabel];
    
    //文字透明背景view
    UIView *textView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topView.frame) - CGRectGetHeight(centerView.frame)/57.f * 9, CGRectGetWidth(centerView.frame), CGRectGetHeight(centerView.frame)/57.f * 9)];
    textView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [_topView addSubview:textView];
    
    //文字label
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, (CGRectGetHeight(centerView.frame)/57.f * 9 - 40) / 2, CGRectGetWidth(_topView.frame) - 47 - 27, 40)];
    label.numberOfLines = 2;
    label.textColor = [UIColor whiteColor];
    label.font = Chinese_Font_13;
    label.text = @"xxxxxxxxxxxxxxxx";
    [textView addSubview:label];
    
}

- (void)creatTextUI
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(centerView.frame), CGRectGetHeight(centerView.frame)/39.f * 19)];
    _topView.backgroundColor = MiGene_Color_Purple;
    [centerView addSubview:_topView];
    
    //文字
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(32 , CGRectGetHeight(_topView.frame) / 2 - 23.5, CGRectGetWidth(centerView.frame) - 73, 47)];
    textLabel.font = Chinese_Font_13;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.numberOfLines = 3;
    textLabel.text = @"xxxxxxxxx";
    CGSize size = [textLabel boundingRectWithSize:CGSizeMake(CGRectGetWidth(centerView.frame) - 73, MAXFLOAT)];
    NSLog(@"%@",NSStringFromCGSize(size));
    [_topView addSubview:textLabel];
}

- (void)creatNoneUI
{
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(centerView.frame), CGRectGetHeight(centerView.frame)/39.f * 19)];
    _topView.backgroundColor = MiGene_Color_Purple;
    [centerView addSubview:_topView];
    
    //头像
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14.f * CGRectGetWidth(centerView.frame) / 54, CGRectGetHeight(_topView.frame) / 2 - 25, 50, 50)];
    headerImageView.layer.cornerRadius = CGRectGetWidth(headerImageView.frame)/2;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.image = [UIImage imageNamed:@"splash_bg.png"];
    [_topView addSubview:headerImageView];
    
    //昵称
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headerImageView.frame) + 8, CGRectGetMinY(headerImageView.frame) + 15, CGRectGetWidth(_topView.frame) - CGRectGetMaxX(headerImageView.frame) + 8 - 20, 13)];
    nickNameLabel.font = Chinese_Font_13;
    nickNameLabel.textColor = [UIColor whiteColor];
    nickNameLabel.text = @"王军发的";
    [_topView addSubview:nickNameLabel];
    
    //时间
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nickNameLabel.frame), CGRectGetMaxY(nickNameLabel.frame) + 5, CGRectGetWidth(nickNameLabel.frame), 12)];
    timeLabel.textColor = [UIColor colorWithRed:184/255.f green:140/255.f blue:184/255.0 alpha:1];
    timeLabel.text = @"2小时前";
    timeLabel.font = Chinese_Font_10;
    [_topView addSubview:timeLabel];
}

- (void)creatCommonUI
{
    //暂停
    _playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playbutton.frame = CGRectMake(CGRectGetWidth(centerView.frame) - PlayButtonBoardWidth - 47, CGRectGetMaxY(_topView.frame) - 23.5, 47, 47);
    [_playbutton setImage:[UIImage imageNamed:@"PlayVoice"] forState:UIControlStateNormal];
    [_playbutton setImage:[UIImage imageNamed:@"StopVoice"] forState:UIControlStateSelected];
    [_playbutton addTarget:self action:@selector(playFile:) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:_playbutton];
    
    //声音播放 展示的imageView
    _voiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(centerView.frame) / 2 - 42.5, CGRectGetMaxY(_topView.frame) + CGRectGetHeight(centerView.frame)/57.f * 2, 85, 60)];
    _voiceImageView.image = [UIImage imageNamed:@"ic_melody_0"];
    [centerView addSubview:_voiceImageView];
    
    //播放长度label
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_voiceImageView.frame), CGRectGetMaxY(_topView.frame) + 50, 80, 14)];
    _timeLabel.text = @"114\"";
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = Chinese_Font_13;
    [centerView addSubview:_timeLabel];
    
    //查看详情按钮
//    UIButton *detailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    detailButton.frame = CGRectMake(12, CGRectGetHeight(centerView.frame) - 24, 60, 14);
//    [detailButton setTitle:@"查看详情" forState:UIControlStateNormal];
//    [detailButton.titleLabel setFont:Chinese_Font_13];
//    [detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [detailButton setEnlargeEdge:10];
//    [detailButton addTarget:self action:@selector(detailClick:) forControlEvents:UIControlEventTouchUpInside];
//    [centerView addSubview:detailButton];
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, CGRectGetHeight(centerView.frame) - 24, 60, 14)];
    detailLabel.text = @"查看详情";
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.font = Chinese_Font_13;
    [centerView addSubview:detailLabel];
    
    //点赞数量label
    NSString *countText = @"12";
    CGSize timeSize = [countText sizeWithAttributes:@{NSFontAttributeName:Chinese_Font_13, NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
    UILabel *praiseCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(centerView.frame) - 12 - timeSize.width, CGRectGetHeight(centerView.frame) - 9 - timeSize.height, timeSize.width, timeSize.height)];
    praiseCountLabel.font = Chinese_Font_13;
    praiseCountLabel.textColor = [UIColor lightGrayColor];
    praiseCountLabel.text = countText;
    [centerView addSubview:praiseCountLabel];
    
    //点赞的图片
    UIImageView *praiseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(praiseCountLabel.frame) - 20, CGRectGetMidY(praiseCountLabel.frame) - 7, 17, 15)];
    praiseImageView.image = [UIImage imageNamed:@"gray-heart"];
    [centerView addSubview:praiseImageView];
    
    //关闭按钮
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(7, 7, 13, 13)];
    [closeButton setEnlargeEdge:(44 - CGRectGetWidth(closeButton.frame))/2];
    closeButton.layer.cornerRadius = closeButton.width/2;
    closeButton.backgroundColor = [UIColor grayColor];
    //    [closeButton setTitle:@"关" forState:UIControlStateNormal];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [centerView addSubview:closeButton];
}

// 添加一个tap手势点击查看详情

- (void)addTapGesture
{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [centerView addGestureRecognizer:tapGesture];
    
    if ([self.playType isEqualToString:@"none"]) {
        UITapGestureRecognizer *headerTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTapGesture:)];
        [_topView addGestureRecognizer:headerTapGesture];
    }
}

- (void)headerTapGesture:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"点击了头像区域 要查看人的详情");
}

- (void)tapGestureAction:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"点击了centerView");
    [self close];
    
    DetailViewController *viewController = [[DetailViewController alloc] init];
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:viewController];
    viewController.playType = self.playType;
    
    [self.parentVc presentViewController:nav animated:YES completion:nil];
}

//暂停  播放
- (void)playFile:(UIButton *)sender {
    
    if (sender.selected == YES) {
        sender.selected = NO;
    }
    else
    {
        sender.selected = YES;
    }
    // Create Audio Player
//    if (self.audioPlayer) {
//        if (self.audioPlayer.playing) {
//            [self.audioPlayer stop];
//        }
//        self.audioPlayer = nil;
//    }
//    
    // Close the audio file
//    if (self.recorder) {
//        [self.recorder closeAudioFile];
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *url =[NSURL URLWithString:@"http://gather-hz.oss-cn-hangzhou.aliyuncs.com/0B1D5730-37FD-4904-A7B3-7D8D3EF512F9.mp4"];
            NSData * audioData = [NSData dataWithContentsOfURL:url];
            
            //将数据保存到本地指定位置
            NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp4", docDirPath , @"temp"];
            [audioData writeToFile:filePath atomically:YES];
            //播放本地音乐
            NSURL *fileURL = [NSURL fileURLWithPath:filePath];
            
            
            
            NSError *err;
            self.audioPlayer =
            [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL
                                                   error:&err];
            self.audioPlayer.meteringEnabled = YES;
            if (self.audioPlayer) {
                if (sender.selected) {
                    [self.audioPlayer play];
                }
                else
                {
                    [self.audioPlayer stop];
                }
            }
            
            self.audioPlayer.delegate = self;
            
            if (!_timer)
            {
                _timer =  [NSTimer scheduledTimerWithTimeInterval:0.5
                                                           target:self
                                                         selector:@selector(setVoiceImage)
                                                         userInfo:nil
                                                          repeats:YES];
            }
            if (sender.selected)
            {
                [_timer setFireDate:[NSDate date]];
            }else
            {
                [_timer setFireDate:[NSDate distantFuture]];
            }
        });
    });
    
}

-(void)show{
    isClose = NO;
    [Tools popupAnimation:self duration:0.3];
    if (count != 0) {
        count = 0;
        [_voiceImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_melody_%li",(long)count]]];
    }
    
}

-(void)close{
    _playbutton.selected = NO;
    isClose = YES;
    [_timer setFireDate:[NSDate distantFuture]];
    [Tools dismissAnimation:self duration:0.3];
    [_timer invalidate];
    _timer = nil;
}

-(void)animationDidStart:(CAAnimation *)anim{
    if (isClose) {
        [self performSelector:@selector(hideMySelf) withObject:nil afterDelay:0.2];
    }
}

-(void)hideMySelf{
    self.hidden = YES;
}


-(AVAudioRecorder *)audioRecorder{
    if (!_audioRecorder) {
        NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
        
        [recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
        
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
        //We call this to start the recording process and initialize
        //the subsstems so that when we actually say "record" it starts right away.
        [_audioRecorder prepareToRecord];
        //Start the actual Recording
    }
    //    if ([_audioRecorder isRecording]) {
    //        [_audioRecorder stop];
    //    }
    return _audioRecorder;
}

-(void)setVoiceImage{
    [_audioRecorder updateMeters];
    _timeLabel.text = [NSString stringWithFormat:@"%.2f\"",self.audioRecorder.currentTime];
    if (count==2) {
        count =0;
    }else{
        count ++;
    }
    [_voiceImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_melody_%li",(long)count]]];
}

#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x < 0 || scrollView.contentOffset.x > (imageCount - 1) * CGRectGetWidth(centerView.frame)) {
        scrollView.scrollEnabled = NO;
    }else if(scrollView.contentOffset.x >= 0 || scrollView.contentOffset.x <= (imageCount - 1) * CGRectGetWidth(centerView.frame))
    {
        scrollView.scrollEnabled = YES;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    scrollView.scrollEnabled = YES;
}

@end
