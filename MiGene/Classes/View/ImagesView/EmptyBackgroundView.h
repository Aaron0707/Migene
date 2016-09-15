//
//  EmptyBackgroundView.h
//  SuperCard
//
//  Created by gfox on 15/6/9.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, BgImageType) {
    EmptyFriendCircle,
    EmptyOtherCircle,
    EmptyAddressBook,
    EmptyMessage
};
@interface EmptyBackgroundView : UIView

-(instancetype) initWithType:(BgImageType) type;

-(instancetype) initWithImage:(UIImage *) image;


-(void) setImage:(UIImage *) image;
@end
