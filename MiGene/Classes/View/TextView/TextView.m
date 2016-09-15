//
//  TextView.m
//  SuperCard
//
//  Created by x1371 on 15/2/3.
//  Copyright (c) 2015年 DQ. All rights reserved.
//

#import "TextView.h"
@interface TextView()
@property (nonatomic, weak) UILabel *placehoderLabel;
@property (nonatomic, weak) UIImageView *placehoderIV;
@end
@implementation TextView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor clearColor];
        
        //        UIImageView *placehoderIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"textview_placehoder_edit"]];
        //        placehoderIV.x = 5;
        //        placehoderIV.y = 7;
        //        [self addSubview:placehoderIV];
        //        self.placehoderIV = placehoderIV;
        
        // 添加一个显示提醒文字的label（显示占位文字的label）
        UILabel *placehoderLabel = [[UILabel alloc] init];
        //        placehoderLabel.x = CGRectGetMaxX(self.placehoderIV.frame);
        //        placehoderLabel.y = placehoderIV.y;
        placehoderLabel.x = 5;
        placehoderLabel.y = 7;
        
        placehoderLabel.numberOfLines = 0;
        placehoderLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:placehoderLabel];
        self.placehoderLabel = placehoderLabel;
        self.placehoderLabel.textColor = ColorRGBA(189, 189, 195, 1);
        self.placehoderLabel.width = self.width - 2 * self.placehoderLabel.x;
        self.placehoderLabel.height = self.placehoderLabel.font.lineHeight;
        
        self.font = [UIFont systemFontOfSize:14];
        self.placehoderLabel.font = self.font;
        
        // 监听内部文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 监听文字改变
- (void)textDidChange
{
    self.placehoderLabel.hidden = (self.text.length != 0);
    self.placehoderIV.hidden = self.placehoderLabel.hidden;
}

- (void)setPlacehoder:(NSString *)placehoder
{
    _placehoder = [placehoder copy];
    self.placehoderLabel.text = placehoder;
}
@end
