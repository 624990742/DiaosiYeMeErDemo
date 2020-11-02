//
//  NSString+LeeLabelAddtion.h
//  FrameWork
//
//  Created by LeeMiao on 2017/9/1.
//  Copyright © 2017年 Limiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (LeeLabelAddtion)

#pragma mark - StringAttribute.

/**
 获取 字符串 的给定宽度情况下的高度

 @param attribute 字符串 的字典属性 比如attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @param width 字符串  给定宽度
 @return 字符串 的字符串高度
 */
-(CGFloat)heightWithStrAttri:( NSDictionary<NSString *, id> * _Nonnull )attribute withLabelWidth:(CGFloat)width;



/**
 获取 字符串 一行的总长度

 @param attribute 字符串 的字典属性 比如attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @return 字符串 的字符串宽度
 */
-(CGFloat)widthWithStrAttri:(NSDictionary<NSString *,id> *_Nullable)attribute;





/**
 获取一行的高度

 @param attribute 字符串 的字典属性 比如attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18.f]}
 @return 字符串 的字符串宽度
 */
+ (CGFloat)heightOfOneLineWithStrAttri:(NSDictionary<NSString *, id> *_Nullable)attribute;





#pragma mark - Font.
/**
 获取 字符串 的给定宽度情况下的高度
 
 @param font 字体 和 大小
 @param width 字符串  给定宽度
 @return 字符串 的字符串高度
 */
-(CGFloat)heightWithFont:(UIFont *_Nullable)font withLabelWidth:(CGFloat)width;



/**
 获取 字符串 一行的总长度
 
 @param font 字体 和 大小
 @return 字符串 的字符串宽度
 */
-(CGFloat)widthWithFont:(UIFont *_Nullable)font;





/**
 获取一行的高度
 
 @param font 字典属性
 @return 高度
 */
+ (CGFloat)heightOfOneLineWithFont:(UIFont *_Nullable)font;


/**
 获取一行 文字的宽度

 @param string 字符串
 @param font 字号
 @param maxsize 最大尺寸
 @return 返回size
 */
+ (CGSize)getSizeByString:(NSString *_Nullable)string fontSize:(CGFloat)font size:(CGSize)maxsize;




@end
