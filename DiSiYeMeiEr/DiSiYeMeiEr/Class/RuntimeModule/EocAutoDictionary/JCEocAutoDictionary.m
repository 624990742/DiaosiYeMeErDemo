//
//  JCEocAutoDictionary.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/6.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCEocAutoDictionary.h"
#import <objc/runtime.h>

@interface JCEocAutoDictionary ()
@property(nonatomic,strong)NSMutableDictionary *backingStore;

@end

@implementation JCEocAutoDictionary
//属性声明为@dynamic，编译器就不会为其自动生成实例变量及存取方法了
@dynamic string,number,date,opaqueObject;

- (instancetype)init{
    if (self = [super init]) {
        _backingStore = [NSMutableDictionary new];
    }
    return self;
}


//关键在于“resolveInstanceMethod：”方法的实现
+(BOOL)resolveInstanceMethod:(SEL)sel{
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDuctionarySetter, "v@:@");
    }else{
        class_addMethod(self, sel, (IMP)autoDuctionaryGetter, "v@:@");
    }
    return YES;
    
}

id autoDuctionaryGetter(id self, SEL _cmd){
//    get the backing store from the object(从对象获取备份存储)
    JCEocAutoDictionary *typedSelf = (JCEocAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
//The key is simply the selector name(key 为选择子的名称)
    NSString *key = NSStringFromSelector(_cmd);
  //返回值
    return [backingStore objectForKey:key];
}



void autoDuctionarySetter(id self,SEL _cmd ,id value){
    
    JCEocAutoDictionary *typedSelf = (JCEocAutoDictionary *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    /** 选择器将是例如“setOpaqueObject:”。
      * 我们需要删除“set”、“：”和第一个小写字母
      * 余数的字母。
      */
    NSString *selectortring = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectortring mutableCopy];
    //删除结尾的:
    [key deleteCharactersInRange:NSMakeRange(key.length - 1,1)];
    //移除 set  前缀
    //将第一个字符小写
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];

    if (value) {
        [backingStore setObject:value forKey:key];
    }else{
        [backingStore removeObjectForKey:key];
    }
    
    
}


@end
