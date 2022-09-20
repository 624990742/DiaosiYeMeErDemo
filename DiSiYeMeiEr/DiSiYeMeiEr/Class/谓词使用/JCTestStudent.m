//
//  JCTestStudent.m
//  DiSiYeMeiEr
//
//  Created by jcmac on 2022/8/27.
//  Copyright © 2022 JCTrustYourself. All rights reserved.
//

#import "JCTestStudent.h"

@implementation JCTestStudent
+(instancetype)studentWithName:(NSString *)name
                           age:(NSInteger)age{
    JCTestStudent *stu = [[JCTestStudent alloc] init];
    stu.name = name;
    stu.age = age;
    return  stu;
}

-(id)copy{
    JCTestStudent *stu = [[JCTestStudent alloc] init];
    stu.name = self.name;
    stu.age = self.age;
    return  stu;
}
-(id)mutableCopy{
    JCTestStudent *stu = [[JCTestStudent alloc] init];
    stu.name = self.name;
    stu.age = self.age;
    return  stu;
}

- (id)copyWithZone:(NSZone *)zone {
    JCTestStudent *stu = [[JCTestStudent alloc] init];
    stu.name = self.name;
    stu.age = self.age;
    return  stu;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    JCTestStudent *stu = [[JCTestStudent alloc] init];
    stu.name = self.name;
    stu.age = self.age;
    return  stu;
}


@end
