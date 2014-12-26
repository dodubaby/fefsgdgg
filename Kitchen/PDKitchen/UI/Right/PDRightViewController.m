//
//  PDRightViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDRightViewController.h"
#import "PDRightCell.h"
#import "PDRightFooterView.h"

@interface PDRightViewController ()<PDBaseTableViewCellDelegate,PDRightFooterViewDelegate>
{
    
    NSMutableArray *list;
    PDRightFooterView *footer;
}

@end

@implementation PDRightViewController

- (void)setupData{
    
    list = [[NSMutableArray alloc] init];
    [list addObject:@"小炒肉"];
    [list addObject:@"小鸡炖蘑菇"];
    [list addObject:@"北京烤鸭"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    
    [self setupData];
    
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    self.tableView.tableHeaderView = header;
    
    
    footer = [[PDRightFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 120)];
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDRightCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    [cell setData:nil];
    return cell;
}

#pragma mark - PDBaseTableViewCellDelegate

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell reduceWithData:(id)data{

    [footer setTotalPrice:123.8];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addWithData:(id)data{

    [footer setTotalPrice:3245.5];
    
}

#pragma mark - PDRightFooterViewDelegate

-(void)pdRightFooterView:(PDRightFooterView *)view submitWithTotal:(CGFloat)totalPrice{

    NSLog(@"submit");

    
}

@end

