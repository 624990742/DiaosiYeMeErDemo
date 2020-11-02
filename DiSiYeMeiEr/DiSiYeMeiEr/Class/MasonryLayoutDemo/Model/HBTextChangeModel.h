//
//  HBTextChangeModel.h
//  HBTextShowAndPackUp
//
//  Created by Mac on 2020/10/11.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBTextChangeModel : NSObject
@property (nonatomic ,strong)NSString *content;
///Add - 展开
@property (nonatomic, assign) BOOL showAll;
@end

NS_ASSUME_NONNULL_END
