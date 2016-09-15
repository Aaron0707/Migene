//
//  MediaUtils.h
//  SuperCard
//
//  Created by x1371 on 15/4/2.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MediaUtils : NSObject
+ (BOOL)isCameraAvailable;

+ (BOOL)isPhotoLibraryAvaliable;

+ (BOOL)isPhotosAlbumAvaliable;

+ (BOOL)doesCameraSupportShootingVideos;

+ (BOOL)doesCameraSupportTakingPhotos;

+ (BOOL)isFrontCameraAvailable;

+ (BOOL)isRearCameraAvailable;

+ (BOOL)isFlashAvailableOnFrontCamera;

+ (BOOL)isFlashAvailableOnRearCamera;

+ (BOOL)isPhotoLibraryHasAuthorization;

+ (BOOL)isCameraHasAuthorization;

+ (BOOL)isAudioDeviceAvalible;

+ (BOOL)isAudioHasAuthorization;
@end
