//
//  AppDelegate.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXApi.h"
#import "WeiboSDK.h"

////com.sina.weibo.SNWeiboSDKDemo info里面对应包名
#define kWeiboAppKey         @"2045436852"
#define kWeiboRedirectURI    @"http://www.sina.com"

#define kWeixinAppID         @"wxd930ea5d5a258f4f"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@property (strong, nonatomic) NSDate   *wbExpirationDate; // 授权过期日期
-(void)loginWeibo;

-(void)loginWeixin;
-(void)loginWeixinWithviewController:(UIViewController *) vc;
@end

