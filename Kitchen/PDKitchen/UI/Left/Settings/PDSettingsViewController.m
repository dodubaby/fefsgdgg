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

    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(10, 64+10, kAppWidth - 2*10, 250)];
    [self.view addSubview:back];
    back.layer.borderWidth = 0.5f;
    back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"st_logo"]];
    logo.frame = CGRectMake((kAppWidth - logo.width)/2.0f, back.top+50, logo.width, logo.height);
    [self.view addSubview:logo];
    
    version = [[UILabel alloc] initWithFrame:CGRectMake((kAppWidth - 200)/2.0f, 200, 200, 40)];
    [self.view addSubview:version];
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = [UIColor colorWithHexString:@"#666666"];
    version.font = [UIFont systemFontOfSize:18];
    
    phone = [[UIButton alloc] initWithFrame:CGRectMake((kAppWidth - 200)/2.0f, 240, 200, 40)];
    [self.view addSubview:phone];
    phone.titleLabel.font = [UIFont systemFontOfSize:15];
    [phone setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [phone setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [phone handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"拨打客服电话？" message:kPDPhoneNumber delegate:nil cancelButtonTitle:nil otherButtonTitles:@"拨打",@"取消", nil];
        
        [alert showWithClickedBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 0:
                    //
                {
                    NSLog(@"拨打");
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",kPDPhoneNumber]]];
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
    
    checkVersion = [[UIButton alloc] initWithFrame:CGRectMake((kAppWidth - 40)/2.0f, 280, 40, 40)];
    [self.view addSubview:checkVersion];
    [checkVersion setImage:[UIImage imageNamed:@"st_refresh"] forState:UIControlStateNormal];
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
    
    logout = [[UIButton alloc] initWithFrame:CGRectMake(10, back.bottom + 10, (kAppWidth- 2*10), 50)];
    [self.view addSubview:logout];
    logout.layer.borderWidth = 0.5f;
    logout.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logout handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        
    }];
}

-(void)configData{

    version.text = [NSString stringWithFormat:@"庖丁美食 %@", kPDAppVersion];
    [phone setTitle:[NSString stringWithFormat:@"客服电话：%@", kPDPhoneNumber]
           forState:UIControlStateNormal];
    
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    
    //[self.view showDebugRect];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupBackButton];
    [self setupUI];
    [self configData];
}


@end
