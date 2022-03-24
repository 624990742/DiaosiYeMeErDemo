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
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *DemoTableView;
@property(nonatomic,strong) NSArray *dataScource;
@end

@implementation ViewController
- (NSArray *)dataScource{
    if (!_dataScource) {
        _dataScource = @[@"MasonryDemo练习",@"Runtime的使用",@"设计模式只类族模式",@"截屏图片",@"输入框对键盘的优化",@"打印",@"使用masonry实现自适应",@"消息转发案例",@"算法案例",@"__weak和__strong的使用场景",@"多线程NSBlockOperation",@"手势相关"];
    }
    return _dataScource;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"开发常用总结";
 
    
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
    
    switch (indexPath.row) {
        case 0:{
            JCMasExampleListViewController *_examplisVC = [[JCMasExampleListViewController alloc] init];
            [self.navigationController pushViewController:_examplisVC animated:YES];
            
            break;
        }
        case 1:
        {
            [self.navigationController pushViewController:[JCAssociatedObjectViewController new] animated:YES];
            
            break;
        }
        case 2:
        {
            [self.navigationController pushViewController:[JCSpeciesPatternViewController new] animated:YES];
            break;
        }
        case 3:
        {
            [self.navigationController pushViewController:[JCScreenshotsViewController new] animated:YES];
            break;
        }
        
        case 4:
        {
             [self.navigationController pushViewController:[TextFilterAbilityVC new] animated:YES];
            break;
        }
            
        case 5:
        {
            [self.navigationController pushViewController:[JCtestVCViewController new] animated:YES];
            
            break;
        }
        
        case 6:
        {
            [self.navigationController pushViewController:[HBTextChangeVC new]
             animated:YES];
            
            
            break;
        }
        case 7:
       {
       
         [self.navigationController pushViewController:[JCRuntimeMessageForwardingVC new]
            animated:YES];
           break;
        }
            
            case 8:
                 {
              [self.navigationController pushViewController:[JCAlgorithmViewController new]
                      animated:YES];
                     break;
                  }
           case 9:
            {
               
            [self.navigationController pushViewController:[JWeakAndStrongViewController new]
                animated:YES];
                break;
           }
        case 10:
         {
         [self.navigationController pushViewController:[JCQueueViewController new]
             animated:YES];
             break;
        }
        case 11:
         {
         [self.navigationController pushViewController:[JCSummaryTableVC new]
             animated:YES];
             break;
        }
            
            
        default:
            break;
    }
    
    
  
//    JCStreamUsageVC *testVC = [[JCStreamUsageVC  alloc] init];
//    [self.navigationController pushViewController:testVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
