//
//  ViewController.m
//  DiSiYeMeiEr
//
//  Created by JCTrustYourself on 2017/11/21.
//  Copyright © 2017年 JCTrustYourself. All rights reserved.
//

#import "ViewController.h"
#import"TextFilterAbilityVC.h"
#import "CustomButtonVC.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIButton *textFieldAbility;
@property (strong, nonatomic) IBOutlet UIButton *customButton;//自定义button


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title = @"demo集合";
    [self createButton];
   

}
-(void)abilityClick:(id)btn{
 
    TextFilterAbilityVC *textFilterVC = [[TextFilterAbilityVC alloc] init];
    [self.navigationController  pushViewController:textFilterVC animated:YES];
}

-(void)customBtnClick:(id)btn{
    
    CustomButtonVC *customBtnVC = [[CustomButtonVC  alloc] init];
    [self.navigationController  pushViewController:customBtnVC animated:YES];
    
}

#pragma mark - 自定义

-(void)createButton{
        [_textFieldAbility  addTarget:self action:@selector(abilityClick:) forControlEvents:UIControlEventTouchUpInside];
    
        [_customButton  addTarget:self action:@selector(customBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
