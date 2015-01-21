//
//  PDOrderViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/20.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderViewController.h"
#import "PDOrderDetailViewController.h"
#import "PDOrderCell.h"

@interface PDOrderViewController ()
{

}

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) int currentPage;

@end

@implementation PDOrderViewController


- (void)setupData{
    
    _dataList = [[NSMutableArray alloc] init];
}

-(void)backButtonTaped:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的订单";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupData];
    [self setupBackButton];
    
    
    __weak PDOrderViewController *weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        [weakSelf startLoading];
        
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] orderMyOrderWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            
            if ([list count]==0) {
                [weakSelf showDefaultView];
            }
            
            weakSelf.currentPage +=1;
            
            [weakSelf.dataList removeAllObjects];
            [weakSelf.dataList addObjectsFromArray:list];
            [weakSelf.tableView reloadData];
            
            [weakSelf stopLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            [weakSelf stopLoading];
        }];
        
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        // 高度不够不用加载更多
        CGFloat h = [PDOrderCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] orderMyOrderWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            
            weakSelf.currentPage +=1;
            
            if (list.count>0) {
                [weakSelf.dataList addObjectsFromArray:list];
                [weakSelf.tableView reloadData];
            }
            [weakSelf stopLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf stopLoading];
        }];
    }];
    
    [self.tableView triggerPullToRefresh];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDOrderCell cellHeightWithData:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataList.count==0) {
    }else{
        [self hiddenDefaultView];
    }
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PDOrderDetailViewController *vc = [[PDOrderDetailViewController alloc] init];
    PDModelOrder *od = _dataList[indexPath.row];
    vc.orderid = od.order_id;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
