//
//  PDModelFoodDetail.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"
#import "PDModelFood.h"
#import "PDModelCooker.h"
#import "PDModelMessage.h"

@interface PDModelFoodDetail : NSObject

@property (nonatomic,strong) PDModelFood   *detail_object;
@property (nonatomic,strong) PDModelCooker *cook_object;
@property (nonatomic,strong) NSArray       *message_object;

+(PDModelFoodDetail *)fromJson:(NSDictionary *)jsonDict;

@end



