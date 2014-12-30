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

    self.view.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
    
    list = [[NSMutableArray alloc] initWithObjects:
            @{@"我的订单":@"menu_order"},
            @{@"我的收藏":@"menu_favorite"},
            @{@"我的优惠券":@"menu_coupon"},
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
        cell.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, leftTableView.width - 10, 1.0)];
        [cell addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        line.tag = 111;
    }
    
    UIImageView *line = (UIImageView *)[cell viewWithTag:111];
    if (indexPath.row == 0) { // 第一个没有线
        line.hidden = YES;
    }else{
        line.hidden = NO;
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
            
            
            if (1) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kShowLoginNotificationKey object:nil];
            }else{
            
                vc = [PDOrderViewController new];
                vc.title = key;
                [self pushVC:vc];

            }
            
        }
            break;
        case 1:
            //
        {
            vc = [PDFavoritesViewController new];
            vc.title = key;
            [self pushVC:vc];
            
        }
            break;
        case 2:
            //
        {
            
            vc = [PDCouponViewController new];
            vc.title = key;
            [self pushVC:vc];
        }
            break;
        case 3:
            //
        {
            vc = [PDNewsViewController new];
            vc.title = key;
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
            vc.title = key;
            [self pushVC:vc];
        }
            break;
        default:
            break;
    }
}

@end
