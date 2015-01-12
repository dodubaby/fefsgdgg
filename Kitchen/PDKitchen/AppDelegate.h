//
//  AppDelegate.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDConfig.h"

#import "PDLoginViewController.h"

#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/sdkdef.h>

////com.sina.weibo.SNWeiboSDKDemo info里面对应包名
#define kWeiboAppKey         @"2045436852"
#define kWeiboRedirectURI    @"http://www.sina.com"

#define kWeixinAppID         @"wxd930ea5d5a258f4f"

#define kQQAppID             @"222222";

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate,WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)  MMDrawerController * drawerController;

@property (nonatomic,strong) PDLoginViewController *loginViewController;
@property (nonatomic,strong) UINavigationController *loginNavViewController;

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;
@property (strong, nonatomic) NSDate   *wbExpirationDate; // 授权过期日期


- (void)showLogin;
- (void)removeLogin;

-(void)loginWeibo;

-(void)loginWeixin;
-(void)loginWeixinWithviewController:(UIViewController *) vc;

-(void)loginQQ;

@end

