//
//  PDHTTPEngine.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDConfig.h"
#import "PDUtils.h"
#import "AFNetworking.h"
#import "JSONJoy.h"
#import "Lockbox.h"
#import "PDBaseModel.h"

// API path
// 登录
#define kPathOfLogin @"kitchen/login"
#define kPathOfToday @"kitchenorder/today"


@interface PDHTTPEngine : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *HTTPEngine;

+ (PDHTTPEngine *)sharedInstance;

// 包含默认参数. md5(path + 排序keyvalue组合 + password)
- (NSString *)signWithPath:(NSString *)path params:(NSMutableDictionary *)params password:(NSString *) password;

-(void)loginWithphone:(NSString *)phone
             password:(NSString *)password
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

-(void)getTodayOrderWithKitchenid:(NSString*)kitchenid
                             type:(NSInteger)type
                             page:(NSInteger)page
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end
