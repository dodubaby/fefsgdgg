//
//  PDCommentsViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCommentsViewController.h"
#import "PDCommentCell.h"


@interface PDCommentsViewController()
{

}
@property (nonatomic,strong) NSMutableArray *dataList;
@property (nonatomic,assign) int currentPage;

@end

@implementation PDCommentsViewController


- (void)setupData{
    _dataList = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"评论";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
    [self setupData];
    
    __weak PDCommentsViewController *weakSelf = self;
    
    // pull
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        [weakSelf startLoading];
        
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        [[PDHTTPEngine sharedInstance] messageAllWithFoodid:weakSelf.foodid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
    
    //
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        //
        [weakSelf startLoading];
        
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        [[PDHTTPEngine sharedInstance] messageAllWithFoodid:weakSelf.foodid page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
                label.text = @"没有更多评论";
                
                
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
    return [PDCommentCell cellHeightWithData:_dataList[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    PDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    [cell setData:_dataList[indexPath.row]];
    
    if (indexPath.row == 0) {
        [cell hiddenLine:YES];
    }else{
        [cell hiddenLine:NO];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
