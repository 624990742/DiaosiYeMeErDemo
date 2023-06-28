//
//  JCCustomView.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2023/4/24.
//  Copyright © 2023 JCTrustYourself. All rights reserved.
//

#import "JCCustomView.h"
#import <CoreText/CoreText.h>

@interface JCCustomView ()
@property(copy,nonatomic)NSString *htmlString;
@property(strong,nonatomic)NSAttributedString *attributedString;

@end

@implementation JCCustomView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setHtmlString:(NSString *)htmlString {
    _htmlString = htmlString;
    
    // 1. Convert HTML string to attributed string
    NSData *htmlData = [_htmlString dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:htmlData options:options documentAttributes:nil error:nil];
    self.attributedString = attributedString;
    

}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if(_attributedString == nil){
        return;
    }
    
       CGContextRef context = UIGraphicsGetCurrentContext();
//       CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//       CGContextTranslateCTM(context, 0, self.bounds.size.height);
//       CGContextScaleCTM(context, 1.0, -1.0);
    // 使用CoreText绘制NSAttributedString
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attributedString);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0,self.bounds.size.width, CGFLOAT_MAX));

    // 创建CTFrame
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [_attributedString length]), path, NULL);
    CFArrayRef lines = CTFrameGetLines(frame);

    // 遍历CTLine
    for (CFIndex i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);

        // 获取CTLine的范围
        CFRange lineRange = CTLineGetStringRange(line);

        // 获取CTLine的CGRect
        CGRect lineRect = CTLineGetBoundsWithOptions(line, kCTLineBoundsExcludeTypographicShifts);

        // 计算CTLine的位置
        CGPoint lineOrigin;
        CTFrameGetLineOrigins(frame, CFRangeMake(i, 1), &lineOrigin);

        // 绘制CTLine
        CTLineDraw(line, context);

        // 处理图片
        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(line);
        for (int j = 0; j < runs.count; j++) {
            CTRunRef run = (__bridge CTRunRef)runs[j];

            // 获取CTRun的属性
            NSDictionary *attributes = (__bridge NSDictionary *)CTRunGetAttributes(run);

            // 判断是否是图片
            if ([attributes objectForKey:@"NSAttachment"]) {
                // 获取图片
                NSTextAttachment *attachment = [attributes objectForKey:@"NSAttachment"];
                UIImage *image = attachment.image;

                // 获取图片的位置
                CGRect imageRect;
                CGFloat ascent;
                CGFloat descent;
                CGFloat leading;
                CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading);
                imageRect.size.width = lineRect.size.height * image.size.width / image.size.height;
                imageRect.size.height = lineRect.size.height;
                imageRect.origin.x = lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                imageRect.origin.y = lineOrigin.y - descent;

                // 绘制图片
                CGContextDrawImage(context, imageRect, image.CGImage);
            }
        }
    }

    // 获取CTFrame的高度
    CGPathRelease(path);
    CFRelease(framesetter);
    CFRelease(frame);
//    CGFloat height = ceil(CGRectGetMaxY(lineRect));

}






- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    CGPoint location = [touches.anyObject locationInView:self];
//
//    // 9. Get the tapped glyph index
//    CFArrayRef lines = CTFrameGetLines((__bridge CTFrameRef)self.attributedString);
//    CGPoint origins[CFArrayGetCount(lines)];
//    CTFrameGetLineOrigins((__bridge CTFrameRef)self.attributedString, CFRangeMake(0, 0), origins);
//
//    CTLineRef line = NULL;
//    CGPoint lineOrigin = CGPointZero;
//    for (CFIndex i = 0; i < CFArrayGetCount(lines); i++) {
//        CGPoint origin = origins[i];
//        CTLineRef currentLine = CFArrayGetValueAtIndex(lines, i);
//        CGRect lineRect = CTLineGetImageBounds(currentLine, UIGraphicsGetCurrentContext());
//        lineRect.origin.x += origin.x;
//        lineRect.origin.y += origin.y;
//        lineRect.origin.y = self.bounds.size.height - lineRect.origin.y - lineRect.size.height;
//
//        if (CGRectContainsPoint(lineRect, location)) {
//            line = currentLine;
//            lineOrigin = origin;
//            break;
//        }
//    }
//
//    if (!line) return;
//    CGPoint _diffPoint = CGPointMake(location.x - lineOrigin.x, location.y - lineOrigin.y);
//    CFIndex glyphIndex = CTLineGetStringIndexForPosition(line, _diffPoint);
//
//    // 10. Handle the tapped glyph index
//    NSLog(@"Tapped glyph index: %ld", glyphIndex);
}

- (CGSize)sizeThatFits:(CGSize)size {
    if (!self.attributedString) return CGSizeZero;
    
    // 11. Compute the size of the attributed string that fits the given size
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedString);
    if (!framesetter) return CGSizeZero;
    
    CGSize constraints = CGSizeMake(size.width, CGFLOAT_MAX);
    CGSize sizeThatFits = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), NULL, constraints, NULL);
    
    CFRelease(framesetter);
    
    return sizeThatFits;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
