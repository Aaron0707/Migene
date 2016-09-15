//
//  UIView+Extension.m
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

-(UIImage *)screenshot
{
//    UIGraphicsBeginImageContext(self.frame.size);//全屏截图，包括window
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:context];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    CGContextRelease(context);
//    UIGraphicsEndImageContext();
//    return viewImage;
    UIGraphicsBeginImageContext(self.bounds.size);//全屏截图，包括window
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

+ (UIView *)topView {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if (window.subviews.count > 0) {
        return [window.subviews objectAtIndex:0];
    } else {
        return window;
    }
}
@end
