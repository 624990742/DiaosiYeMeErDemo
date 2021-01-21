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
    self.navigationItem.title = @"测试一些面试题";
    self.view.backgroundColor = [UIColor whiteColor];

    [self testBlockDemo3];
}


#pragma mark -  Block相关的
/**
 下面的案例仅仅是使用，并不是赋值操作，所以不需要
 使用__block进行修饰。
 */
- (void)testBlockDemo{
    
    {
        NSMutableArray *array = [NSMutableArray array];
        void(^Block)(void) = ^{
            [array addObject:@123];
            NSLog(@"array==>%@",array);
        };
        Block();
    }
}

/**
报错:
 Variable is not assignable (missing __block type specifier)
 变量不可赋值（缺少块类型说明符）
 因为是赋值操作需要进行__block 修饰
 */
- (void)testBlockDemo1{
    
    {
      __block  NSMutableArray *array = nil;
        void(^Block)(void) = ^{
            array = [NSMutableArray array];
        };
        Block();
    }
}
- (void)testBlockDemo2{
    
    {
        __block  int multiplier = 6;
        int(^Block)(int) = ^int(int num){
            return num * multiplier;
        };
        multiplier = 4;
        NSLog(@"result is %d",Block(2));
    }
}

- (void)testBlockDemo3{
  
}


//+ (void)initialize{
//    [super initialize];
//    NSLog(@"initialize");
//}
//+(void)load{
//    [super load];
//    NSLog(@"load");
//}





#pragma mark - 多线程面试题

/**
 1、同步串行的问题。
 下面的方法会造成死锁
 死锁：队列引起的循环等待。
 首先提交了viewDidLoad任务，随后有提交了一个Block任务。
  因为当前的任务是分配在主线程同步进行的，两个任务都在主队列上，队列的特点是”先进先出，后进后出“，所以viewDidLoad方法结束依赖于block的任务完成，block又依赖于viewDidLoad的任务完成。他们两个会出现相互等待的情况
 
 */
- (void)gCDTestDemo{
//
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        [self doSomething];
//    });
    
//    dispatch_queue_t seriaQuel;
//
//    dispatch_sync(seriaQuel, ^{
//
//    });
    
    
}

- (void)doSomething{
    NSLog(@"doSomething");
}



#pragma mark - 算法

- (void)dea{
    NSMutableArray * arr = @[@16,@1,@2,@9,@7,@12,@5,@3,@8,@13,@10].mutableCopy;
      [self bubbleSortWithArray:arr];
}

#pragma mark - 冒泡算法
- (void)bubbleSortWithArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count - 1; i++) {
         //外层for循环控制循环次数
        for (int j = 0; j < array.count - 1 - i; j++) {
            //内层for循环控制交换次数
            if ([array[j] integerValue] > [array[j + 1] integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
            }
        }
    }
    NSLog(@"%@",array);
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
