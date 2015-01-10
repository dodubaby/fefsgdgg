//
//  PDMainViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDMainViewController.h"
#import "PDTodayOrderTableViewController.h"
#import "PDOrderInquiryTableViewController.h"
#import "PDSettingsViewController.h"


@interface PDMainViewController ()
{
    UIButton *todayBtn;
    UIButton *orderInquiryBtn;
    UIButton *settingBtn;
    
    UIImageView *todayImg;
    UIImageView *searchImg;
    UIImageView *setImg;
    
}
@end

@implementation PDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *navimgview=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    navimgview.image=[UIImage imageNamed:@"nav"];
    self.navigationItem.titleView=navimgview;
    
    todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(kGap, 64+kGap*2, kAppWidth-kGap*2, 100)];
    todayBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:todayBtn];
    todayBtn.layer.cornerRadius = 0;
    todayBtn.layer.masksToBounds = YES;
    todayBtn.layer.borderWidth = 1;
    todayBtn.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
    [todayBtn setTitle:@"         今日订单" forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor colorWithHexString:kAppRedColor] forState:UIControlStateNormal];
    [todayBtn.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [todayBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDTodayOrderTableViewController *vc=[[PDTodayOrderTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    todayImg=[[UIImageView alloc] initWithFrame:CGRectMake(100, 75.0f/2, 25, 25)];
    todayImg.image=[UIImage imageNamed:@"订单"];
    [todayBtn addSubview:todayImg];
    
    orderInquiryBtn = [[UIButton alloc] initWithFrame:CGRectMake(todayBtn.left, todayBtn.bottom+kGap, kAppWidth-kGap*2, 100)];
    orderInquiryBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:orderInquiryBtn];
    orderInquiryBtn.layer.cornerRadius = 0;
    orderInquiryBtn.layer.masksToBounds = YES;
    orderInquiryBtn.layer.borderWidth = 1;
    orderInquiryBtn.layer.borderColor = [[UIColor colorWithHexString:kAppLineColor] CGColor];
    [orderInquiryBtn setTitle:@"         订单查询" forState:UIControlStateNormal];
    [orderInquiryBtn setTitleColor:[UIColor colorWithHexString:kAppTitleColor] forState:UIControlStateNormal];
    [orderInquiryBtn.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [orderInquiryBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDOrderInquiryTableViewController *vc=[[PDOrderInquiryTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    searchImg=[[UIImageView alloc] initWithFrame:CGRectMake(100, 75.0f/2, 25, 25)];
    searchImg.image=[UIImage imageNamed:@"搜索"];
    [orderInquiryBtn addSubview:searchImg];
    
    
    settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(kGap, kAppHeight-50-kGap, kAppWidth-kGap*2, 50)];
    settingBtn.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:settingBtn];
    settingBtn.layer.cornerRadius = 0;
    settingBtn.layer.masksToBounds = YES;
    settingBtn.layer.borderWidth = 1;
    settingBtn.layer.borderColor = [[UIColor colorWithHexString:kAppLineColor] CGColor];
    [settingBtn setTitle:@"     设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor colorWithHexString:kAppTitleColor] forState:UIControlStateNormal];
    [settingBtn.titleLabel setFont:[UIFont systemFontOfSize:kAppBtnSize]];
    [settingBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDSettingsViewController *vc=[[PDSettingsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    setImg=[[UIImageView alloc] initWithFrame:CGRectMake(110, 25.0f/2, 25, 25)];
    setImg.image=[UIImage imageNamed:@"设置"];
    [settingBtn addSubview:setImg];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
