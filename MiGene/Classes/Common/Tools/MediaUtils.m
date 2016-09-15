//
//  MediaUtils.m
//  SuperCard
//
//  Created by x1371 on 15/4/2.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "MediaUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@implementation MediaUtils
#pragma mark 摄像头是否可用
+ (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
}

+ (BOOL)isPhotoLibraryAvaliable
{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (BOOL)isPhotosAlbumAvaliable
{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeSavedPhotosAlbum];
}
#pragma mark 判断媒体资源是否可用(摄像头、Photo库等)。
+ (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType
{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:
     ^(id obj, NSUInteger idx, BOOL *stop) {
         NSString *mediaType = (NSString *)obj;
         if ([mediaType isEqualToString:paramMediaType]){
             result = YES;
             *stop= YES;
         }
     }];
    return result;
}

#pragma mark 是否支持摄像
+ (BOOL)doesCameraSupportShootingVideos
{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark 是否支持拍照
+ (BOOL)doesCameraSupportTakingPhotos
{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark 前摄像头是否可用
+ (BOOL)isFrontCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

#pragma mark 后摄像头是否可用
+ (BOOL)isRearCameraAvailable
{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark 前闪光灯是否可用，检查闪光灯前会先检查摄像头是否可用，不用重复检查
+ (BOOL)isFlashAvailableOnFrontCamera
{
    return [UIImagePickerController isFlashAvailableForCameraDevice: UIImagePickerControllerCameraDeviceFront];
}

#pragma mark 后闪光灯是否可用
+ (BOOL)isFlashAvailableOnRearCamera
{
    return [UIImagePickerController isFlashAvailableForCameraDevice: UIImagePickerControllerCameraDeviceRear];
}

#pragma mark 相册用户设置的权限
+ (BOOL)isPhotoLibraryHasAuthorization
{
    __block BOOL isAvalible = NO;
    ALAuthorizationStatus authStatus = [ALAssetsLibrary authorizationStatus];
    
    if(authStatus == ALAuthorizationStatusRestricted){
    }
    else if(authStatus == ALAuthorizationStatusDenied){
    }
    else if(authStatus == ALAuthorizationStatusAuthorized){
        isAvalible = YES;
    }
    else if(authStatus == ALAuthorizationStatusNotDetermined){
        isAvalible = YES;
    }
    else {
    }
    return isAvalible;
}

#pragma mark 摄像头用户设置的权限
+ (BOOL)isCameraHasAuthorization
{
    __block BOOL isAvalible = NO;
    NSString *mediaType = AVMediaTypeVideo; // Or AVMediaTypeAudio
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted){
    }
    else if(authStatus == AVAuthorizationStatusDenied){
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){
        isAvalible = YES;
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){
        isAvalible = YES;
    }
    else {
    }
    return isAvalible;
}

#pragma mark 设备是否有麦克风
+ (BOOL)isAudioDeviceAvalible
{
    return [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio].count > 0;
}

#pragma mark 麦克风用户设置的权限
+ (BOOL)isAudioHasAuthorization
{
    __block BOOL isAvalible = NO;
    NSString *mediaType = AVMediaTypeAudio; // Or AVMediaTypeAudio
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus == AVAuthorizationStatusRestricted){
    }
    else if(authStatus == AVAuthorizationStatusDenied){
    }
    else if(authStatus == AVAuthorizationStatusAuthorized){
        isAvalible = YES;
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){
        isAvalible = YES;
    }
    else {
    }
    return isAvalible;
}

@end
