//
//  JCAssociatedObjectViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/11/18.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCAssociatedObjectViewController.h"
#import <objc/runtime.h>
#import "JCJumpModuleViewController.h"
static void *kAlertyViewKey = @"kAlertyViewKey";
@interface JCAssociatedObjectViewController ()
@property(nonatomic,assign)NSInteger testIndex;
@property(nonatomic,strong)NSArray *titleDataArr;
@property(nonatomic,strong)NSMutableArray *dataScource;


@end

@implementation JCAssociatedObjectViewController

- (NSArray *)titleDataArr{
    if (!_titleDataArr) {
        _titleDataArr = @[@"test1",@"test2",@"方法交换例子",@"自定义方法交换",@"万能跳"];
    }
    return _titleDataArr;
}

- (NSMutableArray *)dataScource{
    if (!_dataScource) {
        _dataScource = [NSMutableArray array];
    }
    return _dataScource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Runtime使用~关联对象";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
}


- (void)setupUI{
   
    for (NSInteger index = 0; index < self.titleDataArr.count; index ++) {
        
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = (index + 1) *1000000;
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        [btn setTitle:self.titleDataArr[index] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor RandomColor];//随机颜色
        [btn addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        [self.dataScource addObject:btn];
        
        
        if (self.dataScource.count == 5) {//必须在最后统一布局
            //FixedSpacing 水平左右间隔
            //leadSpacing  第一个item距离手机屏幕的距离
            //tailSpacing  最后一个item元素距离手机屏幕的距离
            [self.dataScource mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
            
            // 设置array的垂直方向的约束
            [self.dataScource mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(100);
                make.height.equalTo(100);
            }];
        }
    }
}



- (void)btnClickEvent:(UIButton *)sender{
    NSInteger tagValue = sender.tag;
    switch (tagValue) {
        case  1000000:
            [self testDemo1];
            break;
            
        case  2000000:
            [self testDemo2];
            break;
            
        case  3000000:
            [self testDemo3];
            break;
            
        case  4000000:
            [self testDemo4];
            break;
            
        case  5000000:
            
            break;
            [self.navigationController pushViewController:[JCJumpModuleViewController new] animated:YES];
        default:
            break;
    }
    
}






#pragma mark - 使用代理实现弹窗
//使用代理
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

#pragma mark - 方法调配技术”黑盒方法“

- (void)testDemo3{
    
//    id (* IMP)(id,SEL,.....)
  //方法交换前
    
    NSString *tesString = @"Thls ].S tHe StRiNg";
    
    NSLog(@"<============ 交换之前 ============>");
    NSString *lowercaseString_before = [tesString lowercaseString];
    NSLog(@"lowercaseString = %@",lowercaseString_before);
    // Output: lowercaseString = THIS IS THE STRING
    NSString *uppercaseString_before = [tesString uppercaseString];
    NSLog(@"uppercaseString = %@",uppercaseString_before);
    NSLog(@"====================");
    
    
/*
 方法交换后
   此函数的两个参数表示待交换的两个方法实现，
   void method_exchangeimplementations(Method ml, Method m2J
 而方法实现则可通过下列函数获得：
  Method class_getinstanceMethod(Class aClass, SEL aSelector)
  */
    
    Method originalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    
    Method swappedMethod = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    
   //交换方法  
    method_exchangeImplementations(originalMethod, swappedMethod);
    
    NSLog(@"<============ 交换之后 ============>");
    
    NSString *lowercaseString_after = [tesString lowercaseString];
    NSLog(@"lowercaseString = %@",lowercaseString_after);
          // Output: lowercaseString = THIS IS THE STRING
    NSString *uppercaseString_after = [tesString uppercaseString];
    NSLog(@"uppercaseString = %@",uppercaseString_after);
    
}

//自定义方法交换
- (void)testDemo4{
    Method testOriginalMethod = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method testSwappedMethod = class_getInstanceMethod([NSString class], @selector(JC_customLowercaseString));
    method_exchangeImplementations(testOriginalMethod, testSwappedMethod);
    NSString *string = @"Thls iS tHe StRiNg";
    NSString *lowercaseString = [string uppercaseString];
//    NSLog(@"自定义===》%@",lowercaseString);
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
