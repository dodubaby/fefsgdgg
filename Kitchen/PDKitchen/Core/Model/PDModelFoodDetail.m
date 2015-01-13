//
//  PDModelFoodDetail.m
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDModelFoodDetail.h"

@implementation PDModelFoodDetail


+(JSONJoy*)jsonMapper
{
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    // !!!必要时指定array元素类型
    [mapper addArrayClassMap:@"message_object" class:[PDModelMessage class]];
    return mapper;
}

+(PDModelFoodDetail *)fromJson:(NSDictionary *)jsonDict{
    
    if (!jsonDict) {
        return nil;
    }
    
    PDModelFoodDetail *obj = [[PDModelFoodDetail alloc] init];
    
    obj.detail_object = [PDModelFood fromJson:jsonDict[@"detail_object"]];
    obj.cook_object = [PDModelCooker fromJson:jsonDict[@"cook_object"]];
    
    NSArray *list = jsonDict[@"message_object"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    if ([list isKindOfClass:[NSArray class]]&&[list count]>0) {
        [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            PDModelMessage *messsage = [PDModelMessage fromJson:obj];
            if (messsage) {
                [arr addObject:messsage];
            }
        }];
    }
    
    obj.message_object = arr;
    
    return obj;
}
@end
