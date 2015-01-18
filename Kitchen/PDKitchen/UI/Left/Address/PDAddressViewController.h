//
//  PDAddressViewController.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseTableViewController.h"
#import "PDAddressDistrictViewController.h"

@protocol PDAddressViewControllerDelegate;

@interface PDAddressViewController : PDBaseTableViewController

@property (nonatomic,weak) id<PDAddressViewControllerDelegate> selectDelegete;
@property (nonatomic,assign) BOOL isForOrder;

@end


@protocol PDAddressViewControllerDelegate <NSObject>

-(void)pdAddressViewController:(UIViewController *)vc didSelectAddress:(PDModelAddress *)address;

@end