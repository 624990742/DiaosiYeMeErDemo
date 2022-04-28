//
//  JCSpecialFieldUseController.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/28.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCSpecialFieldUseController.h"
#import "JCSpecialFieldUseView.h"
@interface JCSpecialFieldUseController ()
@property (weak, nonatomic) IBOutlet UIView *customView;
@property (weak, nonatomic) IBOutlet UILabel *test1TipLabel;

@end

@implementation JCSpecialFieldUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    JCSpecialFieldUseView *testView = [[NSBundle mainBundle] loadNibNamed:@"JCSpecialFieldUseView" owner:nil options:nil].lastObject;
    [self.view addSubview:testView];
    [testView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.customView);
    }];
    [self.view insertSubview:self.test1TipLabel aboveSubview:testView];
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
