//
//  PDModelMessage.h
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@interface PDModelMessage : NSObject

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *cooker_id;
@property (nonatomic,strong) NSString *create_time;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *time_str;

+(PDModelMessage *)fromJson:(NSDictionary *)jsonDict;

@end
