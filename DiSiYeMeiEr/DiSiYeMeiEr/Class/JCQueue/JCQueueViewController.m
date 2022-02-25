//
//  JCQueueViewController.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/2/25.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCQueueViewController.h"

@interface JCQueueViewController ()

@end

@implementation JCQueueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}

/**  */
- (void)test1{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 优先级
       queue.qualityOfService = NSQualityOfServiceDefault;
       // 最大并发数（-1表示不进行限制，默认为并发执行；1表示串行执行；大于1时，进行并发执行）
       queue.maxConcurrentOperationCount = 3;
    
    NSBlockOperation *bo1 = [NSBlockOperation blockOperationWithBlock:^{
           [NSThread sleepForTimeInterval:0.5];
           NSLog(@"请求token--%@",[NSThread currentThread]);
       }];
       
       NSBlockOperation *bo2 = [NSBlockOperation blockOperationWithBlock:^{
           [NSThread sleepForTimeInterval:0.5];
           NSLog(@"拿着token,请求数据1--%@",[NSThread currentThread]);
       }];

    NSBlockOperation *bo3 = [NSBlockOperation blockOperationWithBlock:^{
         [NSThread sleepForTimeInterval:0.5];
         NSLog(@"拿着数据1,请求数据2--%@",[NSThread currentThread]);
     }];
    [bo2 addDependency:bo1];
    [bo3 addDependency:bo2];
    [queue addOperations:@[bo1,bo2,bo3] waitUntilFinished:YES];
    NSLog(@"结束了去干其他的事情");
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
