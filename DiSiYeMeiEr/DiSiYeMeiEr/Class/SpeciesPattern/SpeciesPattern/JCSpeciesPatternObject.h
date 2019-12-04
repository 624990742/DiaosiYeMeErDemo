//
//  JCSpeciesPattern.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/4.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 类簇模式
 */
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger ,JCEmployeeType) {
      JCEmployeeTypeDeveloper,
      JCEmployeeTypeDesigner,
      JCEmployeeTypeFinace,
};

@interface JCSpeciesPatternObject : NSObject
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) NSUInteger salary;
+(JCSpeciesPatternObject *)employeeWithType:(JCEmployeeType)type;
- (void)doSomeWork;

@end


NS_ASSUME_NONNULL_END
