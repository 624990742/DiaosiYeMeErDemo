 //
//  JCMoreViewOrButton.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/23.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//
/**
  *  学习博客链接地址：http://www.cocoachina.com/articles/22551
   *
    ******/
#import "JCMoreViewOrButton.h"

@implementation JCMoreViewOrButton

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self setupUI];
    }
    return self;
}


//切换不同的方法就可以看到不同的效果
- (void)setupUI{
//    [self maseryHorizontalLayout1];
//    [self maseryHorizontalLayout2];
//    [self maseryverticalLayout1];
    [self maseryverticalLayout2];
}


//1、水平方向排列、固定控件间隔、控件长度不定
- (void)maseryHorizontalLayout1{
    
    NSMutableArray *testViewArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 5; index ++) {
        
        UIView *testView  = [[UIView alloc] init];
        testView.backgroundColor = [UIColor RandomColor];//随机颜色
        [self addSubview:testView];
        [testViewArr addObject:testView];
        
            
        if (testViewArr.count == 5) {//必须在最后统一布局
           //FixedSpacing 水平左右间隔
           //leadSpacing  第一个item距离手机屏幕的距离
           //tailSpacing  最后一个item元素距离手机屏幕的距离
            [testViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
            
            // 设置array的垂直方向的约束
            [testViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(100);
                make.height.equalTo(100);
            }];
        }
    }
  
}


//2、水平方向排列、固定控件长度、控件间隔不定

- (void)maseryHorizontalLayout2{
    
    NSMutableArray *testViewArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 5; index ++) {
        
        UIView *testView  = [[UIView alloc] init];
        testView.backgroundColor = [UIColor RandomColor];//随机颜色
        [self addSubview:testView];
        [testViewArr addObject:testView];
        
        
        if (testViewArr.count == 5) {//必须在最后统一布局
            //ItemLength  item元素的宽度
            //leadSpacing  第一个item距离手机屏幕的距离
            //tailSpacing  最后一个item元素距离手机屏幕的距离
        
            [testViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:50 leadSpacing:10 tailSpacing:10];
            
            // 设置array的垂直方向的约束
            [testViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.equalTo(220);
                make.height.equalTo(100);
            }];
        }
    }
    
}


//3、垂直方向排列、固定控件间隔、控件高度不定
-(void)maseryverticalLayout1{
    
    NSMutableArray *testViewArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 5; index ++) {
        
        UIView *testView  = [[UIView alloc] init];
        testView.backgroundColor = [UIColor RandomColor];//随机颜色
        [self addSubview:testView];
        [testViewArr addObject:testView];
        
        
        if (testViewArr.count == 5) {//必须在最后统一布局
            //ItemLength  item元素的宽度
            //leadSpacing  第一个item距离手机屏幕的距离
            //tailSpacing  最后一个item元素距离手机屏幕的距离
            [testViewArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:100 leadSpacing:10 tailSpacing:10];
            
            // 设置array的垂直方向的约束
            [testViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(30);
                make.width.equalTo(80);
            }];
        }
    }
}



//3、垂直方向排列、固定控件高度、控件间隔不定
-(void)maseryverticalLayout2{
    
    NSMutableArray *testViewArr = [NSMutableArray array];
    
    for (NSInteger index = 0; index < 5; index ++) {
        
        UIView *testView  = [[UIView alloc] init];
        testView.backgroundColor = [UIColor RandomColor];//随机颜色
        [self addSubview:testView];
        [testViewArr addObject:testView];
        
        
        if (testViewArr.count == 5) {//必须在最后统一布局
            //ItemLength  item元素的宽度
            //leadSpacing  第一个item距离手机屏幕的距离
            //tailSpacing  最后一个item元素距离手机屏幕的距离
    
            [testViewArr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:80 leadSpacing:10 tailSpacing:10];
            
            // 设置array的垂直方向的约束
            [testViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(100);
                make.width.equalTo(80);
            }];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
