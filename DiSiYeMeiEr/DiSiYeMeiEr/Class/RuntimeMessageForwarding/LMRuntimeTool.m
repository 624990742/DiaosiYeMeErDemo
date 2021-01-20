//
//  LMRuntimeTool.m
//  MessageForwardDemo
//
//  Created by Leesim on 2018/8/6.
//  Copyright © 2018年 LiMing. All rights reserved.
//

#import "LMRuntimeTool.h"
#import <objc/runtime.h>


@implementation LMRuntimeTool

+(Class)getMetaClassWithChildClass:(Class)childClass{
    //转换字符串类别
    const  char * classChar = [NSStringFromClass(childClass) UTF8String];
    //需要char的字符串 获取元类
    return objc_getMetaClass(classChar);
}

+(void)addMethodWithClass:(Class)class withMethodSel:(SEL)methodSel withImpMethodSel:(SEL)impMethodSel{
    //获取实现的方法内容
    Method funtionRealMethod = class_getInstanceMethod(class, impMethodSel);
    //实现方法的IMP
    IMP methodIMP = method_getImplementation(funtionRealMethod);
    //实现方法的类别 返回类型 携带参数 等
    const char * types = method_getTypeEncoding(funtionRealMethod);
    //对目标添加方法
    class_addMethod(class, methodSel, methodIMP, types);
}




+(void)load{
    //获取test方法
    Method test = class_getInstanceMethod(self, @selector(test));
    //获取otherTest方法
    Method otherTest = class_getInstanceMethod(self, @selector(otherTest));
    //交换两个方法
    method_exchangeImplementations(test, otherTest);
}

- (void)test{
    NSLog(@"test");
}

- (void)otherTest{
    //实际上调用的test的具体实现
    [self otherTest];
    NSLog(@"test");
}


@end
