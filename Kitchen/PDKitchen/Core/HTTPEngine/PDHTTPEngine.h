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

#import "PDAccountManager.h"
// API path

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 验证码
#define kPathOfSendVerification  @"/user/sendverification"
// 登录
#define kPathOfUserLogin         @"/user/login"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 首页
#define kPathOfAppHome           @"/app/home"
// 详情
#define kPathOfAppDetail         @"/app/detail"
// 点赞
#define kPathOfAppLike           @"/app/like"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 添加留言
#define kPathOfMessageAdd        @"/message/add"
// 留言列表
#define kPathOfMessageAll        @"/message/all"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 添加购物车
#define kPathOfCartAdd           @"/cart/add"
// 清空购物车
#define kPathOfCartDelete        @"/cart/delete"
// 我的购物车
#define kPathOfCartMyCart        @"/cart/mycart"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 提交订单
#define kPathOfOrderAdd          @"/order/add"
// 订单列表
#define kPathOfOrderMyOrder      @"/order/myorder"
// 物流动态
#define kPathOfOrderLogistics    @"/order/logistics"
// 订单详情
#define kPathOfOrderDetail       @"/order/detail"
// 退单
#define kPathOfOrderBack         @"/order/back"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 我的地址
#define kPathOfAddressMyAddress  @"/address/myaddress"
// 添加地址
#define kPathOfAddressAdd        @"/address/add"
// 编辑地址
#define kPathOfAddressEdit       @"/address/edit"
// 删除地址
#define kPathOfAddressDel        @"/address/del"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 我的收藏
#define kPathOfCollectMyCollect  @"/collect/mycollect"
// 添加收藏
#define kPathOfCollectAdd        @"/collect/add"
// 删除收藏
#define kPathOfCollectDelete     @"/collect/delete"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 我的优惠券
#define kPathOfCouponMyCoupon    @"/coupon/mycoupon"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 消息中心
#define kPathOfNewsAll           @"/news/all"
//消息详情
#define kPathOfNewsDetail        @"/news/detail"
// 删除消息
#define kPathOfNewsDel           @"/news/del"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@interface PDHTTPEngine : NSObject

@property (nonatomic,strong) AFHTTPRequestOperationManager *HTTPEngine;

+ (PDHTTPEngine *)sharedInstance;

// 包含默认参数. md5(path + 排序keyvalue组合 + password)
- (NSString *)signWithPath:(NSString *)path params:(NSMutableDictionary *)params password:(NSString *) password;

// 验证码
-(void)requestVerificationCodeWithPhone:(NSString *)phone
                                success:(void (^)(AFHTTPRequestOperation *operation, NSNumber *code))success
                                failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 登录 (type默认为1；1、手机登录，2、新浪微博，3，微信4、QQ)
-(void)loginWithType:(NSNumber *)type
               phone:(NSString *)phone
             account:(NSString *)thirdpartid
        verification:(NSNumber *)verification
             success:(void (^)(AFHTTPRequestOperation *operation, NSString *userid))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 首页列表
-(void)appHomeWithLocation:(NSString *)location
                      page:(NSNumber *)page
                   success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 详情
- (void)appDetailWithFoodID:(NSNumber *)foodid
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 点赞
- (void)appLikeWithUserid:(NSString *)userid
                   foodid:(NSNumber *)foodid
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 评论
- (void)messageAddwithUserid:(NSString *)userid
                      foodid:(NSNumber *)foodid
                    cookerid:(NSNumber *)cookerid
                        text:(NSString *)text
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 留言列表
-(void)messageAllWithFoodid:(NSNumber *)foodid
                       page:(NSNumber *)page
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 添加购物车 (foodids 选择购买的菜品及数量，如1*2**2*5，则为第一个厨房的第一个菜品买了两个，ID编号为2的菜品买了5个。)
-(void)cartAddWithUserid:(NSString *)userid
                 foodids:(NSString *)foodids
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 清空购物车
-(void)cartDeleteWithUserid:(NSString *)userid
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 我的购物车
-(void)cartMyCartWithUserid:(NSString *)userid
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/*
userid	string	Y	用户唯一标识码
food_ids	string	Y	选择购买的菜品及数量，如1*2**2*5，则为第一个菜品买了两个，ID编号为2的菜品买了5个。
address	int	Y	地址
phone	string	Y	联系电话
coupon_id	int	N	优惠券ID
eat_time	time	N	就餐时间，若选择立即送餐，则此项填空，后台进行判断。
注意：eat_time为时间戳格式。
message	string	N	个性化要求留言
sum_price	float	N	总共价格
*/
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
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 订单列表
-(void)orderMyOrderWithUserid:(NSString *)userid
                         page:(NSNumber *)page
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 物流动态
-(void)orderLogisticsWithUserid:(NSString *)userid
                         orderid:(NSNumber *)orderid
                      success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 订单详情
-(void)orderDetailWithUserid:(NSString *)userid
                        orderid:(NSNumber *)orderid
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 退单
-(void)orderBackWithUserid:(NSString *)userid
                     orderid:(NSNumber *)orderid
                     success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 我的地址
-(void)addressMyAddressWithUserid:(NSString *)userid
                             page:(NSNumber *)page
                          success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 添加地址
/*
userid	string	Y	用户编号
city_id	int	Y	城市ID
district_id	int	Y	区ID
address	string	Y	详细地址
phone	string	Y	联系电话
 */
-(void)addressAddWithUserid:(NSString *)userid
                    city_id:(NSNumber *)city_id
                district_id:(NSNumber *)district_id
                    address:(NSString *)address
                      phone:(NSString *)phone
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//  编辑地址
-(void)addressEditWithUserid:(NSString *)userid
                    city_id:(NSNumber *)city_id
                district_id:(NSNumber *)district_id
                    address:(NSString *)address
                      phone:(NSString *)phone
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//  删除地址
-(void)addressDelWithUserid:(NSString *)userid
                 address_id:(NSNumber *)address_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//  我的收藏
-(void)collectMyCollectWithUserid:(NSString *)userid
                             page:(NSNumber *)page
                          success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
//  添加收藏
-(void)collectAddWithUserid:(NSString *)userid
                             food_id:(NSNumber *)food_id
                          success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

//  删除收藏
-(void)collectDeleteWithUserid:(NSString *)userid
                    food_id:(NSNumber *)food_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 我的优惠券
-(void)couponMyCouponWithUserid:(NSString *)userid
                             page:(NSNumber *)page
                          success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

// 消息列表
-(void)newsAllWithUserid:(NSString *)userid
                           page:(NSNumber *)page
                        success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 消息详情
-(void)newsDetailWithUserid:(NSString *)userid
                    news_id:(NSNumber *)news_id
                 success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
// 删除消息
-(void)newsDelWithUserid:(NSString *)userid
                    news_id:(NSNumber *)news_id
                    success:(void (^)(AFHTTPRequestOperation *operation, NSArray *list))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
