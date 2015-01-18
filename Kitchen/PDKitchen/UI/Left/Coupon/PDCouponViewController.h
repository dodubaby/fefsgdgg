//
//  PDCouponViewController.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseTableViewController.h"

@protocol PDCouponViewControllerDelegate;
@interface PDCouponViewController : PDBaseTableViewController

@property (nonatomic,weak) id<PDCouponViewControllerDelegate> selectDelegate;

@property (nonatomic,assign) BOOL isForOrder;

@end


@protocol PDCouponViewControllerDelegate <NSObject>

-(void)pdCouponViewController:(UIViewController *)vc didSelectCoupon:(PDModelCoupon *)coupon;

@end