//
//  ViewController.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/21.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "ViewController.h"
#import "CustomButtonVC.h"
#import "JCStreamUsageVC.h"
#import "JCMasExampleListViewController.h"
#import "JCAssociatedObjectViewController.h"
#import "JCSpeciesPatternViewController.h"
#import "JCScreenshotsViewController.h"
#import "TextFilterAbilityVC.h"
#import "JCtestVCViewController.h"
#import "HBTextChangeVC.h"
#import "JCRuntimeMessageForwardingVC.h"
#import "JCAlgorithmViewController.h"
#import "JWeakAndStrongViewController.h"
#import "JCQueueViewController.h"
#import "JCSummaryTableVC.h"
#import "UINavigationBar+JCNavigationBarHandle.h"
#import "JCProgressBarVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *DemoTableView;
@property(nonatomic,strong) NSArray *dataScource;
@property(nonatomic,strong) NSDictionary * allVCs;
@end

@implementation ViewController

#pragma mark -
- (NSDictionary *)allVCs{
    
   
    return @{
        @"MasonryDemo练习":[[JCMasExampleListViewController alloc] init],
        @"Runtime的使用":[[JCAssociatedObjectViewController alloc] init],
        @"设计模式只类族模式":[[JCSpeciesPatternViewController alloc] init],
        @"截屏图片":[[JCScreenshotsViewController alloc] init],
        @"输入框对键盘的优化":[[TextFilterAbilityVC alloc] init],
        @"使用masonry实现自适应":[[HBTextChangeVC alloc] init],
        @"消息转发案例":[[JCRuntimeMessageForwardingVC alloc] init],
        @"手势相关":[[JCSummaryTableVC alloc] init],
        @"算法案例":[[JCAlgorithmViewController alloc] init],
        @"__weak和__strong的使用场景":[[JWeakAndStrongViewController alloc] init],
        @"多线程NSBlockOperation":[[JCQueueViewController alloc] init],
        @"web 交互":[[JCtestVCViewController alloc] init],
        @"自定义进度条":[[JCProgressBarVC alloc] init],
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开发常用总结";
    [self.navigationController.navigationBar jc_navBarBackGroundColor:[UIColor whiteColor] image:nil isOpaque:YES];//颜色
    [self.navigationController.navigationBar jc_navBarBottomLineHidden:YES];
    self.dataScource = self.allVCs.allKeys;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataScource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataScource[indexPath.row];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    [self.navigationController pushViewController:[self.allVCs objectForKey:self.dataScource[indexPath.row]] animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
