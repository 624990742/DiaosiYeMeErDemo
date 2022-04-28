//
//  JCSpecialFieldUseViewTest2.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/28.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCSpecialFieldUseViewTest2.h"

@implementation JCSpecialFieldUseViewTest2

- (void)setBgColor:(UIColor *)bgColor{
    self.backgroundColor = bgColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}
- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
