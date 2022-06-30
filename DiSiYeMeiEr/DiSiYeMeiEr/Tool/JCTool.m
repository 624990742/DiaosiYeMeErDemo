//
//  JCTool.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/6/15.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCTool.h"

@implementation JCTool

+(void)createTestData{
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString * documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *oldPicPath =  [documentDir stringByAppendingPathComponent:@"AImageIcon"];
        NSString *newPicPath = [documentDir stringByAppendingPathComponent:@"BImageIcon"];
  
    
    BOOL isDirectory = ([[NSFileManager defaultManager] fileExistsAtPath:oldPicPath isDirectory:&isDirectory] && isDirectory);
    if (!isDirectory) {
        NSLog(@"oldPicPath--->create directory");
        [fm createDirectoryAtPath:oldPicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL isDirectory2 = ([[NSFileManager defaultManager] fileExistsAtPath:newPicPath isDirectory:&isDirectory] && isDirectory);
    if (!isDirectory2) {
        NSLog(@"newPicPath-->create directory");
        [fm createDirectoryAtPath:newPicPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test1" fileName:@"test1.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test2" fileName:@"test2.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test3" fileName:@"test3.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test4" fileName:@"test4.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test5" fileName:@"test5.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test6" fileName:@"test6.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test7" fileName:@"test7.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test8" fileName:@"test8.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test9" fileName:@"test9.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test10" fileName:@"test10.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test11" fileName:@"test11.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test12" fileName:@"test12.txt"];
    [self writeDataToFolderPath:oldPicPath wirteContent:@"test13" fileName:@"test13.txt"];
    
//    [JCTool mergeContentsOfPath:oldPicPath intoPath:newPicPath error:nil];
//    [JCTool copyFileFromPath:oldPicPath toPath:newPicPath complete:^(BOOL isSucess) {
//        if (isSucess) {
//            NSLog(@"成功过");
//        }
//    }];
}



+(void)writeDataToFolderPath:(NSString *)folderPath
                wirteContent:(NSString *)wirteContent
                    fileName:(NSString *)fileName
{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *testPath = [folderPath stringByAppendingPathComponent:fileName];
    BOOL res=[fm createFileAtPath:testPath contents:nil attributes:nil];
    if (res) {
        NSLog(@"文件创建成功: %@" ,testPath);
    }else{
        NSLog(@"文件创建失败");
    }
      BOOL res1 = [wirteContent writeToFile:testPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
      if (res1) {
          NSLog(@"文件写入成功：%@",testPath);
      }else{
          NSLog(@"文件写入失败");
      }
    
}



+ (void)mergeContentsOfPath:(NSString *)srcDir
                   intoPath:(NSString *)targetDir
                      error:(NSError**)err {

    NSLog(@"- mergeContentsOfPath: %@\n intoPath: %@", srcDir, targetDir);

    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *srcDirEnum = [fm enumeratorAtPath:srcDir];
    NSString *subPath;
    while ((subPath = [srcDirEnum nextObject])) {
        NSLog(@" subPath: %@", subPath);
        NSString *srcFullPath =  [srcDir stringByAppendingPathComponent:subPath];
        NSString *potentialDstPath = [targetDir stringByAppendingPathComponent:subPath];
        BOOL isDirectory = ([fm fileExistsAtPath:srcFullPath isDirectory:&isDirectory] && isDirectory);
        if (isDirectory) {
            NSLog(@"--create directory--");
            [fm createDirectoryAtPath:potentialDstPath withIntermediateDirectories:YES attributes:nil error:err];
            if (err && *err) {
                NSLog(@"ERROR: %@", *err);
                return;
            }
        } else {
            if ([fm fileExistsAtPath:potentialDstPath]) {
                NSLog(@"--removeItemAtPath--");
                [fm removeItemAtPath:potentialDstPath error:err];
                if (err && *err) {
                    NSLog(@"ERROR: %@", *err);
                    return;
                }
            }
            NSLog(@"--moveItemAtPath--");
            [fm moveItemAtPath:srcFullPath toPath:potentialDstPath error:err];
            if (err && *err) {
                NSLog(@"ERROR: %@", *err);
                return;
            }
        }
    }
}

// 复制并合并文件夹
+ (void)copyFileFromPath:(NSString *)sourcePath
                 toPath:(NSString *)toPath
               complete:(resultBackBlock)complete{

    // 1、得到文件路径
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSArray* arraySor = [fileManager contentsOfDirectoryAtPath:sourcePath error:nil];
    if (arraySor.count == 0 ) { complete(YES); return; }

    // 2、遍历并复制文件到新文件夹
    for(int i = 0; i<[arraySor count]; i++){
        NSString *fullPath = [sourcePath stringByAppendingPathComponent:[arraySor objectAtIndex:i]];
        NSString *fullToPath = [toPath stringByAppendingPathComponent:[arraySor objectAtIndex:i]];
        //判断是不是文件夹
        BOOL isFolder = NO;
        //判断是不是存在路径 并且是不是文件夹
        BOOL isExist = [fileManager fileExistsAtPath:fullPath isDirectory:&isFolder];
        if (isExist){
            NSError *err = nil;
            [[NSFileManager defaultManager] copyItemAtPath:fullPath toPath:fullToPath error:&err];
            if (err!=nil) {  NSLog(@"===%@===%@===错误日志", err, [err userInfo]);}
            if (isFolder){ [self copyFileFromPath:fullPath toPath:fullToPath complete:^(BOOL isSucess) { }]; }
        }
    }
    // 3、判断一个数组是否包含另一个数组的所有元素,谓词。
    NSArray* arrayTo = [fileManager contentsOfDirectoryAtPath:toPath error:nil];
    NSArray * filterList = [arraySor filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",arrayTo]];
    if (filterList.count == 0) { complete(YES); return; }else{  complete(NO); return; }
  
}


///去除字符串中的数字
///https://blog.csdn.net/msyqmsyq/article/details/50788003
+(void)test111{
    /**
     
     //这是我们的测试用的文本字符串数据

     NSString *content = @"abc123a1b2c3你懂得888";

         NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];

         NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:content];

         for (int i = 0; i < content.length; i ++) {

     //这里的小技巧，每次只截取一个字符的范围

             NSString *a = [content substringWithRange:NSMakeRange(i, 1)];

     //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange

             if ([number containsObject:a]) {

                 [attributeString setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor],NSFontAttributeName:[UIFont systemFontOfSize:25],NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(i, 1)];

             }

             

         }
     ————————————————
     版权声明：本文为CSDN博主「陶大海888」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
     原文链接：https://blog.csdn.net/msyqmsyq/article/details/50788003
     
     */
    
    
    NSString *content = @"abc123a1b2c3你懂得888";
    NSArray *number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSMutableString *tempStr = [NSMutableString string];
        for (int i = 0; i < content.length; i ++) {
    //这里的小技巧，每次只截取一个字符的范围
    NSString *a = [content substringWithRange:NSMakeRange(i, 1)];
    //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:a]) {
            [tempStr appendString:a];
            }
        }
    NSLog(@"结果-->%@",tempStr);
}

///去除字符串中的数字
+(void)test222{
    NSString *content = @"abc123a1b2c3你懂得888";
    NSScanner *scanner = [NSScanner scannerWithString:content];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    NSInteger number;
    [scanner scanInteger:&number];
    NSString *num=[NSString stringWithFormat:@"%ld",number];
    NSLog(@"结果-->%@",num);
}


///去除字符串中的数字
+(void)test333{
    NSString *content = @"abc123a1b2c3你懂得888";
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
     NSInteger remainSecond =[[content stringByTrimmingCharactersInSet:nonDigits] intValue];
    NSLog(@" num %ld ",(long)remainSecond);
}


@end
