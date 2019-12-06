//
//  JCEocAutoDictionary.h
//  DiSiYeMeiEr
//
//  Created by jiachen on 2019/12/6.
//  Copyright © 2019 JCTrustYourself. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCEocAutoDictionary : NSObject
@property(nonatomic,strong) NSString *string;
@property(nonatomic,strong) NSNumber *number;
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) id opaqueObject;

@end

NS_ASSUME_NONNULL_END
