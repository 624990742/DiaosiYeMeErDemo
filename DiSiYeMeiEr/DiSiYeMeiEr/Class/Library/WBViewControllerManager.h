//
//  WBViewControllerManager.h
//  UniversalJumpDemo
//
//  Created by macaaaaa on 2019/4/24.
//  Copyright © 2019年 TaoSheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString *const kPushVCName;
extern NSString *const kPushVCProperty;

@interface WBViewControllerManager : NSObject

/**
 单例化
 
 @return 实例对象
 */
+ (instancetype)sharedManager;


/**
 根据指定的对象获取一个VC的对象
 
 @param param 属性字典 内容必须为@{kPushVCName:@"", kPushVCProperty:@{@"":@""}}
 
 @return 指定VC的对象
 */
- (UIViewController *)getSpecificViewControllerFromInfo:(NSDictionary *)param;

@end

