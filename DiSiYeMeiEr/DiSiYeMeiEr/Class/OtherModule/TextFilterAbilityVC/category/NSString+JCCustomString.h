//
//  NSString+JCCustomString.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (JCCustomString)

- (NSInteger)jc_byteLength;
+ (int)jc_getCharacterFormStr:(NSString *)tempStr;
- (BOOL)jc_stringContainsEmoji;
- (NSUInteger)jc_lengthForChineseAndEnglish;
- (BOOL)jc_isChinese;
- (NSInteger)jc_getStringLenthOfBytes;
- (NSString *)jc_subBytesOfstringToIndex:(NSInteger)index;
- (BOOL)jc_validateChinese:(NSString *)string;
- (BOOL)jc_isMatchesRegularExp:(NSString *)regex;
- (BOOL)jc_stringContainsEmoji:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
