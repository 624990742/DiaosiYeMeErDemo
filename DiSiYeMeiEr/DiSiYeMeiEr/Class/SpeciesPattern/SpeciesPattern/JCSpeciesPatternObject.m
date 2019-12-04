//
//  JCSpeciesPattern.m
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/4.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import "JCSpeciesPatternObject.h"
#import "JCSpeciesEmployeeTypeDeveloper.h"
#import "JCSpeciesEmployeeTypeDesigner.h"
#import "JCSpeciesEmployeeTypeFinace.h"

@implementation JCSpeciesPatternObject

/*
 每个“实体子类”都是从基类继承而来。
 基类相当于一个管理类然后根据不同
 模式的子类去做相应的处理
 */
+ (JCSpeciesPatternObject *)employeeWithType:(JCEmployeeType)type{
    switch (type) {
         case JCEmployeeTypeDeveloper:
            
            return [JCSpeciesEmployeeTypeDeveloper new];
            break;
            
         case JCEmployeeTypeDesigner:
            return [JCSpeciesEmployeeTypeDesigner new];
            break;
            
            case JCEmployeeTypeFinace:
            return [JCSpeciesEmployeeTypeFinace new];
            break;
            
    }
}


- (void)doSomeWork{
    NSLog(@"%@做的一些工作",[self class]);
}

@end



