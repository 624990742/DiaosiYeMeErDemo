//
//  UITextField+JCTextFieldCategory.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (JCTextFieldCategory)
#pragma mark - For length
- (void)jc_limitTextFieldWithLength:(NSInteger)maxLength;

#pragma mark - For bytes length
//你需要实现下面两个方法配合TextField代理使用
//通知中实现
- (void)jc_limitTextFieldWithBytesLength:(NSInteger)maxLength;
//需要在 textField: shouldChangeCharactersInRange: replacementString: 方法中实现
- (BOOL)jc_isEnabledWithBytesLength:(NSInteger)maxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
