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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *DemoTableView;
@property(nonatomic,strong) NSArray *dataScource;
@end

@implementation ViewController
- (NSArray *)dataScource{
    if (!_dataScource) {
        _dataScource = @[@"MasonryDemo练习",@"NSStream流的使用"];
    }
    return _dataScource;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Demo集合";
   
   
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
    JCMasExampleListViewController *_examplisVC = [[JCMasExampleListViewController alloc] init];
    [self.navigationController pushViewController:_examplisVC animated:YES];
    
//    JCStreamUsageVC *testVC = [[JCStreamUsageVC  alloc] init];
//    [self.navigationController pushViewController:testVC animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
