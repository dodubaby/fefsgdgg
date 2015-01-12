//
//  PDBaseViewController.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDUtils.h"
#import "SVProgressHUD.h"
#import "SVPullToRefresh.h"
#import "PDHTTPEngine.h"
#import "UIViewController+MMDrawerController.h"

@interface PDBaseViewController : UIViewController

-(void)backButtonTaped:(id)sender;
-(void)setupBackButton;

// 登陆
-(BOOL)userLogined;

@end
