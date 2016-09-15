//
//  UIImageView+Lcy.h
//  签到办公
//
//  Created by Lcyu on 14-9-12.
//  Copyright (c) 2014年 Our Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Lcy)
+(id)imageView;
+(id)imageViewWithRadius:(CGFloat) Radius;
+(id)imageViewWithRadius:(CGFloat) Radius borderWidth:(CGFloat) borderWidth;

-(void) setImageWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString;
-(void) setImageWithURL:(NSString *)urlString image:(UIImage *)image placeholderImagePathString:(NSString *)imagePathString;
-(void) setImageWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString scaledToSize:(CGSize)size;

-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString;
-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString borderWidth:(CGFloat) borderWidth;
-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString borderWidth:(CGFloat) borderWidth scaledToSize:(CGSize)size;

+(id)roundImageViewWithPathString:(NSString *)imagePathString;
@end
