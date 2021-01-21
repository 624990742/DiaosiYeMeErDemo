//
//  JWeakAndStrongViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2021/1/21.
//  Copyright © 2021 JCTrustYourself. All rights reserved.
//
/**
 学习与理解的博客地址
 https://www.jianshu.com/p/fe772a3536ca
 */
#import "JWeakAndStrongViewController.h"
#import "JCTestObject.h"
#import "NSObject+YYAddForARC.h"
void(^block)(void);
@interface JWeakAndStrongViewController ()

@end

@implementation JWeakAndStrongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testDemo4];
}

/**
 下边代码分析：
    Block 在创建的时候在栈上，而在赋值给全局变量的时候，被拷贝都了堆上。
 */
- (void)testDemo1{

    {
          JCTestObject *obj = [[JCTestObject alloc] init];
         NSLog(@"栈%@",[^(){NSLog(@"TestObj对象地址:%@",obj);} class]);
        
          NSLog(@"before block retainCount:%lu",(unsigned long)[obj arcDebugRetainCount]);
          block = ^(){
          NSLog(@"TestObj对象地址:%@",obj);
          };
          NSLog(@"after block retainCount:%zd",[obj arcDebugRetainCount]);
           NSLog(@"堆%@",[block class]);
      }
      block();
    
}

/**
  解决方案：
     由于Block对对象的强引用，导致如果整个Block一直不释放，那么所强引用
  的对象就无法释放，这样就会导致对象的dealloc无法执行，以前就遇到了这种
  对象不释放，但仍然发送通知的情况，找了好久，解决这个问题很简单，只需要
  将Block将要强引用的对象，弱引用就可以了，
 */


- (void)testDemo2{

    {
          JCTestObject *obj = [[JCTestObject alloc] init];
        __weak JCTestObject *weakObj = obj;
        
          NSLog(@"before block retainCount:%zd",[obj arcDebugRetainCount]);
          block = ^(){
          NSLog(@"TestObj对象地址:%@",weakObj);
          };
          NSLog(@"after block retainCount:%zd",[obj arcDebugRetainCount]);
         
      }
      block();
    
}


/**
 产生的问题：
    如果仅使用__weak所修饰的对象，如果被释放，那么这个对象在Block执行的过程中就会变成nil，
 这就可能会带来一些问题，比如:数组，字典的插入。
 
 解决方案：
    在Block执行的开始,检验弱引用的对象是否还存在,如果存在使用__strong进行强引用，这样，在
 Block执行的过程中，这个对象就不会被置为nil，而在Block执行完毕后，对象的引用计数就会-1，这样就不会导致对象无法释放。
 
 
 场景：
    一般情况下，只使用__weak就能满足大部分的需求了，只有在多线程处理的时候，需要
 在Bock使用下__strong修饰对象。
 
 分析：在耗时任务执行之前对象还是存在的，只是在执行完毕了之后，对象却被释放了。
 例子如下：
 */
- (void)testDemo3{

    
          JCTestObject *obj = [[JCTestObject alloc] init];
        __weak JCTestObject *weakObj = obj;
        
          NSLog(@"before block retainCount:%zd",[obj arcDebugRetainCount]);
          block = ^(){
          NSLog(@"TestObj对象地址:%@",weakObj);
        dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
        
            for (int i = 0; i < 10000; i++) {
                
            }
             NSLog(@"耗时的任务，结束JCTestObject对象地址：%@",weakObj);
          });
        };
          NSLog(@"after block retainCount:%zd",[obj arcDebugRetainCount]);
      block();
}


/**
 __strong修饰避免在耗时操作完成之后对象销毁的问题。
 */
- (void)testDemo4{

    
          JCTestObject *obj = [[JCTestObject alloc] init];
        __weak JCTestObject *weakObj = obj;
        
          NSLog(@"before block retainCount:%zd",[obj arcDebugRetainCount]);
          block = ^(){
         __strong JCTestObject *strongObj = weakObj;
          NSLog(@"TestObj对象地址:%@",weakObj);
        dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, NULL), ^{
        
            for (int i = 0; i < 10000; i++) {
                
            }
             NSLog(@"耗时的任务，结束JCTestObject对象地址：%@",strongObj);
          });
        };
          NSLog(@"after block retainCount:%zd",[obj arcDebugRetainCount]);
      block();
}

/**
 分析结论：
 
 
 
 
 */





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
