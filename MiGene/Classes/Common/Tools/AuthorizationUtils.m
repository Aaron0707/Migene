//
//  AuthorizationUtils.m
//  SuperCard
//
//  Created by x1371 on 15/4/2.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "AuthorizationUtils.h"
#import "MediaUtils.h"

@implementation AuthorizationUtils

- (BOOL)authorizationCamera
{
    if (![MediaUtils isCameraAvailable] || ![MediaUtils doesCameraSupportShootingVideos]) {
        NSString *title = @"相机信息";
        NSString *message = @"当前设备的摄像头无法使用";
        NSString *cancelTitle = @"好的";
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [_presentVC presentViewController:alertController animated:YES completion:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
            [alert show];
        }
        return NO;
    }
    else if (![MediaUtils isCameraHasAuthorization]) {
        NSString *title = @"无法使用您的相机";
        NSString *message = @"请确保您已允许应用使用您的相册。您可以在系统设置 > 隐私 > 相机 中找到这些选项。";
        NSString *cancelTitle = @"好的";
        NSString *settingTitle = @"设置";
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *settingAction = [UIAlertAction actionWithTitle:settingTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:settingAction];
            [_presentVC presentViewController:alertController animated:YES completion:nil];
            
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
            [alert show];
        }
        return NO;
    }
    return YES;
}

- (BOOL)authorizationPhotoLibrary
{
    if ([MediaUtils isPhotoLibraryAvaliable]) {
        if ([MediaUtils isPhotoLibraryHasAuthorization]) {//是否有权限访问相册
            return YES;
        }
        else {
            NSString *title = @"无法使用您的相册";
            NSString *message = @"请确保您已允许应用使用您的相册。您可以在系统设置 > 隐私 > 照片 中找到这些选项。";
            NSString *cancelTitle = @"好的";
            NSString *settingTitle = @"设置";
            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
                UIAlertAction *settingAction = [UIAlertAction actionWithTitle:settingTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                [alertController addAction:cancelAction];
                [alertController addAction:settingAction];
                [_presentVC presentViewController:alertController animated:YES completion:nil];
            }
            else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
                [alert show];
            }
            return NO;
        }
    }
    else {
        NSString *title = @"照片信息";
        NSString *message = @"当前设备的相册无法使用";
        NSString *cancelTitle = @"好的";
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            [_presentVC presentViewController:alertController animated:YES completion:nil];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil, nil];
            [alert show];
        }
        return NO;
    }
}
@end
