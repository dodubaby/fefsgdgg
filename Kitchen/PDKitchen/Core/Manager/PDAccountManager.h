//
//  PDAccountManager.h
//  PDKitchen
//
//  Created by bright on 15/1/11.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDAccountManager : NSObject

@property(nonatomic,strong) NSString *userid; // 用户id

@property (nonatomic,assign,readonly) BOOL isLogined; // 是否已经登陆

@property (nonatomic,strong) NSNumber *coupon_count; //
@property (nonatomic,strong) NSNumber *news_count;   // 消息数量

+ (PDAccountManager *)sharedInstance;

// 清理数据
-(void)cleanup;

@end
