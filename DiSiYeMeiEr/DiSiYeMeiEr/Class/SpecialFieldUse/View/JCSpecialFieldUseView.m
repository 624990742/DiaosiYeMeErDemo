//
//  JCSpecialFieldUseView.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/28.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCSpecialFieldUseView.h"


@implementation JCSpecialFieldUseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setupUI];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self setupUI];
}
- (void)setupUI{
    self.backgroundColor = self.bgColor;
    self.layer.cornerRadius = self.cornerRadius;
    self.layer.borderWidth = self.borderWidth;
    self.layer.borderColor = self.borderColor.CGColor;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
