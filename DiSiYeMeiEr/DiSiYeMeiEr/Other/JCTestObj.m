//
//  JCTestObj.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2021/2/24.
//  Copyright © 2021 JCTrustYourself. All rights reserved.
//

#import "JCTestObj.h"

@implementation JCTestObj
static   JCTestObj *testObj = nil;

- (instancetype)init{
    if (self) {
        NSLog(@"%p",self);
    }
    return self;
}



@end
