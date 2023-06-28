//
//  JCCustomMenuView.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2023/4/13.
//  Copyright © 2023 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCCustomMenuView : UIView
@property (nonatomic, assign) CGFloat buttonGap;
@property (nonatomic, strong) NSArray<NSString *> *titles;
- (void)scrollToButtonAtIndex:(NSUInteger)index;
- (instancetype)initWithTitles:(NSArray<NSString *> *)titles;
@end
NS_ASSUME_NONNULL_END
