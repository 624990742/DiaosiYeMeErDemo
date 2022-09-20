//
//  JCTestStudent.h
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/8/27.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface JCTestStudent : NSObject < NSCoding ,NSCopying, NSMutableCopying>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign) NSInteger age;
+(instancetype)studentWithName:(NSString *)name
                           age:(NSInteger)age;
@end

NS_ASSUME_NONNULL_END
