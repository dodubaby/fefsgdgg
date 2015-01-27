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
    
    NSDate *date = [NSDate date];
    date = [date dateByAddingTimeInterval:60*60]; // 一小时后
    
    for (int i = 0; i<24; i++) {
        
        NSDate *tempDate = [date dateByAddingTimeInterval:60*60*i]; // 增加半小时
        
        NSLog(@"tempDate %@",tempDate);
        
        [_dataList addObject:tempDate];
    }
    
    [_dataList insertObject:@"立即配送" atIndex:0];
    
//    
//    [_dataList addObject:@"立即配送"];
//    [_dataList addObject:@"6:00"];
//    [_dataList addObject:@"6:30"];
//    [_dataList addObject:@"7:00"];
//    [_dataList addObject:@"7:30"];
//    [_dataList addObject:@"8:00"];
//    [_dataList addObject:@"8:30"];
//    [_dataList addObject:@"9:00"];
//    [_dataList addObject:@"9:30"];
//    [_dataList addObject:@"10:00"];
//    [_dataList addObject:@"10:30"];
//    [_dataList addObject:@"11:00"];
//    [_dataList addObject:@"11:30"];
//    [_dataList addObject:@"12:00"];
//    [_dataList addObject:@"12:30"];
//    [_dataList addObject:@"13:00"];
//    [_dataList addObject:@"13:30"];
//    [_dataList addObject:@"14:00"];
//    [_dataList addObject:@"14:30"];
//    [_dataList addObject:@"15:00"];
//    [_dataList addObject:@"15:30"];
//    [_dataList addObject:@"16:00"];
//    [_dataList addObject:@"16:30"];
//    [_dataList addObject:@"17:00"];
//    [_dataList addObject:@"17:30"];
//    [_dataList addObject:@"18:00"];
//    [_dataList addObject:@"18:30"];
//    [_dataList addObject:@"19:00"];
//    [_dataList addObject:@"19:30"];
//    [_dataList addObject:@"20:00"];
//    [_dataList addObject:@"20:30"];
//    [_dataList addObject:@"21:00"];
//    [_dataList addObject:@"21:30"];
//    [_dataList addObject:@"22:00"];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"就餐时间";
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
    
    if (indexPath.row==0) {
        cell.isFirst = YES;
    }else{
        cell.isFirst = NO;
    }
    
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDate *time = nil;   // 时间
    NSString *displayTime = nil; // 显示时间
    
    if ([_dataList[indexPath.row] isKindOfClass:[NSDate class]]) {  //
        time = _dataList[indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]]; // 本地时间
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:time];
        displayTime = dateStr;
    }else{ // 立即
        time = nil;
        displayTime = _dataList[indexPath.row];
    }
    
    if (_selectDelegete&&[_selectDelegete respondsToSelector:@selector(pdOrderTimeViewController:didSelectTime:displayTime:)]) {
        [_selectDelegete pdOrderTimeViewController:self didSelectTime:time displayTime:displayTime];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
