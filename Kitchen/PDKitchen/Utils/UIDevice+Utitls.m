//
//  UIDevice+Utitls.m
//  PDKitchen
//
//  Created by bright on 15/1/4.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "UIDevice+Utitls.h"
#import "Lockbox.h"

@implementation UIDevice(Utitls)

-(NSString *)deviceKeychanID{
    static dispatch_once_t once;
    static NSString * __keychanID = nil;
    dispatch_once( &once, ^{
        Lockbox *box = [[Lockbox alloc] init];
        __keychanID = [box stringForKey:@"device_keychan_id"];
        if (!__keychanID) {
            __keychanID = [[NSUUID UUID] UUIDString];
            [box setString:__keychanID forKey:@"device_keychan_id"];
        }
    });
    return __keychanID;
}

@end
