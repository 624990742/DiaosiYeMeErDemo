//
//  JCAlgorithmViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/12/10.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCAlgorithmViewController.h"

@interface JCAlgorithmViewController ()
@end

@implementation JCAlgorithmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"算法列表";
    self.view.backgroundColor = [UIColor whiteColor];
    [self selectSortMethodTest];
}
#pragma mark - 选择排序
/**
选择排序（Selection sort）是一种简单直观的排序算法。

工作原理是：第一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，然后再从剩余的未排序元素中寻找到最小（大）元素，然后放到已排序的序列的末尾。以此类推，直到全部待排序的数据元素的个数为零。选择排序是不稳定的排序方法。
*/

- (void)selectSortMethodTest{
    
    NSArray *oringeList = @[@(10),@(1),@(2),@(9),@(-1),@(7),@(19),@(5),@(-9),@(3),@(8),@(13),@(17)];
    NSMutableArray * afterList = [NSMutableArray arrayWithArray:[self selectSortMethod:oringeList]];
    
    [self showBubbleSortResult:afterList];
  
    
}

//算法封装方法
- (NSArray *)selectSortMethod:(NSArray *)dataArr{
    if (dataArr.count <= 1) {
        return dataArr;
    }
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:dataArr];
    NSInteger minIndex;
    for (NSInteger i = 0 ; i < tempArr.count - 1; i++) {
        minIndex = i;
        for (NSInteger j = i+1; j < tempArr.count; j++) {
            if ([tempArr[j] integerValue] < [tempArr[minIndex] integerValue]) {
                minIndex = j;
            }
        }
      if (i != minIndex) {
      [tempArr exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
   }
  return tempArr;
}

#pragma mark - 冒泡排序
- (void)bubbleSortMethod{
    
    int iCount  = 0;//记录外层循环的次数
    int jCount  = 0;//记录内存循环交换的次数
     NSMutableArray *array = [NSMutableArray arrayWithArray:@[@10,@1,@2,@9,@7,@19,@5,@3,@8,@13,@17]];
    NSInteger arrCount = array.count - 1;
    for (int i = 0; i < arrCount; i++) {//外层for循环控制循环次数
           iCount++;
        for (int j = 0; j < arrCount - i; j++) { //内层for循环控制交换次数
            jCount++;
            if ([array[j] intValue] > [array[j + 1] intValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
            [self showBubbleSortResult:array];
        }
    }
    NSLog(@"循环次数：%d",iCount);
    NSLog(@"共%d次比较",jCount);
}

//打印数组
- (void)showBubbleSortResult:(NSMutableArray * )array {
    NSString * str = @"";
    for (NSNumber * value in array) {
       str = [str stringByAppendingString:[NSString stringWithFormat:@"%zd ",[value integerValue]]];
    }
    NSLog(@"%@",str);
    NSLog(@"<=============>");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
