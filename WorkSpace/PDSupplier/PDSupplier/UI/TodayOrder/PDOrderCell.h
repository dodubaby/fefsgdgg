//
//  PDOrderCell.h
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDBaseTableViewCell.h"
typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeToday = 1,  // 今日订单
    OrderTypeNormal,     // 普通订单

};
@interface PDOrderCell : PDBaseTableViewCell

@property(nonatomic,assign) OrderType type;

@end
