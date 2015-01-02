//
//  PDTodayOrderTableViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDTodayOrderTableViewController.h"
#import "PDOrderModel.h"
#import "PDOrderCell.h"

@interface PDTodayOrderTableViewController ()
{
    NSMutableArray *list;
}
@end

@implementation PDTodayOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list=[[NSMutableArray alloc] init];
    [list addObject:[[PDOrderModel alloc] init]];
    [list addObject:[[PDOrderModel alloc] init]];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor clearColor];
    button.frame = CGRectMake(0, 0, 26, 40);
    [button setImage:[UIImage imageNamed:@"Back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    UILabel *ttitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kAppWidth, 44)];
    ttitle.text=@"今日订单";
    ttitle.font=[UIFont systemFontOfSize:kAppFontSize];
    ttitle.textColor=[UIColor colorWithHexString:kAppNormalColor];
    ttitle.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=ttitle;
    
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
}
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return list.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 60)];
    header.backgroundColor=[UIColor whiteColor];
    
    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kGap, kGap, (kAppWidth-2*kGap)/2, 50)];
    AMButton.backgroundColor=[UIColor whiteColor];
    [header addSubview:AMButton];
    [AMButton setTitle:@"上午订单" forState:UIControlStateNormal];
    [AMButton.titleLabel setFont:[UIFont systemFontOfSize:kAppFontSize]];
    [AMButton setTitleColor:[UIColor colorWithHexString:kAppNormalColor] forState:UIControlStateNormal];
    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    UIImageView *gapimg=[[UIImageView alloc] initWithFrame:CGRectMake(AMButton.right, AMButton.top+18, 1, 16)];
    gapimg.backgroundColor=[UIColor colorWithHexString:kAppLineColor];
    [header addSubview:gapimg];
    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+1, kGap, (kAppWidth-2*kGap)/2, 50)];
    PMButton.backgroundColor=[UIColor whiteColor];
    [header addSubview:PMButton];
    [PMButton setTitle:@"下午订单" forState:UIControlStateNormal];
    [PMButton setTitleColor:[UIColor colorWithHexString:kAppNormalColor] forState:UIControlStateNormal];
    [PMButton.titleLabel setFont:[UIFont systemFontOfSize:kAppFontSize]];
    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDOrderCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellstring=@"ordercellID";
    PDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if (!cell) {
        cell = [[PDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
        cell.type=OrderTypeToday;
    }
    [cell setData:nil];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    
    
}

@end
