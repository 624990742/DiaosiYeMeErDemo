//
//  JCCustomMenuView.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2023/4/13.
//  Copyright © 2023 JCTrustYourself. All rights reserved.
//

#import "JCCustomMenuView.h"

@interface JCCustomMenuView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray<UIButton *> *buttons;
@end

@implementation JCCustomMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.buttonGap = 10.0;
    self.buttons = [NSMutableArray array];
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self addButtons];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    CGFloat x = self.buttonGap;
    for (UIButton *button in self.buttons) {
        [button sizeToFit];
        CGRect frame = button.frame;
        frame.origin.x = x;
        frame.origin.y = (self.bounds.size.height - frame.size.height) / 2;
        button.frame = frame;
        x += frame.size.width + self.buttonGap;
    }

    self.scrollView.contentSize = CGSizeMake(x, self.bounds.size.height);
}

- (void)addButtons {
    for (NSString *title in self.titles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:button];
        [self.scrollView addSubview:button];
    }
    [self setNeedsLayout];
}

- (void)scrollToButtonAtIndex:(NSUInteger)index {
    if (index >= self.buttons.count) {
        return;
    }
//    UIButton *button = self.buttons[index];
//    CGRect visibleRect = CGRectMake(button.frame.origin.x - self.buttonGap, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
//    [self.scrollView scrollRectToVisible:visibleRect animated:YES];
    
    
      UIButton *button = self.buttons[index];
       CGRect visibleRect = CGRectMake(button.frame.origin.x - self.buttonGap, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
       [self.scrollView scrollRectToVisible:visibleRect animated:YES];

       if (button != self.selectedButton) {
           self.selectedButton.selected = NO;
           button.selected = YES;
           self.selectedButton = button;
       }
    
}

- (void)buttonTapped:(UIButton *)button {
    NSUInteger index = [self.buttons indexOfObject:button];
    [self scrollToButtonAtIndex:index];
    // 遍历所有按钮，更新高亮状态
        for (UIButton *btn in self.buttons) {
            btn.selected = NO;
            btn.backgroundColor = [UIColor grayColor];
        }
        button.selected = YES;
      self.selectedButton = button;
      self.selectedButton.backgroundColor = [UIColor blueColor];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat offsetX = scrollView.contentOffset.x;
//    for (UIButton *button in self.buttons) {
//        CGRect frame = button.frame;
//        CGFloat distance = frame.origin.x - offsetX;
//        if (distance < 0) {
//            distance = -distance;
//        }
//        CGFloat scale = MAX(1 - distance / 1000.0, 0.8);
//        button.transform = CGAffineTransformMakeScale(scale, scale);
//    }
    
//    CGFloat maxDistance = self.bounds.size.width / 2.0 + self.buttonGap + self.selectedButton.bounds.size.width / 2.0;
//    for (UIButton *button in self.buttons) {
//        if (button == self.selectedButton) {
//            continue;
//        }
//        CGFloat distance = fabs(button.center.x - scrollView.contentOffset.x - self.bounds.size.width / 2.0);
//        CGFloat scale = 1.0 - distance / maxDistance;
//        scale = MAX(scale, 0.0);
//        button.transform = CGAffineTransformMakeScale(scale, scale);
//    }
    
}


@end
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
