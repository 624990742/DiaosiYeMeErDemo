//
//  JCLimitManager.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCLimitManager.h"
#import "UITextField+JCTextFieldCategory.h"
#import "NSString+JCCustomString.h"
@interface JCLimitManager() <UITextFieldDelegate>

@property (nonatomic, assign) NSInteger maxNumberOfDescriptionChars;    //最大限制字符个数

@end

@implementation JCLimitManager

- (void)limitTextField:(UITextField *)textField bytesLength:(NSInteger)maxLength {
    //赋值代理
    textField.delegate = self;
    self.maxNumberOfDescriptionChars = maxLength;
}


#pragma mark - UITextFieldDelegate

// 监听文本改变
- (void)textFieldDidChange:(UITextField*)textField
{
    [textField jc_limitTextFieldWithBytesLength:self.maxNumberOfDescriptionChars];
    
    //设置代理 (扩展)
    if (self.limitDelegate && [self.limitDelegate respondsToSelector:@selector(limitTextFieldDidChange:)]) {
        [self.limitDelegate limitTextFieldDidChange:textField];
    }
}


#pragma mark-- UITextfielfDelegate imp
- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string
{
    return [textField jc_isEnabledWithBytesLength:self.maxNumberOfDescriptionChars shouldChangeCharactersInRange:range replacementString:string];
}

@end
