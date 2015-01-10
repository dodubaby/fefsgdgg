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
#import "PDAddressViewController.h"

#import "AppDelegate.h"

@interface PDRightViewController ()<PDBaseTableViewCellDelegate,PDRightFooterViewDelegate>
{
    
    NSMutableArray *list;
    PDRightFooterView *footer;
    
    UIButton *clearButton;
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
    
    [self setupData];
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    header.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, header.width-110, 44)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.text = @"提交订单";
    [header addSubview:label];
    
    self.tableView.tableHeaderView = header;
    
    footer = [[PDRightFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 80)];
    footer.delegate = self;
    self.tableView.tableFooterView = footer;
    
    
    clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.frame = CGRectMake(85, kAppHeight - 90, 90, 30);
    [self.view addSubview:clearButton];
    [clearButton setTitle:@"清空购物车" forState:UIControlStateNormal];
    
    [clearButton setTitleColor:[UIColor colorWithHexString:@"#c14a41"] forState:UIControlStateNormal];
    clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    clearButton.layer.borderWidth = 0.5;
    clearButton.layer.borderColor = [UIColor colorWithHexString:@"#c14a41"].CGColor;
    clearButton.layer.cornerRadius = 4; //;
    clearButton.clipsToBounds = YES;
    
    //[self.view showDebugRect];
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
        cell.backgroundColor = [UIColor colorWithHexString:@"#edf2f5"];

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

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    PDAddressViewController *address = [[PDAddressViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:address];
    [delegate.window.rootViewController presentViewController:nav animated:YES completion:^{
        //
    }];
    
}

@end

