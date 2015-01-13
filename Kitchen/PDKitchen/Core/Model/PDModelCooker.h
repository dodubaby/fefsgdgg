//
//  PDModelCooker.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@interface PDModelCooker : NSObject

@property (nonatomic,strong) NSString *about;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *cooker_from;
@property (nonatomic,strong) NSString *cooker_id;
@property (nonatomic,strong) NSString *cooker_name;
@property (nonatomic,strong) NSString *img;
@property (nonatomic,strong) NSString *specialty;

+(PDModelCooker *)fromJson:(NSDictionary *)jsonDict;

@end
