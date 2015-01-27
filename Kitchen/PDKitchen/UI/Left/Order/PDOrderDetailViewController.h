//
//  PDOrderDetailViewController.h
//  PDKitchen
//
//  Created by bright on 14/12/20.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseViewController.h"

@interface PDOrderDetailViewController : PDBaseViewController

@property(nonatomic,strong) NSString *orderid;


@property (nonatomic,assign) BOOL isForSubmit; // 提交订单进入

@end
