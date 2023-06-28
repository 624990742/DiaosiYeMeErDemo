//
//  JCTestMenuVC.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2023/4/13.
//  Copyright © 2023 JCTrustYourself. All rights reserved.
//

#import "JCTestMenuVC.h"
#import "JCCustomMenuView.h"
#import "JCCustomView.h"
@interface JCTestMenuVC ()
//@property(strong,nonatomic)JCCustomMenuView *menuView;

@end

@implementation JCTestMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.menuView = [[JCCustomMenuView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40.0)];
    //    self.menuView.backgroundColor = [UIColor grayColor];
    //    self.menuView.titles = @[@"全部",@"新闻访谈",@"童话故事",@"四六级",@"测试数据1",@"测试数据2",@"测试数据3",@"测试数据4",@"测试数据5",@"测试数据6"];
    //    [self.view addSubview:self.menuView];
    //
    //    NSString *htmlString = @"<p><strong><span style=\"font-family: &quot;times new roman&quot;; font-size: 16px;\"></span>bent double （由于强烈的感情或疼痛）屈身的，弯腰的</strong></p><p>例：He was bent double with laughter.</p><p>他笑得前仰后合。</p><p>相关俚语：</p><p><span style=\"color: #0070C0;\">be bent on sth./doing sth. 决意要做……的；一心想拥有……的</span></p><p>例：He was bent on getting married as soon as possible.</p><p>他一心想尽快结婚。</p><p><span style=\"font-family: &quot;times new roman&quot;; font-size: 16px;\"></span></p>";
    //
    //    // 将 HTML 字符串转换为 NSAttributedString
    //    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    //
    //
    //    // 将 NSAttributedString 显示在一个 UILabel 上
    //    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //    label.attributedText = attributedString;
    //    label.numberOfLines = 0;
    //    label.textColor = [UIColor greenColor];
    //    label.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:label];
    
    NSString *_htmlStr = @"<p>本权益中精选《经济学人》、《英国卫报》、《科学美国人》等国外经典期刊中的文章，由高校名师细致讲解，并辅之课后习题，帮你读懂、学懂那些有较高难度的英文文章，提升英语阅读能力！</p><p><img src=\"http://upload.kekenet.com/2023/0327/40616799101303914.png\" title=\"40616799101303914.png\" alt=\"212121.png\" width=\"306\" height=\"623\" style=\"width:306px;height=623px;\"/></p><p>注意：本权益为【畅学会员】专属权益，需开通【可可英语畅学会员】才可观看全部内容哦。</p>";
    JCCustomView *_customView = [[JCCustomView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height)];
    [_customView setHtmlString:_htmlStr];
    [self.view addSubview:_customView];
    
    
    
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
