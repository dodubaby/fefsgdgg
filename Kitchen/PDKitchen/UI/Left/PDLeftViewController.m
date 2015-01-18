//
//  PDLeftViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDLeftViewController.h"
#import "DemoViewController.h"
#import "PDOrderViewController.h"
#import "PDFavoritesViewController.h"
#import "PDCouponViewController.h"
#import "PDAddressViewController.h"

#import "PDNewsViewController.h"
#import "PDSettingsViewController.h"

#import "PDBaseTableViewCell.h"

#import "PDAccountManager.h"

@interface PDLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
    
    NSMutableArray *list;
}

@end

@implementation PDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
    
    list = [[NSMutableArray alloc] initWithObjects:
            @{@"我的订单":@"menu_order"},
            @{@"我的收藏":@"menu_favorite"},
            @{@"我的优惠券":@"menu_coupon"},
            @{@"我的地址":@"menu_address"},
            @{@"消息":@"menu_news"},
            @{@"给我评分":@"menu_score"},
            @{@"设置":@"menu_settings"}, nil];
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, 165, list.count*50) style:UITableViewStylePlain];
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    leftTableView.rowHeight = 50.0f;
    [self.view addSubview:leftTableView];
    leftTableView.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
    
    
    // 新消息红点
    [[NSNotificationCenter defaultCenter] addObserverForName:kNewsHideNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [leftTableView reloadData];
    }];
}

-(void)pushVC:(UIViewController *)vc{

    UINavigationController *center = (UINavigationController *)self.mm_drawerController.centerViewController;
    [center popToRootViewControllerAnimated:NO];  // 先返回首页
    [center pushViewController:vc animated:NO];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, leftTableView.width - 10, 1.0)];
        [cell addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        line.tag = 111;
        
        //UIImageView *mark = [[UIImageView alloc] initWithFrame:CGRectMake(47, 12, 7, 7)];
        UIImageView *mark = [[UIImageView alloc] initWithFrame:CGRectMake(40, 16, 7, 7)];
        [cell addSubview:mark];
        mark.image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#fe8501"]];
        mark.layer.cornerRadius = 3.5f;
        mark.layer.masksToBounds = YES;
        mark.hidden = YES;
        mark.tag = 222;
    }
    
    UIImageView *line = (UIImageView *)[cell viewWithTag:111];
    if (indexPath.row == 0) { // 第一个没有线
        line.hidden = YES;
    }else{
        line.hidden = NO;
    }
    
    UIImageView *mark = (UIImageView *)[cell viewWithTag:222];
    if (indexPath.row == 2) { // 优惠券
        NSInteger coupon_count = [[PDAccountManager sharedInstance].coupon_count integerValue];
        mark.hidden = YES;
        if (coupon_count>0) {
            mark.hidden = NO;
        }
    }else if(indexPath.row == 4){ // 消息
        NSInteger news_count = [[PDAccountManager sharedInstance].news_count integerValue];
        mark.hidden = YES;
        if (news_count>0) {
            mark.hidden = NO;
        }
    }else{
        mark.hidden = YES;
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    NSDictionary *data = list[indexPath.row];
    NSString *key = data.allKeys[0];
    NSString *value = [data objectForKey:key];
    
    cell.imageView.image = [UIImage imageNamed:value];
    cell.textLabel.text = key;
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = nil;
    
    NSDictionary *data = list[indexPath.row];
    NSString *key = data.allKeys[0];
    
    switch (indexPath.row) {
        case 0:
            //
        {
            if ([self userLogined]) {
                vc = [PDOrderViewController new];
                vc.title = key;
                [self pushVC:vc];
            }

        }
            break;
        case 1:
            //
        {
            if ([self userLogined]) {
                vc = [PDFavoritesViewController new];
                vc.title = key;
                [self pushVC:vc];
            }
            
        }
            break;
        case 2:
            //
        {
            if ([self userLogined]) {
                vc = [PDCouponViewController new];
                vc.title = key;
                [self pushVC:vc];
            }
        }
            break;
        case 3:
            //
        {
            if ([self userLogined]) {
                vc = [PDAddressViewController new];
                vc.title = key;
                [self pushVC:vc];
            }
        }
            break;
        case 4:
            //
        {
            if ([self userLogined]) {
                vc = [PDNewsViewController new];
                vc.title = key;
                [self pushVC:vc];
            }
        }
            break;
        case 5:
            //
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://baidu.com"]];
            
        }
            break;
        case 6:
            //
        {
            vc = [PDSettingsViewController new];
            vc.title = key;
            [self pushVC:vc];
        }
            break;
        default:
            break;
    }
}

@end
