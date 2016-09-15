//
//  ViewController.m
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "RecordVoiceView.h"
#import "PlayVoiceView.h"
#import "CustomAnnotationView.h"
#import "Tools.h"
#import "VoiceListViewController.h"


#define maxZoomLevel 17.10
#define minZoomLevel 14.25

@interface ViewController ()<MAMapViewDelegate>
{
    MAMapView * _mapView;
    
}
@property (nonatomic, strong) RecordVoiceView * recordView;
@property (nonatomic, strong) PlayVoiceView * playView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    _mapView.zoomLevel = 17.10;
    _mapView.showsUserLocation =
    _mapView.showsScale = YES;
    _mapView.zoomEnabled =
    _mapView.scrollEnabled = NO;
    _mapView.scaleOrigin = CGPointMake(10, kMainScreenHeight-40);
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.view addSubview:_mapView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"me"] style:UIBarButtonItemStylePlain target:self action:@selector(showLeft)];
    
    
    //附近的声音
    UIButton * nearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [nearButton setBackgroundImage:[UIImage imageNamed:@"nearVoice"] forState:UIControlStateNormal];
    nearButton.frame = CGRectMake((self.view.width-150)/2, 100, 150, 40);
    nearButton.backgroundColor = [UIColor whiteColor];
    [nearButton setTitle:@"听附近的声音" forState:UIControlStateNormal];
    [nearButton setImage:[UIImage imageNamed:@"Right"] forState:UIControlStateNormal];
    [nearButton setImageEdgeInsets:UIEdgeInsetsMake(10, 120, 10, 25)];
    [nearButton setTitleEdgeInsets:UIEdgeInsetsMake(10, 15, 10, 30)];
    [nearButton addTarget:self action:@selector(nearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nearButton];
    
    //左下角加减按钮
    UIView * controlView = [[UIView alloc]initWithFrame:CGRectMake(kMainApplicationWidth-60, kMainApplicationHeight-80, 30, 80)];
    [controlView setBackgroundColor:[UIColor whiteColor]];
    controlView.layer.borderColor = [UIColor grayColor].CGColor;
    controlView.layer.borderWidth = 0.5;
    controlView.layer.cornerRadius = 4;
    UIButton * upButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 40)];
    [upButton setTitle:@"+" forState:UIControlStateNormal];
    [upButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 40, 30, 0.5)];
    [line setBackgroundColor:[UIColor grayColor]];
    UIButton * subButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 40, 30, 40)];
    [subButton setTitle:@"-" forState:UIControlStateNormal];
    [subButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [controlView addSubview:upButton];
    [controlView addSubview:subButton];
    [controlView addSubview:line];
    [self.view addSubview:controlView];
    upButton.tag = 1;
    subButton.tag = 2;
    [upButton addTarget:self action:@selector(updateZoomLevel:) forControlEvents:UIControlEventTouchUpInside];
    [subButton addTarget:self action:@selector(updateZoomLevel:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"xxxxxxxxx" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor lightGrayColor]];
    button.frame = CGRectMake(0, 0, 200, 100);
    button.center = (CGPoint){self.view.center.x,self.view.center.y + 100};
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickXXX:) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)clickXXX:(UIButton *)sender
{
    [self playVoice];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(30.5738850000, 104.0610990000);
        pointAnnotation.title = @"德商国际C座";
        pointAnnotation.subtitle = @"德商国际C座";
    
        [_mapView addAnnotation:pointAnnotation];
    
        MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
        pointAnnotation1.coordinate = CLLocationCoordinate2DMake(30.5668210000, 104.0634190000);
        pointAnnotation1.title = @"环球中心";
        pointAnnotation1.subtitle = @"环球中心";
    
        [_mapView addAnnotation:pointAnnotation1];
        MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc] init];
        pointAnnotation2.coordinate = CLLocationCoordinate2DMake(30.5706460000, 104.0531950000);
        pointAnnotation2.title = @"锦城公园";
        pointAnnotation2.subtitle = @"锦城公园";
    
        [_mapView addAnnotation:pointAnnotation2];
}

-(void)showLeft{
    if (self.back) {
        self.back();
    }
}

-(void)resetLocation{
    if (_mapView.userLocation.location) {
        [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)nearButtonAction:(UIButton *)button{
    VoiceListViewController * vc = [[VoiceListViewController alloc]initWithStyle:UITableViewStylePlain];
    vc.location = _mapView.userLocation.coordinate;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -MAmapDelegate
-(void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    if (_mapView.userLocation.location) {
        [_mapView setCenterCoordinate:_mapView.userLocation.location.coordinate animated:YES];
        NSLog(@"%@",[NSString stringWithFormat:@"%f",_mapView.userLocation.coordinate.longitude]);
    }
}

-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:reuseIndetifier];
        }
        annotationView.imageView.image = [UIImage imageNamed:@"icon-sharae"];
        //设置中⼼心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -annotationView.height/2);
        return annotationView;
    }else if([annotation isKindOfClass:[MAUserLocation class]]){
        static NSString *reuseIndetifier = @"userAnnotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
        }
        annotationView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tape"]];
        annotationView.frame = CGRectMake(0, 0, 70.5, 94.9);
        //设置中⼼心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -annotationView.height/2);
        annotationView.highlighted =YES;
        return annotationView;
    }
    
    return nil;
}
-(void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    
    [_mapView deselectAnnotation:view.annotation animated:YES];
    if ([view.annotation isKindOfClass:[MAUserLocation class]]){
        MAUserLocation *location =_mapView.userLocation;
        
        if (location) {
            self.recordView.userLocation =location;
            [self beganRecordVoice];
        }else{
            [Tools showToastWithMessage:@"定位不成功"];
        }
    }else{
        [self playVoice];
    }
    
    
}
-(void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    
}

#pragma mark - setter && getter

-(RecordVoiceView *)recordView{
    if (!_recordView) {
        _recordView = [[RecordVoiceView alloc]initInView:self.view];
        _recordView.parentVc = self;
    }
    return _recordView;
}

-(PlayVoiceView *)playView{
    if (!_playView) {
        _playView = [[PlayVoiceView alloc]initInView:self.view];
        _playView.parentVc = self;
    }
    return _playView;
}

#pragma mark - Action
-(void)beganRecordVoice{
    [self.recordView show];
    [self.recordView stepOne];
}
-(void)playVoice{
    [self.playView show];
}

-(void)updateZoomLevel:(UIButton *)button{
    switch (button.tag) {
        case 1:{
            double currentLevel = _mapView.zoomLevel;
            if (currentLevel<maxZoomLevel) {
                currentLevel+=0.5;
                [_mapView setZoomLevel:currentLevel animated:YES];
            }
            break;
        }
        default:{
            double currentLevel = _mapView.zoomLevel;
            if (currentLevel>minZoomLevel) {
                currentLevel-=0.5;
                [_mapView setZoomLevel:currentLevel animated:YES];
            }
            break;
        }
    }
}
@end
