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
#import "PDSettingTableViewController.h"


@interface PDMainViewController ()
{
    UIButton *todayBtn;
    UIButton *orderInquiryBtn;
    UIButton *settingBtn;
}
@end

@implementation PDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    todayBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 150, 150)];
    todayBtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:todayBtn];
    [todayBtn setTitle:@"今日订单" forState:UIControlStateNormal];
    [todayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [todayBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDTodayOrderTableViewController *vc=[[PDTodayOrderTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    orderInquiryBtn = [[UIButton alloc] initWithFrame:CGRectMake(190, 100, 150, 150)];
    orderInquiryBtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:orderInquiryBtn];
    [orderInquiryBtn setTitle:@"订单查询" forState:UIControlStateNormal];
    [orderInquiryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [orderInquiryBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDOrderInquiryTableViewController *vc=[[PDOrderInquiryTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, 150, 150)];
    settingBtn.backgroundColor=[UIColor grayColor];
    [self.view addSubview:settingBtn];
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingBtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDSettingTableViewController *vc=[[PDSettingTableViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
