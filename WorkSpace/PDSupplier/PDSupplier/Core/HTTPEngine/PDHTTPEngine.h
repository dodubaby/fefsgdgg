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
//发送验证码
#define kPathOfSendverification @"kitchen/sendverification"
//注册或者找回密码
#define kPathOfRegister @"kitchen/register"
//今日订单
#define kPathOfToday @"kitchenorder/today"
//确认订单
#define kPathOfConfirm @"kitchenorder/confirm"
//完成订单
#define kPathOfFinish @"kitchenorder/finish"
//确认退款
#define kPathOfRefund @"kitchenorder/refund"
//订单查询
#define kPathOfSearch @"kitchenorder/search"
//全部订单
#define kPathOfAll @"kitchenorder/all"


@interface PDHTTPEngine : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *HTTPEngine;

+ (PDHTTPEngine *)sharedInstance;

// 包含默认参数. md5(path + 排序keyvalue组合 + password)
- (NSString *)signWithPath:(NSString *)path params:(NSMutableDictionary *)params password:(NSString *) password;
/**
 *  获取验证码
 *
 *  @param phone   电话号码
 *  @param success
 *  @param failure
 */
-(void)sendverificationWithphone:(NSString *)phone
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  注册和忘记密码接口
 *
 *  @param phone        电话号码
 *  @param verification 验证码
 *  @param password     密码
 *  @param success
 *  @param failure
 */
-(void)registerWithphone:(NSString *)phone
            verification:(NSString*)verification
                password:(NSString *)password
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  登录接口
 *
 *  @param phone    电话号码
 *  @param password 密码
 *  @param success
 *  @param failure
 */
-(void)loginWithphone:(NSString *)phone
             password:(NSString *)password
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  今日订单
 *
 *  @param kitchenid 餐厅唯一标识符
 *  @param type      上下午订单；1，上午、2，下午
 *  @param page      分页，从0开始；可以不填，默认为0；
 *  @param success
 *  @param failure
 */
-(void)getTodayOrderWithKitchenid:(NSString*)kitchenid
                             type:(NSInteger)type
                             page:(NSInteger)page
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  确认订单
 *
 *  @param kitchenid 餐厅id
 *  @param orderid   订单id
 *  @param success
 *  @param failure
 */
-(void)confirmOrderWithKitchenid:(NSString*)kitchenid
                         orderid:(NSInteger)orderid
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  完成订单
 *
 *  @param kitchenid 餐厅id
 *  @param orderid   订单id
 *  @param success
 *  @param failure
 */
-(void)finishOrderWithKitchenid:(NSString*)kitchenid
                        orderid:(NSInteger)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  取消订单
 *
 *  @param kitchenid 餐厅id
 *  @param orderid   订单id
 *  @param success
 *  @param failure
 */
-(void)refundOrderWithKitchenid:(NSString*)kitchenid
                        orderid:(NSInteger)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 * 搜索订单
 *
 *  @param kitchenid 餐厅id
 *  @param type      1，配送的订单、2，退款的订单; 默认为1（配送订单）
 *  @param phone     手机号码，后4位即可，也可输入全部手机号码。
 *  @param page      分页
 *  @param success
 *  @param failure
 */
-(void)searchOrderWithKitchenid:(NSString*)kitchenid
                           type:(NSInteger)type
                          phone:(NSString*)phone
                           page:(NSInteger)page
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
/**
 *  所有订单
 *
 *  @param kitchenid  餐厅id
 *  @param start_date 起始时间
 *  @param end_date   结束时间
 *  @param page       分页
 *  @param success
 *  @param failure
 */
-(void)allOrderWithKitchenid:(NSString*)kitchenid
                  start_date:(NSString*)start_date
                    end_date:(NSString*)end_date
                        page:(NSInteger)page
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;





@end
