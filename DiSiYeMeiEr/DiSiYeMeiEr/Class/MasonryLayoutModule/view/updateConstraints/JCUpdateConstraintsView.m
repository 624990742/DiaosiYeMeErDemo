//
//  JCUpdateConstraints.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCUpdateConstraintsView.h"


@interface JCUpdateConstraintsView ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;

@end


@implementation JCUpdateConstraintsView


- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}



- (void)setupUI{
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"来点击我啊!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;

    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.growingButton];
    
    self.buttonSize = CGSizeMake(200, 200);

}



/*
 基于约束的布局是懒触发的，只有在添加了约束的情况下，系统才会自动调用updateConstraints方法。
 如果把所有的约束放在updateConstraints中，那么系统将会不知道你的布局方式是基于约束的，
 所以重写requiresConstraintBasedLayout返回YES就是明确告诉系统：虽然我之前没有添加约束,但我确实是基于约束的布局！这样可以保证系统一定会调用 updateConstraints 方法 从而正确添加约束.
 */
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}



/*
 .equalTo等效于NSLayoutRelationEqual
 
 .lessThanOrEqualTo等效于NSLayoutRelationLessThanOrEqual
 
 .greaterThanOrEqualTo等效于NSLayoutRelationGreaterThanOrEqual
 
 

 
 */
//重写更新约束的方法
- (void)updateConstraints{
    
    [self.growingButton  updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
//        make.width.equalTo(@(self.buttonSize.width)).priorityLow();//约束的优先级最低
//        make.height.equalTo(@(self.buttonSize.height)).priorityLow();
        make.width.lessThanOrEqualTo(self);//小于或者等于
        make.height.lessThanOrEqualTo(self);
        
    }];
    
    
    
    [super updateConstraints];
}


/*
 
 标记为需要更新约束，异步调用updateViewConstraints刷新布局。
 不立即刷新，但updateViewConstraints一定会被调用。
 - (void)setNeedsUpdateConstraints NS_AVAILABLE_IOS(6_0);
 
 
 如果有需要刷新的约束，立即调用updateViewConstraints进行布局
 （如果没有标记，不一定会调用layoutSubviews）
 - (void)updateConstraintsIfNeeded NS_AVAILABLE_IOS(6_0);
 
 
 
 如果有需要刷新的标记，立即调用layoutSubviews进行布局
 （如果没有标记，不会调用layoutSubviews）
 - (void)layoutIfNeeded;
 
 
 
 标记为需要重新布局，异步调用layoutIfNeeded刷新布局。
 不立即刷新，但layoutSubviews一定会被调用
 - (void)setNeedsLayout;
 
 */

- (void)didTapGrowButton:(UIButton *)button {
    self.buttonSize = CGSizeMake(self.buttonSize.width * 1.3, self.buttonSize.height * 1.3);
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];//告知界面需要刷新（不是立即刷新）
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
