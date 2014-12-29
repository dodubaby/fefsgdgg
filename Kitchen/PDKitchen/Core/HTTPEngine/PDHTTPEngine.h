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

// API path
// 登录
#define kPathOfLogin @"/user/login"

@interface PDHTTPEngine : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *HTTPEngine;

+ (PDHTTPEngine *)sharedInstance;

-(void)loginWithType:(NSNumber *)type
               phone:(NSString *)phone
             account:(NSString *)thirdpartID
        verification:(NSString *)verification
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
