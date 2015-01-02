//
//  AppDelegate.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "AppDelegate.h"
#import "PDLoginViewController.h"
#import "PDMainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:nil options:nil];
    UIView *lanchScreen=[nibView objectAtIndex:0];
    lanchScreen.backgroundColor=[UIColor redColor];
    
    PDLoginViewController *controller=[[PDLoginViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.barTintColor=[UIColor whiteColor];
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
    
    return YES;
}

-(void)changetoLoginViewController
{
    PDLoginViewController *controller=[[PDLoginViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.barTintColor=[UIColor whiteColor];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
}
-(void)changetoMainViewController
{
    PDMainViewController *controller=[[PDMainViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:controller];
    nav.navigationBar.barTintColor=[UIColor whiteColor];
    _window.rootViewController = nav;
    [_window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
