//
//  JCProgressView.h
//  testDemo
//
//  Created by jcmac on 2022/4/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCProgressView : UIView
@property(nonatomic,assign)CGFloat progress;
- (instancetype)initWithFrame:(CGRect)frame
                         type:(NSInteger)type;
- (void)start;
- (void)pause;
- (void)stop;
@end

NS_ASSUME_NONNULL_END
