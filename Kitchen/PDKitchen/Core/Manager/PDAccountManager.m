//
//  PDAccountManager.m
//  PDKitchen
//
//  Created by bright on 15/1/11.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDAccountManager.h"

@implementation PDAccountManager
+(PDAccountManager *)sharedInstance{
    static dispatch_once_t once;
    static PDAccountManager * __singleton = nil;
    dispatch_once( &once, ^{ __singleton = [[PDAccountManager alloc] init]; } );
    return __singleton;
}

-(BOOL)isLogined{

    if (_userid) {
        return YES;
    }
    return NO;
}

-(void)cleanup{
    _userid = nil;
    _coupon_count = nil;
    _news_count = nil;
}

@end
