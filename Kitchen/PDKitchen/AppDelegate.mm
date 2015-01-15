//
//  AppDelegate.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "PDCenterViewController.h"
#import "PDLeftViewController.h"
#import "PDRightViewController.h"

#import "LoveTopTipView.h"

@interface AppDelegate ()<TencentSessionDelegate>
{
    TencentOAuth *tencentOAuth;
}

@property (nonatomic,assign) MMPanDisableSide savedPanDisableSide; // 缓存状态

@end

@implementation AppDelegate
//zdf add 111

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    NSString *device = [[UIDevice currentDevice] deviceKeychanID];
    NSLog(@"device == %@",device);
    
    //向微信注册
    [WXApi registerApp:kWeixinAppID withDescription:@"demo 2.0"];
    
    // 微博
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kWeiboAppKey];
    
    // QQ
    NSString *appid = kQQAppID;
    tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
                                           andDelegate:self];
    
    // 登录页面
    _loginViewController = [[PDLoginViewController alloc] init];
    
    
    UIViewController * leftSideDrawerViewController = [[PDLeftViewController alloc] init];
    
    UIViewController * centerViewController = [[PDCenterViewController alloc] init];
    
    UIViewController * rightSideDrawerViewController = [[PDRightViewController alloc] init];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    
    _drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navigationController
                                             leftDrawerViewController:leftSideDrawerViewController
                                             rightDrawerViewController:rightSideDrawerViewController];
    [_drawerController setMaximumRightDrawerWidth:255];
    [_drawerController setMaximumLeftDrawerWidth:165];
    [_drawerController setShowsShadow:NO];
    [_drawerController setShouldStretchDrawer:NO];
    
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [_drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         
         MMExampleDrawerVisualStateManager *manager =  [MMExampleDrawerVisualStateManager sharedManager];
         manager.leftDrawerAnimationType = MMDrawerAnimationTypeNone;
         manager.rightDrawerAnimationType = MMDrawerAnimationTypeNone;
         
         block = [manager drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = _drawerController;
    [_window makeKeyAndVisible];
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:kShowLoginNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [self showLogin];
        
    }];
    
    return YES;
}

-(void)showLogin{
    
    // 缓存状态
    _savedPanDisableSide =_drawerController.panDisableSide;
    // 禁止滑动
    [_drawerController setPanDisableSide:MMPanDisableSideBoth];
    
    _loginNavViewController = [[UINavigationController alloc] initWithRootViewController:_loginViewController];

    [_window.rootViewController addChildViewController:_loginNavViewController];
    [_window.rootViewController.view addSubview:_loginNavViewController.view];
    
    _loginNavViewController.view.top = kAppHeight;
    
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    [UIView animateWithDuration:0.3 animations:^{
        _loginNavViewController.view.top = 0;
    } completion:^(BOOL finished) {
        
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    }];
}

- (void)removeLogin{

    // 还原状态
    [_drawerController setPanDisableSide:_savedPanDisableSide];
    
    _loginNavViewController.view.top = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        _loginNavViewController.view.top = kAppHeight-20;
    } completion:^(BOOL finished) {
        [_loginNavViewController removeFromParentViewController];
        [_loginNavViewController.view removeFromSuperview];
    }];
}

-(void)loginWeixin{
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"xxx";
    req.openID = @"0c806938e2413ce73eef92cc3";
    [WXApi sendAuthReq:req viewController:_window.rootViewController delegate:self];
}

-(void)loginWeixinWithviewController:(UIViewController *) vc{

    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact"; // @"post_timeline,sns"
    req.state = @"xxx";
    req.openID = @"0c806938e2413ce73eef92cc3";
    [WXApi sendAuthReq:req viewController:vc delegate:self];
}

- (void) sendWeixinWithThumbImage:(UIImage *)image title:(NSString *)title description:(NSString *)description webpageUrl:(NSString *)webpageUrl  scene:(enum WXScene)scene
{
    //发送内容给微信
    WXMediaMessage *message = [WXMediaMessage message];
    [message setThumbImage:image];
    message.title = title;
    message.description = description;
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = webpageUrl;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    [WXApi sendReq:req];
}

-(void) onReq:(BaseReq*)req{


    
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendAuthResp class]]){
    
        SendAuthResp *temp = (SendAuthResp*)resp;
        
        NSString *strTitle = [NSString stringWithFormat:@"Auth结果"];
        NSString *strMsg = [NSString stringWithFormat:@"code:%@,state:%@,errcode:%d", temp.code, temp.state, temp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        switch (resp.errCode) {
            case WXSuccess:
                //
                [[LoveTopTipView shareInstance] showMessage:@"微信分享成功"];
                break;
            case WXErrCodeUserCancel:
                //
                [[LoveTopTipView shareInstance] showMessage:@"微信分享取消"];
                break;
            default:
                [[LoveTopTipView shareInstance] showMessage:@"微信分享失败"];
                break;
        }
        
    }
}

// weibo
- (void)loginWeibo
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kWeiboRedirectURI;
    request.scope = @"all";
    request.userInfo = @{@"SSO_From": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    
    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

- (void)shareButtonPressed
{

}

-(void)weiboShare:(WBMessageObject *)message{
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kWeiboRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message
                                                                                  authInfo:authRequest
                                                                              access_token:self.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    //    request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

// 文本
-(WBMessageObject *)weiboMessageWithText:(NSString *)text{
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    return message;
}

// 图片
-(WBMessageObject *)weiboMessageWithImageData:(NSData *)imageData{
    WBMessageObject *message = [WBMessageObject message];
    WBImageObject *image = [WBImageObject object];
    image.imageData = imageData;
    message.imageObject = image;
    return message;
}

/*
// 网页
-(WBMessageObject *)weiboMessageWithText:(NSString *)text{
    WBMessageObject *message = [WBMessageObject message];
    message.text = text;
    return message;
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    if (self.textSwitch.on)
    {
        message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    }
    
    if (self.imageSwitch.on)
    {
        WBImageObject *image = [WBImageObject object];
        image.imageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
        message.imageObject = image;
    }
    
    if (self.mediaSwitch.on)
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = NSLocalizedString(@"分享网页标题", nil);
        webpage.description = [NSString stringWithFormat:NSLocalizedString(@"分享网页内容简介-%.0f", nil), [[NSDate date] timeIntervalSince1970]];
        webpage.thumbnailData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_2" ofType:@"jpg"]];
        webpage.webpageUrl = @"http://sina.cn?a=1";
        message.mediaObject = webpage;
    }
    
    return message;
}
*/

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            self.wbtoken = accessToken;
            
           
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            self.wbCurrentUserID = userID;
        }
        [alert show];
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        
        // 授权过期日期
        WBAuthorizeResponse *authorizeResponse = (WBAuthorizeResponse *)response;
        self.wbExpirationDate =  authorizeResponse.expirationDate;
        
        
        [alert show];
        
        // 登录成功
        if (response.statusCode == 0) {
             [self removeLogin];
        }

    }
    else if ([response isKindOfClass:WBPaymentResponse.class])
    {
        NSString *title = NSLocalizedString(@"支付结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];

    }
}


-(void)loginQQ{

   NSArray *permissions = [NSArray arrayWithObjects:
                   kOPEN_PERMISSION_GET_USER_INFO,
                   kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                   kOPEN_PERMISSION_ADD_ALBUM,
                   kOPEN_PERMISSION_ADD_IDOL,
                   kOPEN_PERMISSION_ADD_ONE_BLOG,
                   kOPEN_PERMISSION_ADD_PIC_T,
                   kOPEN_PERMISSION_ADD_SHARE,
                   kOPEN_PERMISSION_ADD_TOPIC,
                   kOPEN_PERMISSION_CHECK_PAGE_FANS,
                   kOPEN_PERMISSION_DEL_IDOL,
                   kOPEN_PERMISSION_DEL_T,
                   kOPEN_PERMISSION_GET_FANSLIST,
                   kOPEN_PERMISSION_GET_IDOLLIST,
                   kOPEN_PERMISSION_GET_INFO,
                   kOPEN_PERMISSION_GET_OTHER_INFO,
                   kOPEN_PERMISSION_GET_REPOST_LIST,
                   kOPEN_PERMISSION_LIST_ALBUM,
                   kOPEN_PERMISSION_UPLOAD_PIC,
                   kOPEN_PERMISSION_GET_VIP_INFO,
                   kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                   kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                   kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                   nil];
    
    [tencentOAuth authorize:permissions inSafari:NO];
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{

    NSLog(@"tencentDidLogin");
    
    NSLog(@"accessToken %@",tencentOAuth.accessToken);
    NSLog(@"expirationDate %@",tencentOAuth.expirationDate);
    NSLog(@"openId %@",tencentOAuth.openId);
    
    [self removeLogin];
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{

    NSLog(@"tencentDidNotLogin");
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{

    NSLog(@"tencentDidNotNetWork");
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [TencentOAuth HandleOpenURL:url];
    [WXApi handleOpenURL:url delegate:self];
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [TencentOAuth HandleOpenURL:url];
    [WXApi handleOpenURL:url delegate:self];
    return [WeiboSDK handleOpenURL:url delegate:self ];
}

@end
