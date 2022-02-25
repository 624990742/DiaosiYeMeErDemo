//
//  NSString+JCMethond.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/23.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "NSString+JCMethond.h"

@implementation NSString (JCMethond)
/*
  将 lowercaseString 交换成 JC_customLowercaseString
 这段代码看上去好像会陷入递归调用的死循环， 不过大家要记住， 此方法是准备和
 lowercaseString 方法互换的。所以， 在运行期， eoc_ rnyLowercaseString 选择子实际上对应千
 原有的lowercaseString 方法实现
 */
- (NSString *)JC_customLowercaseString{
    NSString *lowercase = [self JC_customLowercaseString];
    NSLog(@"%@==>%@",self,lowercase);

    
    return lowercase;
}

- (BOOL)isChineseText
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
@end
