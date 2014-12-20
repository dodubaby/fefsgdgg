//
//  AppDelegate.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"
#import "PDCenterViewController.h"
#import "PDLeftViewController.h"
#import "PDRightViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
//zdf add

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    UIViewController * leftSideDrawerViewController = [[PDLeftViewController alloc] init];
    
    UIViewController * centerViewController = [[PDCenterViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UIViewController * rightSideDrawerViewController = [[PDRightViewController alloc] init];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]
                                             initWithCenterViewController:navigationController
                                             leftDrawerViewController:leftSideDrawerViewController
                                             rightDrawerViewController:rightSideDrawerViewController];
    [drawerController setMaximumRightDrawerWidth:kAppWidth*2/3.0f];
    [drawerController setMaximumLeftDrawerWidth:kAppWidth*2/3.0f];
    
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    [drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         
         MMExampleDrawerVisualStateManager *manager =  [MMExampleDrawerVisualStateManager sharedManager];
         manager.leftDrawerAnimationType = MMDrawerAnimationTypeNone;
         manager.rightDrawerAnimationType = MMDrawerAnimationTypeNone;
         
         block = [manager drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    
    
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor redColor];
    _window.rootViewController = drawerController;
    [_window makeKeyAndVisible];
    
    
    return YES;
}

@end
