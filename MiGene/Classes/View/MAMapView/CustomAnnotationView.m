//
//  CustomAnnotationView.m
//  MiGene
//
//  Created by Aaron on 15/7/22.
//  Copyright (c) 2015年 daqian. All rights reserved.
//

#import "CustomAnnotationView.h"

@interface CustomAnnotationView ()

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

#define kArrorHeight        10

@interface CustomAnnotationView ()

@end

@implementation CustomAnnotationView

-(id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.frame = CGRectMake(0, 0, 44, 55);
        _imageView = [[UIImageView alloc]init];
        _imageView.size = CGSizeMake(41, 41);
        _imageView.centerX = self.centerX;
        _imageView.centerY = self.centerY-15/2;
        [self addSubview:_imageView];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Headportrait"]];
    
    }
    return self;
}
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated
//{
//    if (self.selected == selected)
//    {
//        return;
//    }
//    
//    if (selected)
//    {
//        if (self.calloutView == nil)
//        {
//            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
//        }
//        
//        self.calloutView.portraitView.image = [UIImage imageNamed:@"icon-sharae"];
//        self.calloutView.title = self.annotation.title;
//        self.calloutView.subtitle = self.annotation.subtitle;
//        
//        [self addSubview:self.calloutView];
//    }
//    else
//    {
//        [self.calloutView removeFromSuperview];
//    }
//    
//    [super setSelected:selected animated:animated];
//}


//- (void)drawRect:(CGRect)rect
//{

//    [self drawInContext:UIGraphicsGetCurrentContext()];
    
//    [self drawTip];
    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//}

//- (void)drawTip
//{
//    // Drawing code
//    CGContextRef context =UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
//    CGContextMoveToPoint(context, 10.0, 20.0);
//    CGContextAddArc(context, 10.0, 20.0, 5.0, 10.0, 200.0, 1);
//    CGContextClosePath(context);
//    CGContextDrawPath(context, kCGPathFillStroke);
//}

//- (void)drawInContext:(CGContextRef)context
//{
//    
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
//    
//    [self getDrawPath:context];
//    CGContextFillPath(context);
//    
//}

//- (void)getDrawPath:(CGContextRef)context
//{
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    CGFloat minx = CGRectGetMinX(rrect),
//    CGFloat midx = CGRectGetMidX(rrect);
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    CGFloat maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
//    CGContextMoveToPoint(context, midx+5, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
//    CGContextAddLineToPoint(context,midx-5, maxy);
    
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//}
@end
