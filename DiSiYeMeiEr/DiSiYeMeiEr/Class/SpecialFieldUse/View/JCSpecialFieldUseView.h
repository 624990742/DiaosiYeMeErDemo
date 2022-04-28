//
//  JCSpecialFieldUseView.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/28.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 关键字说明：
 1.IBDesignable能实时更新视图。
 */
NS_ASSUME_NONNULL_BEGIN
@interface JCSpecialFieldUseView : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor* borderColor;
@property (nonatomic, strong) IBInspectable UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
