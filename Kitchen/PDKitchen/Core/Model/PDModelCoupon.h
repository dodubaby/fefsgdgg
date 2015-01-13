//
//  PDModelCoupon.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@interface PDModelCoupon : PDBaseModel

@property (nonatomic,strong) NSString *coupon_id;
@property (nonatomic,strong) NSString *end_time;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *time_str;

@end
