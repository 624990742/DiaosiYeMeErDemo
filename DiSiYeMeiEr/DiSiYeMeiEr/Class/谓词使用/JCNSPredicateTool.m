//
//  JCNSPredicateTool.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/8/27.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCNSPredicateTool.h"
#import "JCTestStudent.h"

@interface JCNSPredicateTool()
@property(nonatomic,strong)NSMutableArray *testDataArr;
@property(nonatomic,strong)NSMutableArray *testDataArr1;
@end
@implementation JCNSPredicateTool
+(void)test{
    NSArray *array = @[[JCTestStudent studentWithName:@"Tom" age:18],
                       [JCTestStudent studentWithName:@"Jack" age:19],
                       [JCTestStudent studentWithName:@"Zhuba" age:20],
                       [JCTestStudent studentWithName:@"Lisi" age:100],
                       [JCTestStudent studentWithName:@"Sunqi" age:0],
                       [JCTestStudent studentWithName:@"Rose" age:50]
                       ];
    NSMutableArray *arrayM = [array mutableCopy];
//    NSLog(@"%@", arrayM);
    NSInteger maxAge = 50;
    // ***** 这样写有语法错误！不能使用`%zd`！
    // NSPredicate *pred = [NSPredicate predicateWithFormat:@"self.age >= %zd", maxAge];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"self.age >= %ld", maxAge];
    [arrayM filterUsingPredicate:pred];
    NSLog(@"年龄大于50===>%@", arrayM);

    NSString *property = @"name";
    NSString *value = @"Jack";
    // %K 字段占位符
    // %@ 值占位符
    // 必须是 %K(K是大写字母)
    pred = [NSPredicate predicateWithFormat:@"%K contains %@", property, value];
    NSArray *tmpArray = [array filteredArrayUsingPredicate:pred];
    NSLog(@"字段占位符号测试==>:%@", tmpArray);

    // $VALUE：VALUE只是一个普通字符串，当做标识使用，可以任意替换，但要统一！
    NSPredicate *tp = [NSPredicate predicateWithFormat:@"%K > $VALUE", @"age"];
    pred = [tp predicateWithSubstitutionVariables:@{@"VALUE" : @1}];
    NSArray *arr1 = [array filteredArrayUsingPredicate:pred];
    NSLog(@"条件筛选==>%@", arr1);

    pred = [tp predicateWithSubstitutionVariables:@{@"VALUE" : @50}];
    NSArray *arr2 = [array filteredArrayUsingPredicate:pred];
    NSLog(@"替换字段值==>%@", arr2);

    NSArray * ages = [array valueForKeyPath:@"age"];
    NSLog(@"-- ages::::%@",ages);
    
    
}


- (void)test1{
    [JCNSPredicateTool test];
//    NSArray *array = @[[JCTestStudent studentWithName:@"A" age:1],
//                       [JCTestStudent studentWithName:@"B" age:2],
//                       [JCTestStudent studentWithName:@"C" age:3],
//                       [JCTestStudent studentWithName:@"D" age:4],
//                       [JCTestStudent studentWithName:@"E" age:5],
//                       [JCTestStudent studentWithName:@"F" age:6]
//                       ];
//    self.testDataArr = [NSMutableArray arrayWithArray:array];
////    [self.testDataArr addObjectsFromArray:array];
////    [self.testDataArr1 addObjectsFromArray:array];
//
//    NSString *preStr = [NSString stringWithFormat:@"age != %ld",(long)3];
//    NSPredicate *filterPre = [NSPredicate predicateWithFormat:preStr];
//    [self.testDataArr filterUsingPredicate:filterPre];
//
//    NSLog(@"testDataArr-->%@",self.testDataArr);
//    NSLog(@"==============");
//    NSArray *tt = [self.testDataArr mutableCopy];
//    NSLog(@"copy-->%@",tt);
//
//
//
//    NSMutableDictionary *info = [NSMutableDictionary dictionary];
//    [info setValue:NULL forKey:@"A"];
////    [info setObject:nil forKey:@"B"];
//    NSLog(@"--%@",info);
//
    
//
//    NSInteger rowIndex = 4;
//    for (NSInteger index = 0; index < self.testDataArr.count; index++) {
//        JCTestStudent *stu = self.testDataArr[index];
//        if (stu.age == rowIndex) {
//            [self.testDataArr removeObject:stu];
//        }
////        NSLog(@"for循环--name: %@ age: %ld --",stu.name,stu.age);
//    }
//    for (JCTestStudent *stu in self.testDataArr) {
//        NSLog(@"for循环--name: %@ age: %ld --",stu.name,stu.age);
//    }
////    NSLog(@"for循环结果：%@",self.testDataArr);
//    NSLog(@"=================");
//
//    [self.testDataArr1 enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        JCTestStudent *stu = (JCTestStudent *)obj;
//        if (stu.age == rowIndex) {
//            [self.testDataArr1 removeObject:stu];
//        }
////        NSLog(@"枚举-- name: %@, age: %ld --",stu.name,stu.age);
//    }];
////    NSLog(@"枚举循环结果：%@",self.testDataArr1);
//    for (JCTestStudent *stu in self.testDataArr1) {
//        NSLog(@"枚举-- name: %@, age: %ld --",stu.name,stu.age);
//    }
}


- (NSMutableArray *)testDataArr{
    if (!_testDataArr) {
        _testDataArr = [NSMutableArray array];
    }
    return _testDataArr;
}

- (NSMutableArray *)testDataArr1{
    if (!_testDataArr1) {
        _testDataArr1 = [NSMutableArray array];
    }
    return _testDataArr1;
}



@end
