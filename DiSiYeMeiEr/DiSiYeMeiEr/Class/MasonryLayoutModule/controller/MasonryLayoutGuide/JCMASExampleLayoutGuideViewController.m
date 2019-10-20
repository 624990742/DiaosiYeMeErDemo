//
//  MASExampleLayoutGuideViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/10/20.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCMASExampleLayoutGuideViewController.h"

@interface JCMASExampleLayoutGuideViewController ()
@property(nonatomic,strong) Class viewClass;
@end

@implementation JCMASExampleLayoutGuideViewController


- (id)initWithTitle:(NSString *)title viewClass:(Class)viewClass{
    self = [super init];
    if (!self) return nil;
    self.title = title;
    self.viewClass = viewClass;
    
    return self;
}


- (void)loadView{
    self.view = [self.viewClass new];
    self.view.backgroundColor = [UIColor whiteColor];
}


#ifdef __IPHONE_7_0
- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}
#endif



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
