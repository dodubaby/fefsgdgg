//
//  PDHTTPEngine.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDConfig.h"
#import "AFNetworking.h"
#import "JSONJoy.h"
#import "PDBaseModel.h"

@interface PDHTTPEngine : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *HTTPEngine;

+ (PDHTTPEngine *)sharedInstance;

@end
