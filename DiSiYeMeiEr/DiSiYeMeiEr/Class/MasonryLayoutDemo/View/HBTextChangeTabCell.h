//
//  HBTextChangeTabCell.h
//  HBTextShowAndPackUp
//
//  Created by Mac on 2020/10/11.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBTextChangeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HBTextChangeTabCell : UITableViewCell
@property (nonatomic ,strong)HBTextChangeModel *model;
@property (nonatomic ,copy)void(^updateMessageCellBlock)(NSString *str);
@end

NS_ASSUME_NONNULL_END
