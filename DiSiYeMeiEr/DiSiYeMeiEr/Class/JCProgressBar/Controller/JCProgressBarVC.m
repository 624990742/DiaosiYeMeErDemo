//
//  JCProgressBarVC.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/4/27.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCProgressBarVC.h"
#import "JCCanvasViewController.h"
@interface JCProgressBarVC ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allBtnArr;
@property (weak, nonatomic) IBOutlet UIView *canvasView;
@property (weak, nonatomic) CAShapeLayer *progressLayer;
@property (weak, nonatomic) CALayer * maskLayer;

@end

@implementation JCProgressBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

- (IBAction)clickAction:(UIButton *)sender {
    self.canvasView.hidden = NO;
    NSInteger tagValue = sender.tag;
    JCCanvasViewController *vc = [[JCCanvasViewController alloc] init];
    vc.type = tagValue;
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
