//
//  JCUseingConstantsView.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCUseingConstantsView.h"

@implementation JCUseingConstantsView



- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *purpleView = UIView.new;
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self addSubview:purpleView];
    
    UIView *orangeView = UIView.new;
    orangeView.backgroundColor = UIColor.orangeColor;
    orangeView.layer.borderColor = UIColor.blackColor.CGColor;
    orangeView.layer.borderWidth = 2;
    [self addSubview:orangeView];
    
   
    [purpleView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@20);
        make.bottom.right.equalTo(@-20);
    }];
    
    
    //可以使用结构体指定位置和高度
    [orangeView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(CGPointMake(0, 0));
        make.size.equalTo(CGSizeMake(200, 100));
    }];
    
    


    return self;
}



//       @throw [NSException exceptionWithName:NSInternalInconsistencyException \
//                            reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] \
//                          userInfo:nil]


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
