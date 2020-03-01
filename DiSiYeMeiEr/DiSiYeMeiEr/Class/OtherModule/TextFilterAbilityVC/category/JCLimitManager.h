//
//  JCLimitManager.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/3/1.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TextFieldLimitDelegate <NSObject>
@optional
- (void)limitTextFieldDidChange:(UITextField*)textField;

@end
@interface JCLimitManager : NSObject
@property (nonatomic, assign) id<TextFieldLimitDelegate> limitDelegate;


///maxLength 限制最大的字符
- (void)limitTextField:(UITextField *)textField bytesLength:(NSInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
