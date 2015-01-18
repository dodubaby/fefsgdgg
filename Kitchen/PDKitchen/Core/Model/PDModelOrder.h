//
//  PDModelOrder.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

//"food_img" = "http://182.92.170.104//uploads/foods/1/aaa1.png";
//"food_name" = "\U9999\U83c7\U725b\U8089\U610f\U5927\U5229\U9762";
//"food_num" = 1;
//"food_price" = "25.50";
//"order_id" = 98;

@interface PDModelOrder : PDBaseModel

@property (nonatomic,strong) NSString *food_img;
@property (nonatomic,strong) NSString *food_name;
@property (nonatomic,strong) NSString *food_num;
@property (nonatomic,strong) NSString *food_price;
@property (nonatomic,strong) NSString *order_id;

@end
