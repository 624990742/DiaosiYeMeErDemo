//
//  UIButton+customeBtn.h
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/27.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, JCButtonImagePosition) {
    
    JCButtonImagePositionLeft,
    JCButtonImagePositionRight,
    JCButtonImagePositionTop,
    JCButtonImagePositionBottom
};

/****
 方法描述： 重新摆放按钮的image和label, 注意调用时机，按钮的大小确定之后再去调用
 参数1：position    图片的位置
 参数2：space      图片和文字之间的距离
 ****/
@interface UIButton (customeBtn)

-(void)customPlaceImageTitlePosition:(JCButtonImagePosition)position space:(CGFloat)space;
@end
