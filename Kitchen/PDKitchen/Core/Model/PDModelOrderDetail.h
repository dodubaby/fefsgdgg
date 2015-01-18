//
//  PDModelOrderDetail.h
//  PDKitchen
//
//  Created by zdf on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

//{
//    code = 0;
//    data =     {
//        "food_object" =         {
//            name = "\U9999\U83c7\U725b\U8089\U610f\U5927\U5229\U9762";
//            num = 1;
//            price = "25.50";
//        };
//        "order_object" =         {
//            address = 15;
//            "coupon_price" = "0.00";
//            "eat_time" = "2015-01-07 14:59:16";
//            "food_num" = 1;
//            "is_eat" = 0;
//            money = "25.50";
//            "order_id" = 95;
//            phone = 18601212008;
//            "send_price" = "0.00";
//            "sum_price" = "25.50";
//        };
//    };
//    msg = "\U6210\U529f";
//}

@class PDModelOrderFoodObject;
@class PDModelOrderOrderObject;

@interface PDModelOrderDetail : PDBaseModel

@property(nonatomic,strong) PDModelOrderFoodObject *food_object;
@property(nonatomic,strong) PDModelOrderOrderObject *order_object;

//@property(nonatomic,copy)NSString *name;
//@property(nonatomic,copy)NSString *price;
//@property(nonatomic,copy)NSString *sum;
//@property(nonatomic,copy)NSString *order_id;
//@property(nonatomic,copy)NSString *phone;
//@property(nonatomic,copy)NSString *eat_time;
//@property(nonatomic,copy)NSString *coupon_price;
//@property(nonatomic,copy)NSString *send_price;
//@property(nonatomic,copy)NSString *money;
//@property(nonatomic,copy)NSString *address;
//@property(nonatomic,copy)NSString *is_eat;

@end


@interface PDModelOrderFoodObject : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *num;
@property(nonatomic,strong) NSString *price;
@end

@interface PDModelOrderOrderObject : NSObject
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *coupon_price;
@property(nonatomic,strong) NSString *eat_time;
@property(nonatomic,strong) NSString *food_num;
@property(nonatomic,strong) NSString *is_eat;
@property(nonatomic,strong) NSString *money;
@property(nonatomic,strong) NSString *order_id;
@property(nonatomic,strong) NSString *phone;
@property(nonatomic,strong) NSString *send_price;
@property(nonatomic,strong) NSString *sum_price;

@end