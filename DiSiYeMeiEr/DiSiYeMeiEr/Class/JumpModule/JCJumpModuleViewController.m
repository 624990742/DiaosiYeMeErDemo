//
//  JCJumpModuleViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/23.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCJumpModuleViewController.h"

@interface JCJumpModuleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation JCJumpModuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createData];
    [self tableView];
    [self.tableView reloadData];
    
}

- (void)createData {
    
  
    NSDictionary *property1 = @{@"blankTitleTest":@"Masonry演示demo"};
    NSDictionary *dic1 = @{kPushVCName:@"JCMasExampleListViewController", kPushVCProperty:property1};
    NSDictionary *contentDic1 = @{@"title":@"Masonry的小demo", @"content":dic1};
    
    NSDictionary *property2 = @{@"isCheckDetail":@"YES", @"model":@"ExampleSafeModel"};
    NSDictionary *dic2 = @{kPushVCName:@"JCMASExampleSafeAreaLayoutGuideViewController", kPushVCProperty:property2};
    NSDictionary *contentDic2 = @{@"title":@"银行卡详情", @"content":dic2};
    
    NSDictionary *property3 = @{@"isCheckDetail":@"NO",@"desArr":@[@"你好",@"北京"]};
    NSDictionary *dic3 = @{kPushVCName:@"JCSpeciesPatternViewController", kPushVCProperty:property3};
    NSDictionary *contentDic3 = @{@"title":@"添加银行卡", @"content":dic3};
    
   
    self.dataSource = [[NSMutableArray alloc] initWithObjects:contentDic1, contentDic2, contentDic3,nil];
}





- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCellID"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}



#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif



#pragma mark - UITableView Delegate && DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellID" forIndexPath:indexPath];
   
    cell.textLabel.text = @"测试";
    cell.detailTextLabel.text = @"就只是测试一下git";
//    cell.textLabel.text = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = [[self.dataSource objectAtIndex:indexPath.row] objectForKey:@"content"];
    
    UIViewController *vc = [[WBViewControllerManager sharedManager] getSpecificViewControllerFromInfo:dic];
    
    [self.navigationController pushViewController:vc animated:YES];
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
