//
//  PDFavoritesViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDFavoritesViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "PDFavoritesCell.h"

#import "PDCenterDetailViewController.h"

@interface PDFavoritesViewController ()
{
}

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) int currentPage;

@end

@implementation PDFavoritesViewController

- (void)setupData{
    _dataList = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收藏";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self setupBackButton];
    [self setupData];
    
    __weak PDFavoritesViewController *weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        [weakSelf startLoading];
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] collectMyCollectWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
            [weakSelf.tableView.pullToRefreshView stopAnimating];
            
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
        CGFloat h = [PDFavoritesCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        [weakSelf startLoading];
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] collectMyCollectWithUserid:userid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDFavoritesCell cellHeightWithData:_dataList[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDFavoritesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDFavoritesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell setData:_dataList[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PDCenterDetailViewController *vc = [[PDCenterDetailViewController alloc] init];
    PDModelFood *food = _dataList[indexPath.row];
    vc.title = food.food_name;
    vc.foodid = food.food_id;
    [self.navigationController pushViewController:vc animated:YES];
}

//// 删除收藏
//if ([self userLogined]) {
//    NSString *userid = [PDAccountManager sharedInstance].userid;
//    [[PDHTTPEngine sharedInstance] collectDeleteWithUserid:userid food_id:@1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        //
//        NSLog(@"删除收藏成功");
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        //
//    }];
//}

@end
