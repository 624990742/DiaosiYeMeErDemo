//
//  JCBasicLayout.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCBasicLayoutView.h"

@implementation JCBasicLayoutView
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
 
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *superview = self;
    int padding = 10;
    
    /*
     如果在掉用的时候想要省略mas_ 前缀，在pch文件中进行如下配置
     
     
     #ifdef __OBJC__
     #import <UIKit/UIKit.h>
     #import <Foundation/Foundation.h>
     #import <QuartzCore/QuartzCore.h>
     
     //define this constant if you want to use Masonry without the 'mas_' prefix
     #define MAS_SHORTHAND
     
     //define this constant if you want to enable auto-boxing for default syntax
     #define MAS_SHORTHAND_GLOBALS
     
     #import "Masonry.h"
     #endif
     
     
     */
    [greenView   makeConstraints:^(MASConstraintMaker *make) {
        make.top.greaterThanOrEqualTo(superview.top).offset(padding);
        make.left.equalTo(superview.left).offset(padding);
        make.bottom.equalTo(blueView.top).offset(- padding);
        make.right.equalTo(redView.left).offset(- padding);
        make.width.equalTo(redView.width);
        
        make.height.equalTo(redView.height);
        make.height.equalTo(blueView.height);
    }];

    
    
    
    /*
       Semantic properties 语义属性，可有可无，有的话更优雅跟便于读。
     
     - (MASConstraint *)with {
     return self;
     }
     
     - (MASConstraint *)and {
     return self;
     }
     */
    [redView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(superview.mas_top).with.offset(padding);
        make.left.equalTo(greenView.mas_right).offset(padding);
        make.bottom.equalTo(blueView.mas_top).offset(-padding);
        
        make.right.equalTo(superview.mas_right).offset(-padding);
        /*
         redView的高度与greenView,blueView 相同
          等同于如下两行代码：
         make.height.equalTo(greenView);
         make.height.equalTo(blueView.height);
         */
        make.height.equalTo(@[greenView,blueView]);
    }];
    
    
    
    [blueView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(greenView.mas_bottom).offset(padding);
        make.left.equalTo(superview.mas_left).offset(padding);
        make.bottom.equalTo(superview.bottom).offset(-padding);
        make.right.equalTo(superview.right).offset(-padding);
        /*
         下边的代码等同于
         make.height.equalTo(@[greenView,blueView]);
         
         */
        make.height.equalTo(@[greenView.height,redView.height]);
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
