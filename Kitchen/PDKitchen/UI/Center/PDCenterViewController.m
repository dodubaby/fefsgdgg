//
//  PDCenterViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCenterViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "PDCenterCell.h"

#import "PDCenterDetailViewController.h"



@interface PDCenterViewController ()
{
    UILabel *badge;
    UIImageView *newsMark;
}

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) int currentPage;

@end

@implementation PDCenterViewController


- (void)setupData{
    _dataList = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideNone];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center_logo"]];
    self.navigationItem.titleView = logo;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupLeftMenuButton];
    [self setupRightMenuButton];
    [self setupData];
    
    __weak PDCenterViewController *weakSelf = self;
    
    // pull
    [self.tableView addPullToRefreshWithActionHandler:^{
        //
        
        [weakSelf startLoading];
        
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        NSString *loc = @"116.316376,39.952912";
        
        [[PDHTTPEngine sharedInstance] appHomeWithLocation:loc page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
        
        CGFloat h = [PDCenterCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        [weakSelf startLoading];
        
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        NSString *loc = @"116.316376,39.952912";
        
        [[PDHTTPEngine sharedInstance] appHomeWithLocation:loc page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
    
    // 订单商品数量badge
    [[NSNotificationCenter defaultCenter] addObserverForName:kCartModifyNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [self setupBadge];
    }];
    
    // 新消息红点
    [[NSNotificationCenter defaultCenter] addObserverForName:kNewsHideNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        newsMark.hidden = YES;
    }];
}

-(void)setupBadge{
    
    NSArray *foods = [PDCartManager sharedInstance].cartList;
    NSInteger c = 0;
    for (PDModelFood *fd in foods) {
        c = c + [fd.count integerValue];
    }
    if (c>0) {
        badge.text = [NSString stringWithFormat:@"%ld",c];
        badge.hidden = NO;
        
        [badge sizeToFit];
        if (badge.width>20) {
            badge.frame = CGRectMake(10, 0, badge.width+10, 20);
        }else{
            badge.frame = CGRectMake(20, 0, 20, 20);
        }
    }else{
        badge.text = nil;
        badge.hidden = YES;
    }
}

-(void)setupLeftMenuButton{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_menu"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
    
    newsMark = [[UIImageView alloc] initWithFrame:CGRectMake(17, 8, 7, 7)];
    [button addSubview:newsMark];
    newsMark.backgroundColor = [UIColor colorWithHexString:@"#fe8501"];
    newsMark.layer.cornerRadius = 3.5f;
    newsMark.layer.masksToBounds = YES;
    newsMark.hidden = NO;
}

-(void)setupRightMenuButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_order"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
    
    badge = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
    badge.font = [UIFont systemFontOfSize:12];
    badge.backgroundColor = [UIColor colorWithHexString:@"#fe8501"];
    badge.textColor = [UIColor whiteColor];
    badge.textAlignment = NSTextAlignmentCenter;
    [button addSubview:badge];
    badge.layer.cornerRadius = 10.0f;
    badge.layer.borderWidth = 1.0f;
    badge.layer.borderColor = [UIColor whiteColor].CGColor;
    badge.layer.masksToBounds = YES;
    badge.hidden = YES;
    
    [self setupBadge];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(void)rightDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PDCenterCell cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PDCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell = [[PDCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:_dataList[indexPath.row]];
    cell.delegate = self;
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


// 添加购物车

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    NSLog(@"add");
    
    [[PDCartManager sharedInstance] addFood:data];
    

    
//    if ([self userLogined]) {
//        NSString *userid = [PDAccountManager sharedInstance].userid;
//        NSString *foodids = @"1*2**2*5";
//        [[PDHTTPEngine sharedInstance] cartAddWithUserid:userid foodids:foodids success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//            //
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //
//        }];
//    }
}

@end
