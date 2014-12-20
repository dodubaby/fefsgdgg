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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    [self setupData];
    
    // pull
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
    }];
    
    //
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //
    }];
}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

-(void)setupRightMenuButton{
    MMDrawerBarButtonItem * rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
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

    
}

@end
