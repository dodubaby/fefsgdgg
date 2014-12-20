//
//  PDCouponViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCouponViewController.h"
#import "PDCouponCell.h"

@interface PDCouponViewController ()
{

    NSMutableArray *list;
}

@end

@implementation PDCouponViewController

- (void)setupData{
    
    list = [[NSMutableArray alloc] init];
    [list addObject:@"小炒肉"];
    [list addObject:@"小鸡炖蘑菇"];
    [list addObject:@"北京烤鸭"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的优惠券";
    
    [self setupData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDCouponCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    return cell;
}

@end
