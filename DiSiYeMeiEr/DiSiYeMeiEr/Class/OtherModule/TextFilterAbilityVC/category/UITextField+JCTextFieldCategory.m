//
//  UITextField+JCTextFieldCategory.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "UITextField+JCTextFieldCategory.h"
#import "NSString+JCCustomString.h"
@implementation UITextField (JCTextFieldCategory)

- (void)jc_limitTextFieldWithBytesLength:(NSInteger)maxLength {
    NSString* toBeString = self.text;
    [self jc_cutTextFieldString:toBeString bytesLength:maxLength];
}

//需要在 textField: shouldChangeCharactersInRange: replacementString: 方法中实现
- (BOOL)jc_isEnabledWithBytesLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string {
    NSString* toBeString = [self.text stringByReplacingCharactersInRange:range withString:string];
    NSUInteger charLen = toBeString.jc_byteLength;
    if (charLen > maxLength) {
        if (![string isEqualToString:@""]) {
            if (self.text.jc_byteLength != maxLength) {
                
                //如果输入的最后一个字符是emoji, 且输入后超过最大限制字符编码,则return
                if (self.text.jc_byteLength + string.jc_byteLength > maxLength && [string jc_stringContainsEmoji]) {
                    return NO;
                }
                
                [self jc_cutTextFieldString:toBeString bytesLength:maxLength];
            }
            return NO;
        }
    }
    return YES;
}

- (void)jc_cutTextFieldString:(NSString *)textString bytesLength:(NSInteger)maxLength {
    while (textString.jc_byteLength > maxLength) {
        textString = [textString substringToIndex:textString.length - 1];
        self.text = textString;
    }
    
        NSString* lang = [[UITextInputMode currentInputMode] primaryLanguage];
        if ([lang isEqualToString:@"zh-Hans"]) {
            UITextRange* selectedRange = [self markedTextRange];
            //获取高亮部分
            UITextPosition* position = [self positionFromPosition:selectedRange.start offset:0];
            if (!position) {
                while (textString.jc_byteLength > maxLength) {
                    textString = [textString substringToIndex:textString.length - 1];
                    self.text = textString;
                }
            }
        } else {
            if (textString.length > maxLength) {
                self.text = [textString substringToIndex:maxLength];
            }
        }
}

@end
