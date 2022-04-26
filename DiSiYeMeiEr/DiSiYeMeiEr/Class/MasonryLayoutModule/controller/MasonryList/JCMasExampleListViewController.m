//
//  JCMasExampleListViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCMasExampleListViewController.h"
#import "JCMASExampleLayoutGuideViewController.h"
#import "JCMASExampleSafeAreaLayoutGuideViewController.h"
#import "JCBasicLayoutView.h"
#import "JCUpdateConstraintsView.h"
#import "JCRemakeConstraintsView.h"
#import "JCUseingConstantsView.h"
#import "JCCompositeEdgesView.h"
#import "JCAspectFitView.h"
#import "JCMoreViewOrButton.h"
#import "UINavigationBar+JCNavigationBarHandle.h"


static NSString * const kMASCellIdentifier = @"kMASCellIdentifier";
@interface JCMasExampleListViewController ()
@property (nonatomic, strong) NSString *blankTitleTest;
@property (nonatomic, strong) NSArray *exampleControllers;
@end

@implementation JCMasExampleListViewController
/**
 //是一个类方法,用来判断该类的的实例(即对象)是否响应某个方法
 + (BOOL)instancesRespondToSelector:(SEL)aSelector;
 //是一个实例(对象)方法,用来判断该实例(对象)是否响应某个方法
 - (BOOL)respondsToSelector:(SEL)aSelector
 */
- (instancetype)init{
    if (!self) return nil;
    self.title = @"Masonry演示demo";
 
    self.exampleControllers = @[
      [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry基本用法" viewClass:JCBasicLayoutView.class],
      [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry更新约束" viewClass:JCUpdateConstraintsView.class],
      [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry动态移除约束" viewClass:JCRemakeConstraintsView.class],
      
        [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry使用约束" viewClass:JCUseingConstantsView.class],
       [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry使用内边距添加约束" viewClass:JCCompositeEdgesView.class],
      [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"Masonry使用内边距添加约束" viewClass:JCAspectFitView.class], [[JCMASExampleLayoutGuideViewController alloc] initWithTitle:@"多个View或者多个Button布局" viewClass:JCMoreViewOrButton.class],
      ];
    if ([UIViewController instancesRespondToSelector:@selector(topLayoutGuide)]) {
        self.exampleControllers = [self.exampleControllers arrayByAddingObject:[[JCMASExampleLayoutGuideViewController alloc] init]];
    }
    if ([UIView instancesRespondToSelector:@selector(safeAreaLayoutGuide)]) {
        self.exampleControllers = [self.exampleControllers arrayByAddingObject:[[JCMASExampleSafeAreaLayoutGuideViewController alloc] init]];
    }
                
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
       NSLog(@"%@",self.blankTitleTest);
    [self.navigationController.navigationBar jc_navBarBackGroundColor:[UIColor greenColor] image:nil isOpaque:YES];//颜色
    ///更改高度
//    [self.navigationController.navigationBar jc_navBarMyLayerHeight:90 isOpaque:YES];//背景高度
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kMASCellIdentifier];
    
//    char str1[] = "aac"; // a a
//    char str2[] = "abc"; // a b
//    
//    // strcmp它会对传入的字符串进行比较, 比较完毕之后会返回一个整型的值给我们
//    // strcmp的原理: 取出字符串中的每一个字符进行逐个比较, 如果发现不相等就不会继续往下比较
//    int res = strcmp(str1, str2);
//    printf("strcmp = %i\n", res);
//    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMASCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = viewController.title;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.exampleControllers.count;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = self.exampleControllers[indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
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
