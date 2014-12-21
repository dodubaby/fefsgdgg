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
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    return 40;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
    header.backgroundColor=[UIColor grayColor];
    
    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 0, 150, 40)];
    AMButton.backgroundColor=[UIColor grayColor];
    [header addSubview:AMButton];
    [AMButton setTitle:@"上午订单" forState:UIControlStateNormal];
    [AMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(180, 0, 150, 40)];
    PMButton.backgroundColor=[UIColor grayColor];
    [header addSubview:PMButton];
    [PMButton setTitle:@"下午订单" forState:UIControlStateNormal];
    [PMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
