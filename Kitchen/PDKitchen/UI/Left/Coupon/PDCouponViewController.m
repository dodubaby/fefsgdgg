//
//  PDCouponViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCouponViewController.h"
#import "PDCouponCell.h"

@interface PDCouponViewController ()
{

}

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) int currentPage;

@end

@implementation PDCouponViewController

- (void)setupData{
    _dataList = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(_isForOrder){
        [self.mm_drawerController setPanDisableSide:MMPanDisableSideBoth];
    }else{
        [self.mm_drawerController setPanDisableSide:MMPanDisableSideRight];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的优惠券";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
    
    [self setupData];
    
    
    NSString *fromType = nil;
    
    if (_isForOrder) {
        fromType = @"pay";
    }
    
    __weak PDCouponViewController *weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        [weakSelf startLoading];
        
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] couponMyCouponWithUserid:userid from:fromType page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
        CGFloat h = [PDCouponCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        [weakSelf startLoading];
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] couponMyCouponWithUserid:userid from:fromType page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            if (list.count>0) {
                weakSelf.currentPage +=1;
                [weakSelf.dataList addObjectsFromArray:list];
                [weakSelf.tableView reloadData];
            }else{ // 没有更多
                
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
                label.backgroundColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:15];
                label.textColor = [UIColor colorWithHexString:@"#666666"];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"没有更多优惠券";
                
                [weakSelf.tableView.infiniteScrollingView setCustomView:label forState:SVInfiniteScrollingStateStopped];
                
            }
            
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf stopLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf stopLoading];
        }];
    }];
    
    [self.tableView triggerPullToRefresh];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDCouponCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDCouponCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (_isForOrder) {
        if (_selectDelegate&&[_selectDelegate respondsToSelector:@selector(pdCouponViewController:didSelectCoupon:)]) {
            [_selectDelegate pdCouponViewController:self didSelectCoupon:_dataList[indexPath.row]];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
