//
//  JCPhone.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/7/17.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCPhone.h"

@implementation JCPhone
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"%p",self);
        NSLog(@"self-->%@",NSStringFromClass([self class]));
        NSLog(@"=================");
        NSLog(@"super-->%@",NSStringFromClass([super  class]));
    }
    return self;
}
@end
