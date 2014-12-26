//
//  PDOrderInquiryTableViewController.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDOrderInquiryTableViewController.h"
#import "PDOrderModel.h"
#import "PDOrderCell.h"
#import "PDAllOrderTableViewController.h"
@interface PDOrderInquiryTableViewController ()
{
    NSMutableArray *list;
}
@end

@implementation PDOrderInquiryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    list=[[NSMutableArray alloc] init];
    [list addObject:[[PDOrderModel alloc] init]];
    [list addObject:[[PDOrderModel alloc] init]];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc] initWithTitle:@"全部订单" style:UIBarButtonItemStylePlain target:self action:@selector(allOrderAciton:)];
    self.navigationItem.rightBarButtonItem=rightitem;
    
}
-(void)allOrderAciton:(id)sender
{
    PDAllOrderTableViewController*vc=[[PDAllOrderTableViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
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
    return 80;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header=[[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
    header.backgroundColor=[UIColor grayColor];
    
    UIButton *searchutton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-100, kCellLeftGap, 100, 20)];
    searchutton.backgroundColor=[UIColor grayColor];
    [header addSubview:searchutton];
    [searchutton setTitle:@"查询" forState:UIControlStateNormal];
    [searchutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    UITextField *input =[[UITextField alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-kCellLeftGap*2-searchutton.width-20, 20)];
    input.borderStyle=UITextBorderStyleLine;
    [header addSubview:input];
    
    UIButton *AMButton = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, input.bottom+kCellLeftGap, 100, 40)];
    AMButton.backgroundColor=[UIColor grayColor];
    [header addSubview:AMButton];
    [AMButton setTitle:@"配送的订单" forState:UIControlStateNormal];
    [AMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    UIButton *PMButton = [[UIButton alloc] initWithFrame:CGRectMake(AMButton.right+kCellLeftGap, input.bottom+kCellLeftGap, 100, 40)];
    PMButton.backgroundColor=[UIColor grayColor];
    [header addSubview:PMButton];
    [PMButton setTitle:@"退款的订单" forState:UIControlStateNormal];
    [PMButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [PMButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDOrderCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellstring=@"inOrdercellID";
    PDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstring];
    if (!cell) {
        cell = [[PDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstring];
        cell.type=OrderTypeNormal;
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
