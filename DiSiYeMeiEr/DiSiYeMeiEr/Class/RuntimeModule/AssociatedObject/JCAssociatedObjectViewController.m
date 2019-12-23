//
//  JCAssociatedObjectViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/11/18.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCAssociatedObjectViewController.h"
#import <objc/runtime.h>
static void *kAlertyViewKey = @"kAlertyViewKey";
@interface JCAssociatedObjectViewController ()
@property(nonatomic,assign)NSInteger testIndex;
@end

@implementation JCAssociatedObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Runtime使用~关联对象";
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = [UIButton  buttonWithType:UIButtonTypeCustom];
    [btn1 setTitle:@"使用代理" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 addTarget:self action:@selector(testDemo1) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn1];
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(200);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.equalTo(CGSizeMake(160, 50));
    }];
    
    
    
    for (NSInteger index = 0; index < 20; index++) {
        
    }
    
    
    
    
    
    
    
    UIButton *btn2 = [UIButton  buttonWithType:UIButtonTypeCustom];
    [btn2 addTarget:self action:@selector(testDemo2) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"关联对象" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn2];
    [btn2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn1.mas_bottom).offset(80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.equalTo(CGSizeMake(160, 50));
    }];
    
    
}


#pragma mark - 使用代理实现弹窗
- (void)testDemo1{
    self.testIndex = 1;
    UIAlertView *alerty = [[UIAlertView  alloc] initWithTitle:@"使用代理的提示框" message:@"玩一玩" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alerty show];
}

//delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
  
    if (self.testIndex == 2) {
        void(^ButtonBlock)(NSInteger) = objc_getAssociatedObject(alertView, kAlertyViewKey);
        ButtonBlock(buttonIndex);
    }else{
        if (buttonIndex == 0) {
            NSLog(@"取消");
        }else{
            NSLog(@"确定");
        }
        
        
    }
  
}





#pragma mark - 关联对象

- (void)testDemo2{
    self.testIndex = 2;
    UIAlertView *alerty = [[UIAlertView  alloc] initWithTitle:@"使用关联对象的提示框" message:@"玩一玩" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    void (^ButtonBlock)(NSInteger) = ^(NSInteger buttonIndex){
        if (buttonIndex == 0) {
            NSLog(@"关联对象=====取消");
        }else{
            NSLog(@"关联对象=====确定");
        }
    };
    
    //设置对象关联
    objc_setAssociatedObject(alerty, kAlertyViewKey,ButtonBlock, OBJC_ASSOCIATION_COPY);
    
    [alerty show];
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
