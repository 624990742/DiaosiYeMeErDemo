//
//  NSString+JCCustomString.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "NSString+JCCustomString.h"

@implementation NSString (JCCustomString)

//注：第一个方法 emoji也按2个字符算， 第二个方法用Unicode编码后是按4个字符算的

#pragma mark - func one
- (NSInteger)jc_byteLength {
    //拿到所有str的length长度（包括中文英文..都算为1个字符）
    NSUInteger len = self.length;
    //汉字字符集
    NSString* pattern = @"[\u4e00-\u9fa5]";
    //正则表达式筛选条件
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    //计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    //len已经把中文算进去了，中文少的一个字符通过numMatch个数来补充，效果就是中文2个字符，英文1个字符
    return len + numMatch;
}

#pragma mark - func two
//判断字符串的字符个数
+ (int)jc_getCharacterFormStr:(NSString *)tempStr {
    int strlength = 0;
    char* p = (char*)[tempStr cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[tempStr lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}

- (BOOL)jc_stringContainsEmoji
{
    // 过滤所有表情。returnValue为NO表示不含有表情，YES表示含有表情
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}




#pragma mark - 开发调试
- (NSUInteger)jc_lengthForChineseAndEnglish
{
    NSInteger length = 0;
    NSString *str = self;
    for (NSUInteger i = 0; i < [str length]; i++) {
        unichar ch = [str characterAtIndex:i];
        if (ch > 128) {
            length += 2;
        } else {
            length += 1;
        }
    }
    return length;
}




- (BOOL)jc_isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}


// NSString分类方法：
- (NSInteger)jc_getStringLenthOfBytes {
    NSInteger length = 0;
    for (int i = 0; i < [self length]; i++) {
        //截取字符串中的每一个字符
        //        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        //        if ([self validateChineseChar:s]) {
        //            length += 2;
        //            NSLog(@"length += 2");
        //        } else {
        length += 1;
        NSLog(@"length += 1;");
        //        }
    }
    return length;
}

- (NSString *)jc_subBytesOfstringToIndex:(NSInteger)index {
    NSInteger length = 0;
    
    NSInteger chineseNum = 0;
    NSInteger zifuNum = 0;
    
    for (int i = 0; i < [self length]; i++) {
        //截取字符串中的每一个字符
        //        NSString *s = [self substringWithRange:NSMakeRange(i, 1)];
        //        if ([self validateChineseChar:s]) {
        //            if (length + 2 > index) {
        //                return [self substringToIndex:chineseNum + zifuNum];
        //            }
        //
        //            length += 2;
        //
        //            chineseNum += 1;
        //        } else {
        if (length + 1 > index) {
            return [self substringToIndex:chineseNum + zifuNum];
        }
        length += 1;
        
        zifuNum += 1;
        //        }
    }
    return [self substringToIndex:index];
}

//检测中文或者中文符号
- (BOOL)jc_validateChineseChar:(NSString *)string {
    NSString *nameRegEx = @"[\\u0391-\\uFFE5]";
    if (![string jc_isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

//检测中文
- (BOOL)jc_validateChinese:(NSString *)string {
    NSString *nameRegEx = @"[\u4e00-\u9fa5]";
    if (![string jc_isMatchesRegularExp:nameRegEx]) {
        return NO;
    }
    return YES;
}

- (BOOL)jc_isMatchesRegularExp:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

//表情符号的判断
- (BOOL)jc_stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        if (0x278b <= hs && hs <= 0x2792) {
                                            //自带九宫格拼音键盘
                                            returnValue = NO;;
                                        }else if (0x263b == hs) {
                                            returnValue = NO;;
                                        }else {
                                            returnValue = YES;
                                        }
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}
@end
