//
//  JCSpeciesPatternViewController.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/4.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCSpeciesPatternViewController.h"
#import "JCSpeciesPatternObject.h"
@interface JCSpeciesPatternViewController ()

@end

@implementation JCSpeciesPatternViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self speciesPatternTest];
}


//类族模式测试
- (void)speciesPatternTest{
    JCSpeciesPatternObject *speciesObj1  = [JCSpeciesPatternObject employeeWithType:JCEmployeeTypeDeveloper];
    [speciesObj1 doSomeWork];
    
    
    JCSpeciesPatternObject *speciesObj2  = [JCSpeciesPatternObject employeeWithType:JCEmployeeTypeDesigner];
    [speciesObj2 doSomeWork];
    
    JCSpeciesPatternObject *speciesObj3  = [JCSpeciesPatternObject employeeWithType:JCEmployeeTypeFinace];
    [speciesObj3 doSomeWork];

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
