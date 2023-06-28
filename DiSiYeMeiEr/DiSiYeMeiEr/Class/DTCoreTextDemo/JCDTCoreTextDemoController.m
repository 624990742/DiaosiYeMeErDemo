//
//  JCDTCoreTextDemoController.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2023/2/2.
//  Copyright © 2023 JCTrustYourself. All rights reserved.
//

#import "JCDTCoreTextDemoController.h"
#import <DTCoreText/DTCoreText.h>
#import <DTAnimatedGIF.h>
@interface JCDTCoreTextDemoController ()<DTLazyImageViewDelegate>
@property(strong,nonatomic) UIScrollView *bgScrollView;
@property(strong,nonatomic) DTAttributedLabel *attrLabel;
@property(strong,nonatomic) DTCoreTextLayouter *layoutCoreText;

@end

@implementation JCDTCoreTextDemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self.view);
       }];
//       [self.attrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//           make.edges.equalTo(scrollView);
//           make.width.equalTo(scrollView.mas_width);
//       }];
//
//    
    
    NSMutableAttributedString *attr = [self getTestAttr];
    CGSize testH = [self getAttributedTextHeightWithAttr:attr];
    self.attrLabel.attributedString = attr;
}



- (CGSize)getImageSize:(CGSize)size
{
    CGFloat heightPx = 0;
    CGFloat widthPx = 0;
    CGFloat imgSizeScale = size.height/size.width;
    CGFloat maxWidth = self.view.bounds.size.width;
    if (size.width > maxWidth) {
        widthPx = maxWidth;
        heightPx = maxWidth * imgSizeScale;
    }else{
        widthPx = size.width;
        heightPx = size.height;
    }
    return CGSizeMake(widthPx, heightPx);
}

#pragma mark - DTAttributedTextContentViewDelegate

- (UIView *)attributedTextContentView:(DTAttributedTextContentView *)attributedTextContentView viewForAttachment:(DTTextAttachment *)attachment frame:(CGRect)frame{
    
    if([attachment isKindOfClass:[DTImageTextAttachment class]]){
        NSString *imageURL = [NSString stringWithFormat:@"%@", attachment.contentURL];
        frame.size  = [self getImageSize:frame.size];///计算图片大小
        DTLazyImageView *imageView = [[DTLazyImageView alloc] initWithFrame:frame];
        imageView.delegate = self;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = [(DTImageTextAttachment *)attachment image];
        imageView.url = attachment.contentURL;
        
        if ([imageURL containsString:@"gif"]) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData *gifData = [NSData dataWithContentsOfURL:attachment.contentURL];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imageView.image = DTAnimatedGIFFromData(gifData);
                });
            });
        }
        return imageView;
    }
    return nil;
}

#pragma mark - DTLazyImageViewDelegate
//懒加载获取图片大小
- (void)lazyImageView:(DTLazyImageView *)lazyImageView didChangeImageSize:(CGSize)size {
    NSURL *url = lazyImageView.url;
    CGSize imageSize = [self getImageSize:size];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"contentURL == %@", url];
    BOOL didUpdate = NO;
    for (DTTextAttachment *oneAttachment in [self.attrLabel.layoutFrame textAttachmentsWithPredicate:pred]){
        if (CGSizeEqualToSize(oneAttachment.originalSize, CGSizeZero)){
            oneAttachment.originalSize = imageSize;
        }
    }
}














- (CGSize)getAttributedTextHeightWithAttr:(NSAttributedString *)attr{
    //获取布局器
    NSRange entireString = NSMakeRange(0, [attr length]);
    self.layoutCoreText.attributedString = attr;
    DTCoreTextLayoutFrame *layoutFrame = [self.layoutCoreText layoutFrameWithRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGFLOAT_HEIGHT_UNKNOWN) range:entireString];
    CGSize sizeNeeded = [layoutFrame frame].size;
    return sizeNeeded;
}



- (UIScrollView *)bgScrollView{
    if(!_bgScrollView){
        _bgScrollView = [[UIScrollView alloc] init];
    }
    return _bgScrollView;
}
- (DTAttributedLabel *)attrLabel{
    if(!_attrLabel){
        _attrLabel = [[DTAttributedLabel alloc] initWithFrame:self.bgScrollView.bounds];
        _attrLabel.backgroundColor = [UIColor redColor];
        [self.bgScrollView addSubview:_attrLabel];
    }
    return _attrLabel;
}

- (DTCoreTextLayouter *)layoutCoreText
{
    if (!_layoutCoreText) {
        _layoutCoreText = [[DTCoreTextLayouter alloc] init];
    }
    return _layoutCoreText;
}








///获取
- (NSMutableAttributedString *)getTestAttr{
    NSString *htmlStr = nil;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TestHtmlJson" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    htmlStr = content;
    CGFloat maxW = [[UIScreen mainScreen] bounds].size.width;
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *options = @{DTDefaultTextColor: [UIColor blackColor], DTUseiOS6Attributes: @(YES),DTMaxImageSize:[NSValue valueWithCGSize:CGSizeMake(maxW, CGFLOAT_HEIGHT_UNKNOWN)],DTDefaultFontSize:@(16),DTDefaultLineHeightMultiplier:@(1.8),DTAttachmentParagraphSpacingAttribute:@(0)};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithHTMLData:data options:options documentAttributes:NULL];
    return attributedString;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
