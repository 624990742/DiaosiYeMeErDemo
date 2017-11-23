//
//  ViewController.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/21.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "ViewController.h"
#import "TextFilterAbilityVC.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *test;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [_test  addTarget:self action:@selector(abilityClick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)abilityClick:(id)btn{
    TextFilterAbilityVC *textFilterVC = [[TextFilterAbilityVC alloc] init];
     [self  presentViewController:textFilterVC  animated:YES completion:nil];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
