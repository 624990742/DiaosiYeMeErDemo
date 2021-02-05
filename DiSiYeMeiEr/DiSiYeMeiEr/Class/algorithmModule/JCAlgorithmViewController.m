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
    [self bubbleSortMethod];
}
#pragma mark - 选择排序
- (void)selectSortMethod{
    
    NSArray *arr = @[@10,@6,@8,@9,@12,@11];
//    NSInteger objNum = arr.count;
//    int k;
//    for (int i = 0; i < objNum; i++) {
//        k = i;
//        for (int j = i + 1; j < objNum; j++) {
//            int tempK = [arr[k] intValue];
//            int tempJ = [arr[j] intValue];
//            if (tempK > tempJ) {
//                tempK = tempJ;
//            }
//        }
//        if (k != i) {
//            int temp = [arr[k] intValue];
//            arr[k] = arr[i];
//            arr[i] = temp;
//        }
//    }

    
}

#pragma mark - 冒泡排序
- (void)bubbleSortMethod{
    
    int iCount  = 0;
    int jCount  = 0;
     NSMutableArray *array = [NSMutableArray arrayWithArray:@[@10,@1,@2,@9,@7,@19,@5,@3,@8,@13,@17]];
    NSInteger arrCount = array.count - 1;
    for (int i = 0; i < arrCount; i++) {//外层for循环控制循环次数
           iCount++;
        for (int j = 0; j < arrCount - i; j++) { //内层for循环控制交换次数
            jCount++;
            if ([array[j] intValue] > [array[j + 1] intValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
            [self logArr:array];
        }
    }
    
    NSLog(@"循环次数：%d",jCount);
    NSLog(@"共%d次比较",iCount);
   
}

//打印数组
- (void)logArr:(NSMutableArray * )array {
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
