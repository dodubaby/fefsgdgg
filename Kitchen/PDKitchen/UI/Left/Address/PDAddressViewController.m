//
//  PDAddressViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDAddressViewController.h"
#import "PDAddressCell.h"

@interface PDAddressViewController ()

@end

@implementation PDAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的地址";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
}

-(void)backButtonTaped:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        //
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDAddressCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDAddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
