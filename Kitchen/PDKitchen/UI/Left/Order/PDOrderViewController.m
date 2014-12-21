//
//  PDOrderViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/20.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderViewController.h"
#import "PDOrderDetailViewController.h"
#import "PDOrderCell.h"

@interface PDOrderViewController ()
{

        NSMutableArray *list;
}
@end

@implementation PDOrderViewController

- (void)setupData{
    
    list = [[NSMutableArray alloc] init];
    [list addObject:@"小炒肉"];
    [list addObject:@"小鸡炖蘑菇"];
    [list addObject:@"北京烤鸭"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    
    [self setupData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDOrderCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PDOrderDetailViewController *vc = [[PDOrderDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
