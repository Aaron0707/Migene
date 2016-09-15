//
//  ImagesView.h
//  SuperCard
//
//  Created by x1371 on 15/2/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    ImagesTypeEdit,
    ImagesTypeShow,
    ImagesTypeShowBig
}ImagesType;

@class ImagesView;
@protocol ImagesViewDelegate <NSObject>

-(void)ImagesViewChangeImage:(ImagesView *)imagesView;

@end

@interface ImagesView : UIView
-(id)initWithFrame:(CGRect)frame imagesType:(ImagesType)imagesType marginX:(CGFloat)marginX;
@property (nonatomic, strong) NSMutableArray *imagesData;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, weak) UIViewController *parentVC;
@property (nonatomic, weak) id<ImagesViewDelegate> delegate;
-(void)setImageUrls:(NSString *)imageUrl width:(CGFloat)w height:(CGFloat)h;

@property(nonatomic, assign) BOOL bCanTapImage;
@end


