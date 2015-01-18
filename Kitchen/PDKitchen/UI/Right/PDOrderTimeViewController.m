//
//  PDOrderTimeViewController.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderTimeViewController.h"
#import "PDOrderTimeCell.h"


@interface PDOrderTimeViewController()

@property(nonatomic,strong) NSMutableArray *dataList;


@end

@implementation PDOrderTimeViewController


- (void)setupData{

    _dataList = [[NSMutableArray alloc] init];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    [_dataList addObject:@"6:00"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
    [self setupData];
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [PDOrderTimeCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PDOrderTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDOrderTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_selectDelegete&&[_selectDelegete respondsToSelector:@selector(pdOrderTimeViewController:didSelectTime:)]) {
        [_selectDelegete pdOrderTimeViewController:self didSelectTime:_dataList[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
