//
//  EmptyBackgroundView.m
//  SuperCard
//
//  Created by gfox on 15/6/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "EmptyBackgroundView.h"

@interface EmptyBackgroundView ()

@property(nonatomic, strong) UIImageView * imageView;

@end

@implementation EmptyBackgroundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(instancetype) initWithType:(BgImageType) type
{
    CGRect rcframe = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self = [super initWithFrame:rcframe];
    
    if (self) {
        self.backgroundColor = ColorRGBA(214, 214, 214, 1);
        UIImage * image = nil;
        switch (type) {
            case EmptyFriendCircle:
                image = [UIImage imageNamed:@"circle_empty"];
                break;
            case EmptyAddressBook:
                image = [UIImage imageNamed:@"friends_empty"];
                break;
            case EmptyMessage:
                image = [UIImage imageNamed:@"message_empty"];
                break;
            case EmptyOtherCircle:
                image = [UIImage imageNamed:@"message_of_cricle_empty"];
                break;
                
            default:
                break;
        }
        
        UIImageView * view = [[UIImageView alloc] initWithImage:image];
        view.center = self.center;
        [self addSubview:view];
    }
    
    return self;
}

-(instancetype) initWithImage:(UIImage *) image
{
    CGRect rcframe = CGRectMake(0, 0, kMainScreenWidth, kMainScreenHeight);
    self = [super initWithFrame:rcframe];
    
    if (self) {
        UIImageView * view = [[UIImageView alloc] initWithImage:image];
        view.center = self.center;
        [self addSubview:view];
    }
    
    return self;

}


-(void) setImage:(UIImage *) image
{
    if(self.imageView == nil)
    {
        self.backgroundColor = [UIColor clearColor];
        UIImageView * view = [[UIImageView alloc] initWithImage:image];
        view.x = 0;
        view.y = 0;
        //view.center = self.center;
        [self addSubview:view];
        self.imageView = view;
 
    }
    else{
        self.imageView.image = image;
        self.imageView.center = self.center;
    }
}


@end
