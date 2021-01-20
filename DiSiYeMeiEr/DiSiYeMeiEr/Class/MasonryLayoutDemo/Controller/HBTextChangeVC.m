//
//  HBTextChangeVC.m
//  HBTextShowAndPackUp
//
//  Created by Mac on 2020/10/11.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "HBTextChangeVC.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import "HBTextChangeModel.h"
#import "HBTextChangeTabCell.h"
#define WEAKSELF typeof(self) __weak weakSelf = self
/**
系统高度，宽度 bounds
*/
#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
@interface HBTextChangeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *tableView;
@property (nonatomic ,strong)NSMutableArray *allData;
@property (nonatomic ,strong)UIButton *backBtn;
@end

@implementation HBTextChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"在tablecell中文本的展开与收起";
    self.allData = [NSMutableArray array];
    //添加子视图
    [self addSubViewUI];
    //请求数据
    [self requestMessageListData];
    //增加刷新
    [self addRefresh];
}
#pragma mark ==========请求数据==========
-(void)requestMessageListData{
    NSArray *arr = @[@"山一程，水一程，身向榆关那畔行，夜深千帐灯。风一更，雪一更，聒碎乡心梦不成，故园无此声",
        @"昨夜雨疏风骤，浓睡不消残酒，试问卷帘人，却道海棠依旧。知否，知否，应是绿肥红瘦。",
        @"正单衣试酒，怅客里、光阴虚掷。愿春暂留，春归如过翼，一去无迹。为问花何在？夜来风雨，葬楚宫倾国。钗钿堕处遗香泽，乱点桃蹊，轻翻柳陌。多情为谁追惜？但蜂媒蝶使，时叩窗隔。东园岑寂，渐蒙笼暗碧。静绕珍丛底，成叹息。长条故惹行客，似牵衣待话，别情无极。残英小、强簪巾帻。终不似一朵，钗头颤袅，向人欹侧。漂流处、莫趁潮汐。恐断红、尚有相思字，何由见得？终不似一朵，钗头颤袅，向人欹侧。漂流处、莫趁潮汐。恐断红、尚有相思字，何由见得？由见得",
        @"夫六国与秦皆诸侯，其势弱于秦，而犹有可以不赂而胜之之势。苟以天下之大，下而从六国破亡之故事，是又在六国下矣！",
        @"千山鸟飞绝,万径人踪灭",
        @"人生有情泪沾衣，江水江花岂终极",
        @"人闲桂花落，夜静春山空。月出惊山鸟，时鸣春涧中",
        @"入我相思门，知我相思苦，长相思兮长相忆，短相思兮无穷极",
        @"山寺钟鸣昼已昏，渔梁渡头争渡喧。人随沙岸向江村，余亦乘舟归鹿门。鹿门月照开烟树，忽到庞公栖隐处",
        @"古今之成大事业、大学问者，必经过三种之境界：“昨夜西风凋碧树，独上高楼，望尽天涯路。”此第一境也。“衣带渐宽终不悔，为伊消得人憔悴。”此第二境也。“众里寻他千百度，回头蓦见，那人正在，灯火阑珊处。”此第三境也。未有不越第一境第二境而能邃跻第三境者。"
    ];
    for (int i = 0; i<10; i++) {
        HBTextChangeModel *model = [HBTextChangeModel new];
        model.content = arr[arc4random_uniform(10)];
        [self.allData addObject:model];
    }
    [self endRefresh];
    [self.tableView reloadData];
}
- (void)endRefresh{
    if (self.tableView.mj_header.refreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.refreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}
- (void)addRefresh{
    WEAKSELF;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //请求数据
       // weakSelf.pageNo = 1;
        [weakSelf.allData removeAllObjects];
        [weakSelf requestMessageListData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //请求数据
        //weakSelf.pageNo++;
        [weakSelf requestMessageListData];
    }];
}
#pragma mark ==========添加子视图==========
-(void)addSubViewUI{
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 25));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backBtn.mas_bottom);
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
    }];
}
#pragma mark ==========tableViewDelegate==========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

#pragma mark ==========tableview代理方法==========
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HBTextChangeTabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HBTextChangeTabCell"];
    if (cell == nil) {
        cell = [[HBTextChangeTabCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HBTextChangeTabCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    HBTextChangeModel *model = self.allData[indexPath.section];
    cell.model = model;
    WEAKSELF;
    cell.updateMessageCellBlock = ^(NSString * _Nonnull str) {
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    [cell layoutIfNeeded];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //全部商品
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    headerView.backgroundColor = [UIColor grayColor];
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    //全部商品
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
}

#pragma mark ==========tableViewGetter==========
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
            tableView.dataSource = self;
            tableView.delegate = self;
            tableView.backgroundColor = [UIColor clearColor];
            //设置分割线样式
            tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
            //cell的分割线距视图距离
            tableView.separatorInset=UIEdgeInsetsMake(0, 0, 0, 0);
            //隐藏底部多余分割线
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            //iOS11默认开启Self-Sizing，需关闭才能设置Header,Footer高度
            tableView.estimatedRowHeight = 66;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.rowHeight = 50 ;
            tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectZero];;
            tableView ;
        }) ;
    }
    return _tableView;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = ({
            //创建按钮
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            //设置标题
            [button setTitle:@"返回" forState:UIControlStateNormal];
            //设置字体大小
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            //设置title颜色
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //添加点击事件
            [button addTarget:self action:@selector(clickBackButton:) forControlEvents:UIControlEventTouchUpInside];
            
            button;
        });
    }
    return _backBtn;
}
#pragma mark ==========点击返回==========
-(void)clickBackButton:(UIButton *)button{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
