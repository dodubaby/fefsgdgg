//
//  PDLeftViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDLeftViewController.h"
#import "DemoViewController.h"
#import "PDFavoritesViewController.h"
#import "PDCouponViewController.h"
#import "PDNewsViewController.h"
#import "PDSettingsViewController.h"

#import "PDBaseTableViewCell.h"


@interface PDLeftViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *leftTableView;
    
    NSMutableArray *list;
}

@end

@implementation PDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    list = [[NSMutableArray alloc] initWithObjects:
            @"我的订单",
            @"我的收藏",
            @"我的优惠券",
            @"消息",
            @"给我评分",
            @"设置", nil];
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(20, 120, kAppWidth*2/3.0f-2*20, list.count*44) style:UITableViewStylePlain];
    leftTableView.delegate = self;
    leftTableView.dataSource = self;
    [self.view addSubview:leftTableView];
}


-(void)pushVC:(UIViewController *)vc{

    UINavigationController *center = (UINavigationController *)self.mm_drawerController.centerViewController;
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
    }
    cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = nil;
    
    switch (indexPath.row) {
        case 0:
            //
        {
        
            
        }
            break;
        case 1:
            //
        {
            vc = [PDFavoritesViewController new];
            vc.title = list[indexPath.row];
            [self pushVC:vc];
            
        }
            break;
        case 2:
            //
        {
            
            vc = [PDCouponViewController new];
            vc.title = list[indexPath.row];
            [self pushVC:vc];
        }
            break;
        case 3:
            //
        {
            vc = [PDNewsViewController new];
            vc.title = list[indexPath.row];
            [self pushVC:vc];
            
        }
            break;
        case 4:
            //
        {

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://baidu.com"]];
            
        }
            break;
        case 5:
            //
        {
            
            vc = [PDSettingsViewController new];
            vc.title = list[indexPath.row];
            [self pushVC:vc];
        }
            break;
        default:
            break;
    }
}

@end
