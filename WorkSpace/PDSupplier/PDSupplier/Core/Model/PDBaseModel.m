//
//  PDBaseModel.m
//  PDKitchen
//
//  Created by bright on 14/12/19.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@implementation PDBaseModel

+(JSONJoy*)jsonMapper
{
    JSONJoy* mapper = [[JSONJoy alloc] initWithClass:[self class]];
    // !!!必要时指定array元素类型
    //[mapper addArrayClassMap:@"photos" class:[Photo class]];
    return mapper;
}

@end
