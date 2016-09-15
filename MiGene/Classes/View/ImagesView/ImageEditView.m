//
//  ImageEditView.m
//  SuperCard
//
//  Created by x1371 on 15/2/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "ImageEditView.h"
#import "UIButton+Lcy.h"

@interface ImageEditView()
@property (nonatomic, weak) UIImageView *imageView;
@end
@implementation ImageEditView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAll];
    }
    return self;
}

-(void)setupAll
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    UIButton *clearBtn = [UIButton buttonItemWithNormalImage:[UIImage imageNamed:@"btn_ImageEditView_clear"] highlightImage:nil target:self action:@selector(clearClick:)];
    clearBtn.center = CGPointMake(CGRectGetMaxX(imageView.frame), imageView.y);
    [self addSubview:clearBtn];
    self.clearBtn = clearBtn;
}

-(void)registerClearBlock:(ClearBlock)clearBlock
{
    self.clearBlock = clearBlock;
}

-(void)clearClick:(UIButton *)btn
{
    [self removeFromSuperview];
    if (self.clearBlock) {
        self.clearBlock(self.tag);
    }
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = _image ;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if ([self.clearBtn pointInside:[self.clearBtn convertPoint:point fromView:self] withEvent:event])
    {
        return self.clearBtn;
    }
    return [super hitTest:point withEvent:event];
}
@end
