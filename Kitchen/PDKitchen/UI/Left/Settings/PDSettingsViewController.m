//
//  PDSettingsViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDSettingsViewController.h"

@interface PDSettingsViewController ()
{

    UILabel *version;
    UIButton *phone;
    
    UIButton *checkVersion;
    UIButton *logout;
}

@end

@implementation PDSettingsViewController


-(void)setupUI{


    version = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, kAppWidth, 40)];
    [self.view addSubview:version];
    version.textAlignment = NSTextAlignmentCenter;
    
    
    phone = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, kAppWidth, 40)];
    [self.view addSubview:phone];
    [phone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phone handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打客服电话？" message:@"123456789" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"拨打",@"取消", nil];
        
        [alert showWithClickedBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 0:
                    //
                {
                    NSLog(@"拨打");
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://123456"]];
                }
                    
                    break;
                case 1:
                    //
                {
                    NSLog(@"取消");
                    
                }
                    break;
                default:
                    break;
            }
        }];
    }];
    
    checkVersion = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, kAppWidth, 40)];
    [self.view addSubview:checkVersion];
    [checkVersion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkVersion handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"有新版本" message:@"描述：xxx版" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"立即更新",@"稍后更新", nil];
        
        [alert showWithClickedBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 0:
                    //
                {
                    NSLog(@"立即更新");
                }
                    
                    break;
                case 1:
                    //
                {
                    NSLog(@"稍后更新");
                
                }
                    break;
                default:
                    break;
            }
        }];
        
    }];
    
    logout = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, kAppWidth, 40)];
    [self.view addSubview:logout];
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logout handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
    }];
    
}

-(void)configData{

    version.text = @"version";
    
    [phone setTitle:@"phone" forState:UIControlStateNormal];
    
    [checkVersion setTitle:@"checkVersion" forState:UIControlStateNormal];
    
    [logout setTitle:@"logout" forState:UIControlStateNormal];
    
    [self.view showDebugRect];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self configData];
}


@end
