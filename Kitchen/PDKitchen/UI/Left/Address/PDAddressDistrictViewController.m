//
//  PDAddressDistrictViewController.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDAddressDistrictViewController.h"
#import "PDAddressDistrictCell.h"


@interface PDAddressDistrictViewController()

@end

@implementation PDAddressDistrictViewController


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
}

-(void)pdAddressInputView:(UIView *)addressView districtButtonTaped:(id)sender{
    
    PDAddressDistrictViewController *district = [[PDAddressDistrictViewController alloc] init];
    [self.navigationController pushViewController:district animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDAddressDistrictCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDAddressDistrictCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDAddressDistrictCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
    
    if (_selectDelegate&&[_selectDelegate respondsToSelector:@selector(pdAddressDistrictViewController:didSelectDistrict:)]) {
        [_selectDelegate pdAddressDistrictViewController:self didSelectDistrict:_dataList[indexPath.row]];
    }
    
}
@end

