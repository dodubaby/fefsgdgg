//
//  PDOrderManager.m
//  PDKitchen
//
//  Created by bright on 15/1/15.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderManager.h"

@implementation PDOrderManager

+(PDOrderManager *)sharedInstance{
    static dispatch_once_t once;
    static PDOrderManager * __singleton = nil;
    dispatch_once( &once, ^{ __singleton = [[PDOrderManager alloc] init]; } );
    return __singleton;
}

@end
