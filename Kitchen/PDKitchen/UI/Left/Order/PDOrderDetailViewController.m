//
//  PDOrderDetailViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/20.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderDetailViewController.h"
#import "PDOrderLogisticsView.h"
#import "PDOrderDetailView.h"

@interface PDOrderDetailViewController ()
{
    PDOrderLogisticsView *orderLogisticsView; // 物流
    PDOrderDetailView    *orderDetailView;    // 详情
    
    
    UIButton *logisticsButton;
    UIButton *detailButton;
    
    UIButton *done;
    UIButton *refund;
}
@end

@implementation PDOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的订单";
    
    logisticsButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 10+64, 80, 30)];
    [self.view addSubview:logisticsButton];
    [logisticsButton setTitle:@"物流动态" forState:UIControlStateNormal];
    [logisticsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [logisticsButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [logisticsButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [logisticsButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        [self showLogistics];
    }];
    
    detailButton = [[UIButton alloc] initWithFrame:CGRectMake(40+90, 10+64, 80, 30)];
    [self.view addSubview:detailButton];
    [detailButton setTitle:@"订单详情" forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [detailButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [detailButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [detailButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        [self showDetail];
    }];
    
    orderLogisticsView = [[PDOrderLogisticsView alloc] initWithFrame:CGRectMake(0, 10+64+44, self.view.width, 460)];
    [self.view addSubview:orderLogisticsView];
    orderLogisticsView.backgroundColor = [UIColor blueColor];
    
    orderDetailView = [[PDOrderDetailView alloc] initWithFrame:CGRectMake(0, 10+64+44, self.view.width, 460)];
    [self.view addSubview:orderDetailView];
    orderDetailView.backgroundColor = [UIColor greenColor];
    
    done = [[UIButton alloc] initWithFrame:CGRectMake((kAppWidth - 130)/2, self.view.height - 130, 130, 40)];
    [self.view addSubview:done];
    [done setTitle:@"我已就餐" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [done setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [done setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [done handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {

    }];
    
    refund = [[UIButton alloc] initWithFrame:CGRectMake((kAppWidth - 130)/2, self.view.height - 80, 130, 40)];
    [self.view addSubview:refund];
    [refund setTitle:@"退单" forState:UIControlStateNormal];
    [refund setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refund setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [refund setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [refund handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        
    }];
    
    // 默认展示物流信息
    [self showLogistics];
    
    [self.view showDebugRect];
}

-(void)showLogistics{
    orderLogisticsView.hidden = NO;
    orderDetailView.hidden = YES;
    
    logisticsButton.selected = YES;
    detailButton.selected = NO;
}

-(void)showDetail{
    orderLogisticsView.hidden = YES;
    orderDetailView.hidden = NO;
    
    logisticsButton.selected = NO;
    detailButton.selected = YES;
}


@end
