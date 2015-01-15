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
    if (!list) {
        list = [[NSMutableArray alloc] init];
    }
}

-(void)congfigData{

    [list removeAllObjects];
    
    NSArray *cartList = [PDCartManager sharedInstance].cartList;
    [list addObjectsFromArray:cartList];
    
    [self.tableView reloadData];
    
    
    // 总价  // @"3份美食 共计113元";
    NSInteger c = 0;
    CGFloat price = 0.0f;
    
    for (PDModelFood *fd in list) {
        
        c = c + [fd.count integerValue];
        
        price = price + [fd.price floatValue]*[fd.count integerValue];
    }
    
    if (c>0) {
        NSString *str = [NSString stringWithFormat:@"%ld份美食 共计%.02f元",c,price];
        footer.totalPrice = str;
        clearButton.hidden = NO;
        footer.hidden = NO;
    }else{
    
        footer.totalPrice = nil;
        clearButton.hidden = YES;
        footer.hidden = YES;
    }
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
    footer.hidden = YES;
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
    [clearButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清空确认"
                                                        message:@"你还有订单没有提交，确定清除？"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert showWithClickedBlock:^(NSInteger buttonIndex) {
            switch (buttonIndex) {
                case 1:
                {
                    // 清除购物车
                    [[PDCartManager sharedInstance] clear];
                }
                    break;
                    
                default:
                    break;
            }
        }];
        
        
//            if ([self userLogined]) {
//                NSString *userid = [PDAccountManager sharedInstance].userid;
//                [[PDHTTPEngine sharedInstance] cartDeleteWithUserid:userid success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//                    //
//                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                    //
//                }];
//            }

        
    }];
    
    clearButton.hidden = YES;
    
    //[self.view showDebugRect];
    
    // 刷新购物车数据
    [[NSNotificationCenter defaultCenter] addObserverForName:kCartModifyNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [self congfigData];
        
    }];
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
    [cell setData:list[indexPath.row]];
    return cell;
}

#pragma mark - PDBaseTableViewCellDelegate

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell reduceWithData:(id)data{

    [[PDCartManager sharedInstance] removeFood:data];

}

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addWithData:(id)data{

    [[PDCartManager sharedInstance] addFood:data];
}

#pragma mark - PDRightFooterViewDelegate

-(void)pdRightFooterView:(PDRightFooterView *)view submitWithTotal:(CGFloat)totalPrice{
    NSLog(@"submit");

    if ([self userLogined]) {
    
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] orderAddWithUserid:userid
                                                  foodids:@"11"
                                                  address:@"11"
                                                    phone:@"11"
                                                 couponid:@"11"
                                                  eatTime:@"11"
                                                  message:@"11"
                                                 sumPrice:@"11" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                     //
                                                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                     //
                                                 }];
        
    }
    
//    // 我的购物车
//    if ([self userLogined]) {
//    
//        NSString *userid = [PDAccountManager sharedInstance].userid;
//        [[PDHTTPEngine sharedInstance] cartMyCartWithUserid:userid success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//            //
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //
//        }];
//    }
}

@end

