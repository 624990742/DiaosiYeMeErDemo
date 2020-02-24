//
//  JCShowView.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/2/24.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCShowView.h"

@implementation JCShowView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bgImage];
        [self btn];
    }
    return self;
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:self.bounds];
        _bgImage.image = [UIImage imageNamed:@"timg"];
        [self addSubview:_bgImage];
    }
    return _bgImage;
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setFrame:self.bounds];
        [self addSubview:_btn];
    }
    return _btn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
