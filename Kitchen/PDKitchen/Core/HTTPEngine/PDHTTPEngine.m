//
//  PDHTTPEngine.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDHTTPEngine.h"

@implementation PDHTTPEngine

-(id)init{
    self = [super init];
    if (self) {
        _HTTPEngine = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:kHttpHost]];
        _HTTPEngine.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        _HTTPEngine.responseSerializer = [[AFHTTPResponseSerializer alloc] init];
    }
    return self;
}

+(PDHTTPEngine *)sharedInstance{
    static dispatch_once_t once;
    static PDHTTPEngine * __singleton = nil;
    dispatch_once( &once, ^{ __singleton = [[PDHTTPEngine alloc] init]; } );
    return __singleton;
}

- (NSString *)signWithPath:(NSString *)path params:(NSMutableDictionary *)params password:(NSString *) password{
    
    NSMutableDictionary *p = [[NSMutableDictionary alloc] initWithDictionary:params];
    
    // 添加版本，设备ID，平台等公用参数
    [p setObject:kPDAppVersion forKey:@"version"];
    NSString *device = [[UIDevice currentDevice] deviceKeychanID];
    [p setObject:device forKey:@"device"];
    [p setObject:@"ios" forKey:@"plateform"];
    
    NSMutableString *sign = [[NSMutableString alloc] init];
    [sign appendString:path];
    for (NSString *key in [p keysSortedByValueUsingSelector:@selector(compare:)]) {
        [sign appendString:[NSString stringWithFormat:@"%@%@",key,p[key]]];
    }
    [sign appendString:password];
    
    return [sign md5];
}

- (NSMutableDictionary *)paramWithDictionary:(NSMutableDictionary *)dict{
    
    return dict;
}

-(void)requestVerificationCodeWithPhone:(NSString *)phone
                                success:(void (^)(AFHTTPRequestOperation *operation, NSNumber *code))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:phone forKey:@"phone"];
    
    [_HTTPEngine GET:kPathOfSendVerification parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSNumber *theCode = result[@"data"][@"verification"];
        NSString *msg = result[@"msg"];
        
        if (code == 0) {
            success(operation,theCode);
        }else{
            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
            failure(operation,err);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
        failure(operation,error);
    }];
}

-(void)loginWithType:(NSNumber *)type
               phone:(NSString *)phone
             account:(NSString *)thirdpartID
        verification:(NSNumber *)verification
             success:(void (^)(AFHTTPRequestOperation *operation, NSString *userid))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:type forKey:@"type"];
    
    if (phone) {   // 手机验证码登录
        [parameters setObject:phone forKey:@"phone"];
        if (verification) {
            [parameters setObject:verification forKey:@"verification"];
        }
    }else{  // 微信微博QQ的 userid
        [parameters setObject:thirdpartID forKey:@"account"];
    }
    //parameters = [self paramWithDictionary:parameters];
    
    [_HTTPEngine GET:kPathOfUserLogin parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] longValue];
        NSString *theUserid = result[@"data"][@"userid"];
        NSString *msg = result[@"msg"];
        
        if (code == 0) {
            
            // 登录成功
            [PDAccountManager sharedInstance].userid = theUserid;
            success(operation,theUserid);
        }else{
            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
            failure(operation,err);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

-(void)appHomeWithLocation:(NSString *)location
                      page:(NSNumber *)page
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:location forKey:@"location"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine GET:kPathOfAppHome parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSArray *list = result[@"data"];
        NSString *msg = result[@"msg"];
        
        if (code == 0) {
            success(operation,list);
        }else{
            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
            failure(operation,err);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

// 详情
- (void)appDetailWithFoodID:(NSNumber *)foodid
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:foodid forKey:@"food_id"];
    
    [_HTTPEngine GET:kPathOfAppDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        //        int code = [result[@"Header"][@"Code"] intValue];
        //        NSString *msg = result[@"Header"][@"Message"];
        //        if (code == 200) {
        //            success(operation,responseObject);
        //        }else{
        //            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
        //            failure(operation,err);
        //        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

// 点赞
- (void)appLikeWithUserid:(NSString *)userid
                   foodid:(NSNumber *)foodid
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodid forKey:@"food_id"];
    
    [_HTTPEngine GET:kPathOfAppLike parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

- (void)messageAddwithUserid:(NSString *)userid
                      foodid:(NSNumber *)foodid
                    cookerid:(NSNumber *)cookerid
                        text:(NSString *)text
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodid forKey:@"food_id"];
    [parameters setObject:cookerid forKey:@"cooker_id"];
    [parameters setObject:text forKey:@"text"];
    
    [_HTTPEngine GET:kPathOfMessageAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        //        int code = [result[@"Header"][@"Code"] intValue];
        //        NSString *msg = result[@"Header"][@"Message"];
        //        if (code == 200) {
        //            success(operation,responseObject);
        //        }else{
        //            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
        //            failure(operation,err);
        //        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

// 留言列表
-(void)messageAllWithFoodid:(NSNumber *)foodid
                       page:(NSNumber *)page
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:foodid forKey:@"food_id"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine GET:kPathOfMessageAll parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        //        int code = [result[@"Header"][@"Code"] intValue];
        //        NSString *msg = result[@"Header"][@"Message"];
        //        if (code == 200) {
        //            success(operation,responseObject);
        //        }else{
        //            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
        //            failure(operation,err);
        //        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

-(void)cartAddWithUserid:(NSString *)userid
                 foodids:(NSString *)foodids
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodids forKey:@"foodids"];
    
    [_HTTPEngine GET:kPathOfCartAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

// 清空购物车
-(void)cartDeleteWithUserid:(NSString *)userid
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    
    [_HTTPEngine GET:kPathOfCartDelete parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

// 我的购物车
-(void)cartMyCartWithUserid:(NSString *)userid
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    
    [_HTTPEngine GET:kPathOfCartMyCart parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

// 提交订单
-(void)orderAddWithUserid:(NSString *)userid
                  foodids:(NSString *)foodids
                  address:(NSString *)address
                    phone:(NSString *)phone
                 couponid:(NSNumber *)couponid
                  eatTime:(NSString *)eatTime
                  message:(NSString *)message
                 sumPrice:(NSNumber *)sumPrice
                  success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodids forKey:@"foodids"];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:phone forKey:@"phone"];
    [parameters setObject:couponid forKey:@"coupon_id"];
    [parameters setObject:eatTime forKey:@"eat_time"];
    [parameters setObject:message forKey:@"message"];
    [parameters setObject:sumPrice forKey:@"sum_price"];
    
    
    [_HTTPEngine GET:kPathOfOrderAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

// 订单列表
-(void)orderMyOrderWithUserid:(NSString *)userid
                         page:(NSNumber *)page
                      success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{


    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine GET:kPathOfOrderMyOrder parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

// 物流动态
-(void)orderLogisticsWithUserid:(NSString *)userid
                        orderid:(NSNumber *)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine GET:kPathOfOrderLogistics parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

// 订单详情
-(void)orderDetailWithUserid:(NSString *)userid
                        orderid:(NSNumber *)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine GET:kPathOfOrderDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

-(void)orderBackWithUserid:(NSString *)userid
                   orderid:(NSNumber *)orderid
                   success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine GET:kPathOfOrderBack parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

// 我的地址
-(void)addressMyAddressWithUserid:(NSString *)userid
                      page:(NSNumber *)page
                   success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine GET:kPathOfAddressMyAddress parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

-(void)addressAddWithUserid:(NSString *)userid
                    city_id:(NSNumber *)city_id
                district_id:(NSNumber *)district_id
                    address:(NSString *)address
                      phone:(NSString *)phone
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:city_id forKey:@"city_id"];
    [parameters setObject:district_id forKey:@"district_id"];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:phone forKey:@"phone"];

    
    [_HTTPEngine GET:kPathOfAddressAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

    
}

-(void)addressEditWithUserid:(NSString *)userid
                     city_id:(NSNumber *)city_id
                 district_id:(NSNumber *)district_id
                     address:(NSString *)address
                       phone:(NSString *)phone
                     success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:city_id forKey:@"city_id"];
    [parameters setObject:district_id forKey:@"district_id"];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:phone forKey:@"phone"];
    
    
    [_HTTPEngine GET:kPathOfAddressEdit parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

-(void)addressDelWithUserid:(NSString *)userid
                 address_id:(NSNumber *)address_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:address_id forKey:@"address_id"];
    
    
    [_HTTPEngine GET:kPathOfAddressDel parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
    
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//  我的收藏
-(void)collectMyCollectWithUserid:(NSString *)userid
                             page:(NSNumber *)page
                          success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    
    [_HTTPEngine GET:kPathOfCollectMyCollect parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}
-(void)collectAddWithUserid:(NSString *)userid
                    food_id:(NSNumber *)food_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:food_id forKey:@"food_id"];
    
    
    [_HTTPEngine GET:kPathOfCollectAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

-(void)collectDeleteWithUserid:(NSString *)userid
                       food_id:(NSNumber *)food_id
                       success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:food_id forKey:@"food_id"];
    
    
    [_HTTPEngine GET:kPathOfCollectDelete parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

// 我的优惠券
-(void)couponMyCouponWithUserid:(NSString *)userid
                           page:(NSNumber *)page
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    
    [_HTTPEngine GET:kPathOfCouponMyCoupon parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

-(void)newsAllWithUserid:(NSString *)userid
                    page:(NSNumber *)page
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine GET:kPathOfNewsAll parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

-(void)newsDetailWithUserid:(NSString *)userid
                    news_id:(NSNumber *)news_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:news_id forKey:@"news_id"];
    
    [_HTTPEngine GET:kPathOfNewsDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];
}

-(void)newsDelWithUserid:(NSString *)userid
                 news_id:(NSNumber *)news_id
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:news_id forKey:@"news_id"];
    
    [_HTTPEngine GET:kPathOfNewsDel parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"%@",error);
        failure(operation,error);
    }];
}

@end

