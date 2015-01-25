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
        _HTTPEngine.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
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
                                success:(void (^)(AFHTTPRequestOperation *operation, NSString *code))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:phone forKey:@"phone"];
    
    [_HTTPEngine POST:kPathOfSendVerification parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        if (code == 0) {
            NSString *theCode = nil;
            NSNumber *c = data[@"verification"];
            if (c) {
                theCode = [c stringValue];
            }
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
        verification:(NSString *)verification
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
    
    [_HTTPEngine POST:kPathOfUserLogin parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] longValue];
        NSDictionary *data = result[@"data"];
        NSString *msg = result[@"msg"];
        
        if (code == 0) {
            NSString *theUserid = nil;
            if (data) {
                theUserid = data[@"userid"];
                [PDAccountManager sharedInstance].coupon_count = data[@"coupon_count"];
                [PDAccountManager sharedInstance].news_count = data[@"news_count"];
            }
            
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
                   success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:location forKey:@"location"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine POST:kPathOfAppHome parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0) {
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                //PDModelFood *fd = [PDModelFood fromJson:obj];
                PDModelFood *fd = [PDModelFood objectWithJoy:obj];
                if (fd) {
                    [arr addObject:fd];
                }
            }];
        }
        
        if (code == 0) {
            success(operation,arr);
        }else{
            NSError *err = [NSError errorWithDomain:kHttpHost code:code userInfo:@{@"Message":msg}];
            failure(operation,err);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",[error localizedDescription]);
        
        failure(operation,error);
    }];
    
}

// 详情
- (void)appDetailWithFoodID:(NSString *)foodid
                    success:(void (^)(AFHTTPRequestOperation *operation, PDModelFoodDetail * foodDetail))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:foodid forKey:@"food_id"];
    
    [_HTTPEngine POST:kPathOfAppDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            //PDModelFoodDetail *detail = [PDModelFoodDetail fromJson:data];
            PDModelFoodDetail *detail = [PDModelFoodDetail objectWithJoy:data];
            success(operation,detail);
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

// 点赞
- (void)appLikeWithUserid:(NSString *)userid
                   foodid:(NSNumber *)foodid
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodid forKey:@"food_id"];
    
    [_HTTPEngine POST:kPathOfAppLike parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        if (code == 0) {
            success(operation,data);
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

- (void)messageAddwithUserid:(NSString *)userid
                      foodid:(NSString *)foodid
                    cookerid:(NSString *)cookerid
                        text:(NSString *)text
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodid forKey:@"food_id"];
    [parameters setObject:cookerid forKey:@"cooker_id"];
    [parameters setObject:text forKey:@"text"];
    
    [_HTTPEngine POST:kPathOfMessageAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        if (code == 0) {
            success(operation,responseObject);
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

// 留言列表
-(void)messageAllWithFoodid:(NSString *)foodid
                       page:(NSNumber *)page
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:foodid forKey:@"food_id"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine POST:kPathOfMessageAll parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        //PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelMessage *message = [PDModelMessage objectWithJoy:obj];
                if (message) {
                    [arr addObject:message];
                }
            }];
        }
        if (code ==0) {
            success(operation,arr);
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

-(void)cartAddWithUserid:(NSString *)userid
                 foodids:(NSString *)foodids
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodids forKey:@"foodids"];
    
    [_HTTPEngine POST:kPathOfCartAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    [_HTTPEngine POST:kPathOfCartDelete parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    [_HTTPEngine POST:kPathOfCartMyCart parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                 couponid:(NSString *)couponid
                  eatTime:(NSString *)eatTime
                  message:(NSString *)message
                 sumPrice:(NSNumber *)sumPrice
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:foodids forKey:@"food_ids"];
    [parameters setObject:address forKey:@"address"];
    
    if (phone) {
        [parameters setObject:phone forKey:@"phone"];
    }
    if(couponid){
    
        [parameters setObject:couponid forKey:@"coupon_id"];
    }
    
    if(eatTime){
    
        [parameters setObject:eatTime forKey:@"eat_time"];
    }
    
    if (message) {
        [parameters setObject:message forKey:@"message"];
    }
    
    [parameters setObject:sumPrice forKey:@"sum_price"];
    
    
    [_HTTPEngine POST:kPathOfOrderAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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

// 订单列表
-(void)orderMyOrderWithUserid:(NSString *)userid
                         page:(NSNumber *)page
                      success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{


    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine POST:kPathOfOrderMyOrder parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        //PDModelOrder
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
        
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelOrder *od = [PDModelOrder objectWithJoy:obj];
                if (od) {
                    [arr addObject:od];
                }
            }];
        }
        if (code == 0) {
            success(operation,arr);
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

// 物流动态
-(void)orderLogisticsWithUserid:(NSString *)userid
                        orderid:(NSString *)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine POST:kPathOfOrderLogistics parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelLogistics *lg = [PDModelLogistics objectWithJoy:obj];
                if (lg) {
                    [arr addObject:lg];
                }
            }];
        }
        
        if (code == 0) {
            success(operation,arr);
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

// 订单详情
-(void)orderDetailWithUserid:(NSString *)userid
                        orderid:(NSString *)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, PDModelOrderDetail *deteil))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine POST:kPathOfOrderDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        if (code == 0) {
            PDModelOrderDetail *deteil = nil;
            if(data){
                deteil = [PDModelOrderDetail objectWithJoy:data];
            }
            success(operation,deteil);
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

-(void)orderBackWithUserid:(NSString *)userid
                   orderid:(NSString *)orderid
                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:orderid forKey:@"order_id"];
    
    [_HTTPEngine POST:kPathOfOrderBack parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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

// 我的地址
-(void)addressMyAddressWithUserid:(NSString *)userid
                      page:(NSNumber *)page
                   success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine POST:kPathOfAddressMyAddress parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
        
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelAddress *ad = [PDModelAddress objectWithJoy:obj];
                if (ad) {
                    [arr addObject:ad];
                }
            }];
        }
        
        if (code == 0) {
            success(operation,arr);
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

-(void)addressAddWithUserid:(NSString *)userid
                    city_id:(NSString *)city_id
                district_id:(NSString *)district_id
                    address:(NSString *)address
                      phone:(NSString *)phone
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:city_id forKey:@"city_id"];
    [parameters setObject:district_id forKey:@"district_id"];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:phone forKey:@"phone"];

    
    [_HTTPEngine POST:kPathOfAddressAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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
    
    
    [_HTTPEngine POST:kPathOfAddressEdit parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
        NSLog(@"%@",error);
        
        failure(operation,error);
    }];

}

-(void)addressDelWithUserid:(NSString *)userid
                 address_id:(NSString *)address_id
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:address_id forKey:@"address_id"];
    
    [_HTTPEngine POST:kPathOfAddressDel parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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
    
    
    [_HTTPEngine POST:kPathOfCollectMyCollect parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
            
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelFood *fd = [PDModelFood objectWithJoy:obj];
                if (fd) {
                    [arr addObject:fd];
                }
            }];
        }
        
        if (code == 0) {
            success(operation,arr);
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
-(void)collectAddWithUserid:(NSString *)userid
                    food_id:(NSString *)food_id
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:food_id forKey:@"food_id"];
    
    
    [_HTTPEngine POST:kPathOfCollectAdd parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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

-(void)collectDeleteWithUserid:(NSString *)userid
                       food_id:(NSString *)food_id
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:food_id forKey:@"food_id"];
    
    [_HTTPEngine POST:kPathOfCollectDelete parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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

// 我的优惠券
-(void)couponMyCouponWithUserid:(NSString *)userid
                           page:(NSNumber *)page
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    
    [_HTTPEngine POST:kPathOfCouponMyCoupon parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
        
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelCoupon *cp = [PDModelCoupon objectWithJoy:obj];
                if (cp) {
                    [arr addObject:cp];
                }
            }];
        }

        if (code == 0) {
            success(operation,arr);
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

-(void)newsAllWithUserid:(NSString *)userid
                    page:(NSNumber *)page
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:page forKey:@"page"];
    
    [_HTTPEngine POST:kPathOfNewsAll parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSArray *data = result[@"data"];
        
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        if ([data isKindOfClass:[NSArray class]]&&[data count]>0){
        
            [data enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                PDModelNews *news = [PDModelNews objectWithJoy:obj];
                if (news) {
                    [arr addObject:news];
                }
            }];
        }

        if (code == 0) {
            success(operation,arr);
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

-(void)newsDetailWithUserid:(NSString *)userid
                    news_id:(NSString *)news_id
                    success:(void (^)(AFHTTPRequestOperation *operation, PDModelNews *newsDetail))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:news_id forKey:@"news_id"];
    
    [_HTTPEngine POST:kPathOfNewsDetail parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
    
        if (code == 0) {
            PDModelNews *news = [PDModelNews objectWithJoy:data];
            success(operation,news);
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

-(void)newsDelWithUserid:(NSString *)userid
                 news_id:(NSString *)news_id
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:news_id forKey:@"news_id"];
    
    [_HTTPEngine POST:kPathOfNewsDel parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];

        if (code == 0) {
            success(operation,data);
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

// 赞消息
-(void)newsLikeWithUserid:(NSString *)userid
                  news_id:(NSString *)news_id
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:userid forKey:@"userid"];
    [parameters setObject:news_id forKey:@"news_id"];
    
    [_HTTPEngine POST:kPathOfNewsLike parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        long code = [result[@"code"] intValue];
        NSString *msg = result[@"msg"];
        NSDictionary *data = result[@"data"];
        
        if (code == 0) {
            success(operation,data);
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

@end

