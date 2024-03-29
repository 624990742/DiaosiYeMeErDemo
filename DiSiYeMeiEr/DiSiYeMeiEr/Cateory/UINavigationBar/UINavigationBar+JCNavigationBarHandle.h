//
//  UINavigationBar+JCNavigationBarHandle.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/26.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface JCNavView : UIView
@property (nonatomic, assign) CGFloat   alpha;
@property (nonatomic, assign) BOOL      hiddenBottomLine;
@property (nonatomic, strong) UIColor   * _Nullable backColor;
@property (nonatomic, strong) UIImage   * _Nullable backImage;
@end

@interface UINavigationBar (JCNavigationBarHandle)

/**
 更改标题颜色和大小
 @param color 标题颜色
 @param font 标题大小
 */
- (void)jc_navBarTitleColor:(UIColor *_Nullable)color font:(UIFont *_Nullable)font;

/**
 更改导航栏颜色和图片

 @param color 颜色
 @param barImage 图片
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)jc_navBarBackGroundColor:(UIColor *_Nullable)color image:(UIImage *_Nullable)barImage isOpaque:(BOOL)opaque;

/**
 更改透明度

 @param alpha 导航栏透明度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)jc_navBarAlpha:(CGFloat)alpha isOpaque:(BOOL)opaque;

/**
 导航栏背景高度
 注意*这里并没有改导航栏高度，只是改了自定义背景高度

 @param height 高度
 @param opaque 样式，YES:状态字体为白色 NO:状态字体为黑色(默认)
 */
- (void)jc_navBarMyLayerHeight:(CGFloat)height isOpaque:(BOOL)opaque;

/**
 隐藏底线
 */
- (void)jc_navBarBottomLineHidden:(BOOL)hidden;

//还原回系统导航栏
- (void)jc_navBarToBeSystem;
@end

NS_ASSUME_NONNULL_END
