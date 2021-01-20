//
//  JCRuntimeMessageForwardingVC.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2020/12/8.
//  Copyright © 2020 JCTrustYourself. All rights reserved.
//

#import "JCRuntimeMessageForwardingVC.h"
#import "TestMessage.h"
#import <objc/runtime.h>
@interface JCRuntimeMessageForwardingVC ()
@property(nonatomic,strong)TestMessage *test;
@end

@implementation JCRuntimeMessageForwardingVC
/**
这个demo是说明消息转发的原理的。

*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
     
     /******类方法调用******/
     [[TestMessage class] performSelector:@selector(testClassFunction)];
     
     //类方法触发resolveClassMethod方法来判断是否能响应SEL
     
     /******对象方法调用******/
     [self.test performSelector:@selector(testFunction)];
     
     //对象方法触发resolveInstanceMethod方法来判断是否能响应SEL
    
     
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
