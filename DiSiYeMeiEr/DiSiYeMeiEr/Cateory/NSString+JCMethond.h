//
//  NSString+JCMethond.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/23.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCMethond)
- (NSString *)JC_customLowercaseString;
/** 是否是纯中文 */
- (BOOL)isChineseText;
@end

NS_ASSUME_NONNULL_END
