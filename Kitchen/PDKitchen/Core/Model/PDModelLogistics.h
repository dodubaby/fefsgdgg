//
//  PDModelLogistics.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseModel.h"

//custom = 18601212008;
//dispatching = 18601212008;
//status = 1;
//time = "13:38";

@interface PDModelLogistics : PDBaseModel

@property (nonatomic,strong) NSString *custom;
@property (nonatomic,strong) NSString *dispatching;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *status_title;
@end
