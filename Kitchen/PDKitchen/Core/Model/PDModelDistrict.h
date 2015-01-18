//
//  PDModelDistrict.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

@interface PDModelDistrict : PDBaseModel

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *parentid;
@property (nonatomic,strong) NSString *rank;

@end
