//
//  PDModelFood.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@interface PDModelFood : PDBaseModel

@property (nonatomic,strong) NSString *cooker_img;
@property (nonatomic,strong) NSString *cooker_name;
@property (nonatomic,strong) NSString *food_id;
@property (nonatomic,strong) NSString *food_img;
@property (nonatomic,strong) NSString *food_name;
@property (nonatomic,strong) NSString *price;

@property (nonatomic,strong) NSString *cooker_id;
@property (nonatomic,strong) NSString *eat_sum;
@property (nonatomic,strong) NSString *like_sum;
@property (nonatomic,strong) NSString *phone;

+(PDModelFood *)fromJson:(NSDictionary *)jsonDict;

@end
