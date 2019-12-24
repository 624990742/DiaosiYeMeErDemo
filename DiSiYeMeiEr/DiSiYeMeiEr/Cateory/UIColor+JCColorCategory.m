//
//  UIColor+JCColorCategory.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/23.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "UIColor+JCColorCategory.h"

@implementation UIColor (JCColorCategory)

/** 随机颜色值 */
+(UIColor*)RandomColor{
   NSInteger aRedValue =arc4random() %255;
   NSInteger aGreenValue =arc4random() %255;
   NSInteger aBlueValue =arc4random() %255;
 UIColor*randColor = [UIColor colorWithRed:aRedValue/255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
  
    return randColor;
}

@end
