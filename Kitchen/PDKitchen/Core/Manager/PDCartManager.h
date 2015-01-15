//
//  PDCartManager.h
//  PDKitchen
//
//  Created by bright on 15/1/15.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PDModelFood.h"

/*
 * 购物车管理
 */

@interface PDCartManager : NSObject
{

}

@property (nonatomic,strong) NSMutableArray *cartList;

+ (PDCartManager *)sharedInstance;

-(void)addFood:(PDModelFood *)food;
-(void)removeFood:(PDModelFood *)food;

-(void)clear;

@end
