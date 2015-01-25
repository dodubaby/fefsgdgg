//
//  PDCartManager.m
//  PDKitchen
//
//  Created by bright on 15/1/15.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDUtils.h"
#import "PDCartManager.h"

#import "PDConfig.h"


@interface PDCartManager()
@property (nonatomic,strong) NSDate *lastAddTime;
@end

@implementation PDCartManager

+(PDCartManager *)sharedInstance{
    static dispatch_once_t once;
    static PDCartManager * __singleton = nil;
    dispatch_once( &once, ^{ __singleton = [[PDCartManager alloc] init]; } );
    return __singleton;
}

-(id)init{
    if (self = [super init]) {
        _cartList = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)notify{
    // 通知购物车更改
    [[NSNotificationCenter defaultCenter] postNotificationName:kCartModifyNotificationKey object:nil];
}

-(void)addFood:(PDModelFood *)food{
    
    if (!food) {
        return;
    }
    
    
    
    if (_lastAddTime) {
        
        NSInteger second = [_lastAddTime timeIntervalSinceNow];
    
        NSLog(@"%ld",second);
        
        // 大于半小时，提示清空
        if (second<= -60*30&&[_cartList count]>0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清空购物车"
                                                            message:@"你的购物车还有未购买菜品,是否清空？"
                                                           delegate:nil
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"清空", nil];
            
            [alert showWithClickedBlock:^(NSInteger buttonIndex) {
                switch (buttonIndex) {
                    case 0:
                    {
                        
                    }
                        break;
                    case 1:
                    {
                        [self clear];
                        return;
                    }
                        break;
                    default:
                        break;
                }
            }];
        }
    }
    
    BOOL exist = NO;
    
    for (PDModelFood *fd in _cartList) {
        if ([fd.food_id isEqualToString:food.food_id]) {
            exist = YES;
            NSInteger hasCount = [fd.count integerValue];
            hasCount += 1;
            fd.count = [NSNumber numberWithLong:hasCount];
            break;
        }
    }
    
    if (!exist) { // 原来没有的,添加一个
        
        food.count = [NSNumber numberWithLong:1];
        [_cartList addObject:food];
    }
    
    NSLog(@"_cartList == %@",_cartList);
    
    [self notify];
    
    _lastAddTime = [NSDate date];
}

-(void)removeFood:(PDModelFood *)food{

    if (!food) {
        return;
    }
    
    for (PDModelFood *fd in _cartList) {
        if ([fd.food_id isEqualToString:food.food_id]) {
            NSInteger hasCount = [fd.count integerValue];
            hasCount -= 1;
            
            if (hasCount == 0) {
                [_cartList removeObject:fd];
            }else{
                fd.count = [NSNumber numberWithLong:hasCount];
            }
            break;
        }
    }
    
    NSLog(@"_cartList == %@",_cartList);
    
    [self notify];
}

-(void)clear{
    [_cartList removeAllObjects];
    
    [self notify];
}

@end
