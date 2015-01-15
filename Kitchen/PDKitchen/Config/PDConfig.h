//
//  PDConfig.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#ifndef PDKitchen_PDConfig_h
#define PDKitchen_PDConfig_h

// 版本号
#define kPDAppVersion @"1.0"

// 电话
#define kPDPhoneNumber @"400-400-40000" 


#ifdef DEBUG

#define kHttpHost @"http://182.92.170.104/index.php"

#else

#define kHttpHost @"http://182.92.170.104/index.php"

#endif

// 登录通知
#define kShowLoginNotificationKey   @"ShowLoginNotificationKey"

// 购物车变化通知
#define kCartModifyNotificationKey  @"CartModifyNotificationKey"

// 隐藏新消息
#define kNewsHideNotificationKey    @"NewsHideNotificationKey"

#endif // PDKitchen_PDConfig_h
