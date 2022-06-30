//
//  JCTool.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/6/15.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^resultBackBlock)(BOOL isSucess);
@interface JCTool : NSObject
+(void)createTestData;
/** 移动并合并文件夹 */
+ (void)mergeContentsOfPath:(NSString *)srcDir
                   intoPath:(NSString *)dstDir
                      error:(NSError**)err;

// 复制并合并文件夹
+ (void)copyFileFromPath:(NSString *)sourcePath
                 toPath:(NSString *)toPath
                complete:(resultBackBlock)complete;

///去除字符串中的数字
+(void)test111;
+(void)test222;
+(void)test333;
@end

NS_ASSUME_NONNULL_END
