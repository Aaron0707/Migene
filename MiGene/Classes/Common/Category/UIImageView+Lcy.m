//
//  UIImageView+Lcy.m
//  签到办公
//
//  Created by Lcyu on 14-9-12.
//  Copyright (c) 2014年 Our Dream. All rights reserved.
//

#import "UIImageView+Lcy.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIImage+Lcy.h"

@implementation UIImageView (Lcy)
+(id)imageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    return imageView;
}

+(id)imageViewWithRadius:(CGFloat) Radius;
{
    UIImageView *imageView = [self imageView];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = Radius;
    return imageView;
}

+(id)imageViewWithRadius:(CGFloat) Radius borderWidth:(CGFloat) borderWidth
{
    UIImageView *imageView = [self imageView];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = Radius;
    imageView.layer.borderWidth = borderWidth;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    return imageView;
}

-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString
{
    [self roundImageViewWithURL:urlString placeholderImagePathString:imagePathString borderWidth:2.0f];
}

-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString borderWidth:(CGFloat) borderWidth
{
    [self setImageWithURL:urlString placeholderImagePathString:imagePathString];
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = MIN(self.frame.size.width, self.frame.size.height)/2;
}

-(void)roundImageViewWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString borderWidth:(CGFloat) borderWidth scaledToSize:(CGSize)size
{
    [self setImageWithURL:urlString placeholderImagePathString:imagePathString scaledToSize:size];
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = MIN(self.frame.size.width, self.frame.size.height)/2;
}

+(id)roundImageViewWithPathString:(NSString *)imagePathString
{
    UIImage *image = [UIImage imageNamed:imagePathString];
    if (image) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.layer.borderWidth = 2.0f;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = MIN(imageView.frame.size.width, imageView.frame.size.height)/2;
        return imageView;
    }
    return nil;
}

-(void) setImageWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString
{
    if (urlString && ![urlString isKindOfClass:[NSNull class]])
    {
        UIImage *placeholderImage = imagePathString ? [UIImage imageNamed:imagePathString] : nil;
        [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }
    else
    {
        self.image = [UIImage imageNamed:imagePathString];
    }
}

-(void) setImageWithURL:(NSString *)urlString image:(UIImage *)image placeholderImagePathString:(NSString *)imagePathString
{
    if (urlString&& ![urlString isKindOfClass:[NSNull class]])
    {
        UIImage *placeholderImage = imagePathString ? [UIImage imageNamed:imagePathString] : nil;
        [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }
    else if (image)
    {
        self.image = image;
    }
    else
    {
        self.image = [UIImage imageNamed:imagePathString];
    }
}


-(void) setImageWithURL:(NSString *)urlString placeholderImagePathString:(NSString *)imagePathString scaledToSize:(CGSize)size
{
    if (urlString && ![urlString isKindOfClass:[NSNull class]])
    {
        UIImage *placeholderImage = imagePathString ? [UIImage imageNamed:imagePathString] : nil;
        [self sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:placeholderImage options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.image = [image scaledToSize:size];
        }];
    }
    else
    {
        self.image = [UIImage imageNamed:imagePathString];
    }
}
@end
