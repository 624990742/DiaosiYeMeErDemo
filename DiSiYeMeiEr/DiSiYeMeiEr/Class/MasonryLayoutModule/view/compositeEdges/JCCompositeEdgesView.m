//
//  JCCompositeEdgesView.m
//  DiSiYeMeiEr
///Users/jiachen/Desktop/Masonry-master/Examples/Masonry iOS Examples/MASExampleSafeAreaLayoutGuideViewController.h
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCCompositeEdgesView.h"

@implementation JCCompositeEdgesView



- (id)init {
    self = [super init];
    if (!self) return nil;
    
    
     UIView *lastView = self;
    UIView *testView = [[UIView alloc] init];
    testView.backgroundColor =[UIColor orangeColor];
    [self addSubview:testView];
    [testView makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
    
    

    return self;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
