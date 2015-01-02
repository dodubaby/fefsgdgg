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

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 26, 40);
    [button setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    UILabel *ttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, 44)];
    ttitle.text=@"设置";
    ttitle.font=[UIFont systemFontOfSize:kAppFontSize];
    ttitle.textColor=[UIColor colorWithHexString:kAppNormalColor];
    ttitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=ttitle;
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(10, 64+20, kAppWidth - 2*10, 250)];
    [self.view addSubview:back];
    back.layer.borderWidth = 0.5f;
    back.layer.borderColor = [[UIColor colorWithHexString:@"0xe6e6e6"] CGColor];
    
    // logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    logo.frame = CGRectMake((kAppWidth - 45)/2.0f, back.top+50, 45, 50);
    [self.view addSubview:logo];
    
    version = [[UILabel alloc] initWithFrame:CGRectMake((kAppWidth - 200)/2.0f, 200, 200, 40)];
    [self.view addSubview:version];
    version.textAlignment = NSTextAlignmentCenter;
    version.textColor = [UIColor colorWithHexString:@"0x666666"];
    version.font = [UIFont systemFontOfSize:18];
    
    phone = [[UIButton alloc] initWithFrame:CGRectMake((kAppWidth - 200)/2.0f, 240, 200, 40)];
    [self.view addSubview:phone];
    phone.titleLabel.font = [UIFont systemFontOfSize:15];
    [phone setTitleColor:[UIColor colorWithHexString:@"0x999999"] forState:UIControlStateNormal];
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
    logout.layer.borderColor = [[UIColor colorWithHexString:@"0xe6e6e6"] CGColor];
    [logout setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logout handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        AppDelegate *app=[[UIApplication sharedApplication] delegate];
        [app changetoLoginViewController];
    }];
}
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)configData{
    NSString *versionstr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    version.text = [NSString stringWithFormat:@"庖丁美食 %@",versionstr];
    [phone setTitle:[NSString stringWithFormat:@"客服电话：%@", kPDPhoneNumber]
           forState:UIControlStateNormal];
    
    [logout setTitle:@"退出" forState:UIControlStateNormal];
    
    //[self.view showDebugRect];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self configData];
}


@end
