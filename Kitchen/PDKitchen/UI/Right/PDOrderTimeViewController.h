//
//  PDOrderTimeViewController.h
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDBaseTableViewController.h"

@protocol PDOrderTimeViewControllerDelegate;
@interface PDOrderTimeViewController : PDBaseTableViewController

@property (nonatomic,weak) id<PDOrderTimeViewControllerDelegate> selectDelegete;

@end


@protocol PDOrderTimeViewControllerDelegate <NSObject>

-(void)pdOrderTimeViewController:(UIViewController *)vc
                   didSelectTime:(NSDate *)time
                     displayTime:(NSString *)displayTime;

@end
