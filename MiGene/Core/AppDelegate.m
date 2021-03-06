//
//  AppDelegate.m
//  MiGene
//
//  Created by Aaron on 15/7/21.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "AppDelegate.h"
#import "CCSideBarViewController.h"
#import <MAMapServices.h>
#import <AVFoundation/AVFoundation.h>
#import "LoginViewController.h"
#import "BaseNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *err = NULL;
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
    //    [audioSession setMode:AVAudioSessionModeMeasurement error:&err];
    
    if (err) {
        NSLog(@"There was an error creating the audio session");
    }
    [audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker
                                    error:NULL];
    if (err) {
        NSLog(@"There was an error sending the audio to the speakers");
    }
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    [MAMapServices sharedServices].apiKey = MAMapApiKey;
    CCSideBarViewController *sideBarViewController = [[CCSideBarViewController alloc] init];
    _window.rootViewController = sideBarViewController;
    
//    LoginViewController *loginViewController = [[LoginViewController alloc] init];
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:loginViewController];
//    _window.rootViewController = nav;
    
//    CCSideBarViewController *sideBarViewController = [[CCSideBarViewController alloc] init];
//    _window.rootViewController = sideBarViewController;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
