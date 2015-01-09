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

-(void)loginWithType:(NSNumber *)type
               phone:(NSString *)phone
             account:(NSString *)thirdpartID
        verification:(NSString *)verification
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
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
    
    parameters = [self paramWithDictionary:parameters];

    [_HTTPEngine POST:kPathOfLogin parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        int code = [result[@"Header"][@"Code"] intValue];
        NSString *msg = result[@"Header"][@"Message"];
        if (code == 200) {
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


- (void)operationFrameWithFrameID:(NSString *)FrameID
                         devideID:(NSString *)DeviceID
                             name:(NSString *)Name
                           action:(NSString *)Action
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:FrameID forKey:@"FrameID"];
    [parameters setObject:DeviceID forKey:@"DeviceID"];
    [parameters setObject:Name forKey:@"Name"];
    [parameters setObject:Action forKey:@"Action"];
    
    [_HTTPEngine POST:@"" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        
        
        PDBaseModel *model = [PDBaseModel objectWithJoy:responseObject];
        
        
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"result   %@",result);
        
        int code = [result[@"Header"][@"Code"] intValue];
        NSString *msg = result[@"Header"][@"Message"];
        if (code == 200) {
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


@end
