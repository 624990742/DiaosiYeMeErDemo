//
//  WBViewControllerManager.m
//  UniversalJumpDemo
//
//  Created by macaaaaa on 2019/4/24.
//  Copyright © 2019年 TaoSheng. All rights reserved.
//

#import "WBViewControllerManager.h"
#import <objc/runtime.h>

NSString *const kPushVCName = @"UniversalVcName";
NSString *const kPushVCProperty = @"UniversalProperty";

@implementation WBViewControllerManager

+ (instancetype)sharedManager {
    
    static WBViewControllerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[WBViewControllerManager alloc] init];
        
    });
    
    return manager;
}

- (UIViewController *)getSpecificViewControllerFromInfo:(NSDictionary *)param {
    
    NSAssert([param objectForKey:kPushVCName], @"It's  going to Push ViewControllerIdentifier couldn't be Null");
    
    NSString *vcName = [param objectForKey:kPushVCName];
    NSAssert(vcName.length > 0, @"UIViewControllerIdentifier could't be null");
    
    NSAssert([param objectForKey:kPushVCProperty], @"It's  going to Push ViewControllerProperty couldn't be Null");
    NSAssert([[param objectForKey:kPushVCProperty] isKindOfClass:[NSDictionary class]], @"It's  going to Push ViewControllerProperty Must be NSDictionry");
    
    UIViewController *destinationVC = [NSClassFromString(vcName) new];
    NSDictionary *properties = [param objectForKey:kPushVCProperty];
    
    [properties enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id key, id obj, BOOL *stop) {
        
        if ([self checkPropertyIsExistInDestinationVC:destinationVC andVerifyPropertyName:key]) {
            
            // 利用KVC赋值
            [destinationVC setValue:obj forKey:key];
        }
        
    }];
    
    return destinationVC;
}

#pragma mark - 检查对象是否存在该属性
- (BOOL)checkPropertyIsExistInDestinationVC:(UIViewController *)destinationVC andVerifyPropertyName:(NSString *)verifyPropertyName {
    
    unsigned int propertyCount;
    
    // 获取对象里的属性列表
    objc_property_t *properties = class_copyPropertyList([destinationVC class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i ++) {
        
        objc_property_t specificProperty = properties[i];
        
        // 属性名转化为字符串
        NSString *specificPropertyName = [[NSString alloc] initWithCString:property_getName(specificProperty) encoding:NSUTF8StringEncoding];
        
        // 判断该属性是否存在 TODO:这样判断有问题，比如vc的arr属性是数组，传参的arr是字典类型，依旧能赋值
        if ([specificPropertyName isEqualToString:verifyPropertyName]) {
            
            free(properties);
            
            return YES;
        }
    }
    
    free(properties);
    
    return NO;
}

@end
