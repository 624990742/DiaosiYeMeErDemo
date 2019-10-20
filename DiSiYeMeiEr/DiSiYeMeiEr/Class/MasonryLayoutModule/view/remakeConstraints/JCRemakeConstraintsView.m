//
//  JCRemakeConstraints.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCRemakeConstraintsView.h"

@interface  JCRemakeConstraintsView ()

@property (nonatomic, strong) UIButton *movingButton;
@property (nonatomic, assign) BOOL topLeft;

- (void)toggleButtonPosition;

@end


@implementation JCRemakeConstraintsView



- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.movingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.movingButton setTitle:@"Move Me!" forState:UIControlStateNormal];
    self.movingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.movingButton.layer.borderWidth = 3;
    
    [self.movingButton addTarget:self action:@selector(toggleButtonPosition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.movingButton];
    
    self.topLeft = YES;
    
    return self;
}



+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}


- (void)updateConstraints{
    [self.movingButton  remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(150));
        if (self.topLeft) {
            make.left.equalTo(self.left).offset(10);
            make.top.equalTo(self.top).offset(10);
            
        }else{
            make.bottom.equalTo(self.bottom).offset(-10);
            make.right.equalTo(self.right).offset(-10);
        }
    }];
    
    [super updateConstraints];
}





- (void)toggleButtonPosition {
    self.topLeft = !self.topLeft;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
