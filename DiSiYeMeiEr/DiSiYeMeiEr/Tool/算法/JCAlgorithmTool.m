//
//  JCAlgorithmTool.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/7/12.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//
/**
 数据结构与算法之美学习案例代码
 */
#import "JCAlgorithmTool.h"

@implementation JCAlgorithmTool
+(void)testDemo{
    NSLog(@"测试方法-->%d",cal(10));
}

int cal(int n) {
  int sum = 0;
  int i = 1;
  for (; i <= n; ++i) {
    sum = sum + i;
  }
  return sum;
}

@end
