//
//  PDCenterViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "PDCenterCell.h"

#import "PDCenterDetailViewController.h"


@interface PDCenterViewController ()<PDBaseTableViewCellDelegate>
{
    NSMutableArray *list;
}

@end

@implementation PDCenterViewController


- (void)setupData{

    list = [[NSMutableArray alloc] init];
    [list addObject:@"小炒肉"];
    [list addObject:@"小鸡炖蘑菇"];
    [list addObject:@"北京烤鸭"];
    
    //[self.navigationController.navigationBar showDebugRect];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    

    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center_logo"]];
    self.navigationItem.titleView = logo;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    [self setupData];
    
    // pull
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        NSString *loc = @"116.316376,39.952912";
        NSNumber *p = @0;
        [[PDHTTPEngine sharedInstance] appHomeWithLocation:loc page:p success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
        }];
    }];
    
    //
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //
    }];
}

-(void)setupLeftMenuButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_menu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
//    UIBarButtonItem * leftDrawerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"center_menu"]
//                                                                          style:UIBarButtonItemStylePlain
//                                                                         target:self
//                                                                         action:@selector(leftDrawerButtonPress:)];
//    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)setupRightMenuButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_order"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
    
//    UIBarButtonItem * rightDrawerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"center_order"]
//                                                                                 style:UIBarButtonItemStylePlain
//                                                                                target:self
//                                                                                action:@selector(rightDrawerButtonPress:)];
//    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDCenterCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PDCenterDetailViewController *vc = [[PDCenterDetailViewController alloc] init];
    vc.title = @"详情";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    NSLog(@"add");
    if ([self userLogined]) {
        NSString *userid = [PDAccountManager sharedInstance].userid;
        NSString *foodids = @"1*2**2*5";
        [[PDHTTPEngine sharedInstance] cartAddWithUserid:userid foodids:foodids success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
        }];
    }
}

@end
