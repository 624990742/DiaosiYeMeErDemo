//
//  JCSpecialFieldUseViewTest2.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/28.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 关键字说明：
 1.IBDesignable能实时更新视图。
 2.IB_DESIGNABLE 在xib中实时显示
 （注意该关键字只能在用纯代码自定的文件中生效，如果自定义的文件本身就带xib貌似不管用）
 */
NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE 
@interface JCSpecialFieldUseViewTest2 : UIView
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor* borderColor;
@property (nonatomic, strong) IBInspectable UIColor *bgColor;
@end

NS_ASSUME_NONNULL_END
