//
//  NSString+LeeLabelAddtion.m
//  FrameWork
//
//  Created by LeeMiao on 2017/9/1.
//  Copyright © 2017年 Limiao. All rights reserved.
//

#import "NSString+LeeLabelAddtion.h"

@implementation NSString (LeeLabelAddtion)


-(CGFloat)heightWithStrAttri:(NSDictionary<NSString *,id> *)attribute withLabelWidth:(CGFloat)width{

    CGFloat height = 0;
    if (self.length) { //NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
        height = rect.size.height;
    }
    return height;
}


-(CGFloat)widthWithStrAttri:(NSDictionary<NSString *,id> *)attribute{

    CGFloat width = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil];
        width = rect.size.width;
    }
    return width;
}


+ (CGFloat)heightOfOneLineWithStrAttri:(NSDictionary<NSString *,id> *)attribute{
    CGFloat height = 0;
    CGRect rect    = [@"LeeAddtion" boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    height = rect.size.height;
    return height;
}


#pragma mark ------



-(CGFloat)heightWithFont:(UIFont *)font withLabelWidth:(CGFloat)width{
    CGFloat height = 0;
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
        
        height = rect.size.height;
    }
    return height;
    
}

- (CGFloat)widthWithFont:(UIFont *)font{
    CGFloat width = 0;
    
    if (self.length) {
        CGRect rect = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:@{NSFontAttributeName: font} context:nil];
        
        width = rect.size.width;
    }
    
    return width;
    
}

+ (CGFloat)heightOfOneLineWithFont:(UIFont *)font{
    CGFloat height = 0;
    CGRect rect    = [@"LeeAddtion" boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |  NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil];
    height = rect.size.height;
    return height;
}
    
+ (CGSize)getSizeByString:(NSString *)string fontSize:(CGFloat)font size:(CGSize)maxsize {
    CGSize size = [string boundingRectWithSize:maxsize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return size;
}





@end
