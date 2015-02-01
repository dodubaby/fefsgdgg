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

#import "INTULocationManager.h"
#import "PDLocationManager.h"
#import "BKLocationManager.h"

@interface PDCenterViewController ()
{
    UILabel *badge;
    UIImageView *newsMark;
}

@property (nonatomic,strong) NSMutableArray *dataList;

@property (nonatomic,assign) int currentPage;

@property (nonatomic,strong) NSString *locationStr;

@property (nonatomic,strong) CLLocation *location;

@property (nonatomic,assign) BOOL isSimulator;  // 模拟器上用固定地址

@end

@implementation PDCenterViewController


- (void)setupData{
    _dataList = [[NSMutableArray alloc] init];
    
    if ([[UIDevice currentDevice].model hasSuffix:@"Simulator"]) {
        _isSimulator = YES;
    }else{
        _isSimulator = NO;
    }

    // _isSimulator = NO;
    
    // 模拟器使用
    _locationStr = @"116.316376,39.952912";
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
    
#if kForSimulatorUse
    // pull
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf startLoading];
        
        weakSelf.currentPage = 0;
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
#else
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        
        [weakSelf startLoading];
        
        if (weakSelf.isSimulator) {  // 模拟器
            weakSelf.currentPage = 0;
            NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
            
            
            [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
                //
                [weakSelf.tableView.pullToRefreshView stopAnimating];
                
                if ([list count]==0) {
                    [weakSelf showDefaultView];
                }else{
                    
                    weakSelf.currentPage +=1;
                    
                    [weakSelf.dataList removeAllObjects];
                    [weakSelf.dataList addObjectsFromArray:list];
                    [weakSelf.tableView reloadData];
                }
                
                [weakSelf stopLoading];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
                [weakSelf.tableView.pullToRefreshView stopAnimating];
                [weakSelf stopLoading];
            }];
        }else{  // 真机
            
            BKLocationManager *manager = [BKLocationManager sharedManager];
            [manager setDidUpdateLocationBlock:^(CLLocationManager *manager, CLLocation *newLocation, CLLocation *oldLocation) {
                //
                weakSelf.location = newLocation;
                if (newLocation) {
                    NSNumber *latitude = [NSNumber numberWithDouble:newLocation.coordinate.latitude];
                    NSNumber *longitude = [NSNumber numberWithDouble:newLocation.coordinate.longitude];
                    NSString *loc =  [NSString stringWithFormat:@"%@,%@",longitude,latitude];
                    weakSelf.locationStr = loc;
                }
                
                // 定位成功开始加载
                weakSelf.currentPage = 0;
                NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
                
                
                [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
                    //
                    [weakSelf.tableView.pullToRefreshView stopAnimating];
                    
                    if ([list count]==0) {
                        [weakSelf showDefaultView];
                    }else{
                        
                        weakSelf.currentPage +=1;
                        
                        [weakSelf.dataList removeAllObjects];
                        [weakSelf.dataList addObjectsFromArray:list];
                        [weakSelf.tableView reloadData];
                    }
                    
                    [weakSelf stopLoading];
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    //
                    [weakSelf.tableView.pullToRefreshView stopAnimating];
                    [weakSelf stopLoading];
                }];

                [manager stopUpdatingLocation];
            }];
            
            [manager setDidFailBlock:^(CLLocationManager *manager, NSError *error) {
                //
                [weakSelf.tableView.pullToRefreshView stopAnimating];
                [weakSelf stopLoading];
                
                [manager stopUpdatingLocation];
                
                if (weakSelf.location) { // 真机，有位置信息,开始加载
                    weakSelf.currentPage = 0;
                    NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
                    
                    [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
                        //
                        [weakSelf.tableView.pullToRefreshView stopAnimating];
                        
                        if ([list count]==0) {
                            [weakSelf showDefaultView];
                        }else{
                            
                            weakSelf.currentPage +=1;
                            
                            [weakSelf.dataList removeAllObjects];
                            [weakSelf.dataList addObjectsFromArray:list];
                            [weakSelf.tableView reloadData];
                        }
                        
                        [weakSelf stopLoading];
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //
                        [weakSelf.tableView.pullToRefreshView stopAnimating];
                        [weakSelf stopLoading];
                    }];
                }else{
                    // 判断定位服务是否可用
                    if ([CLLocationManager locationServicesEnabled] == NO){
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                        message:@"你的定位服务没有打开：设置》隐私》定位服务开启"
                                                                       delegate:nil
                                                              cancelButtonTitle:nil
                                                              otherButtonTitles:@"确定", nil];
                        
                        [alert show];
                    }else{
                        
                        CLAuthorizationStatus locationStatus = [CLLocationManager authorizationStatus];
                        switch (locationStatus)
                        {
                            case kCLAuthorizationStatusRestricted:
                            case kCLAuthorizationStatusDenied:
                            {
                               
                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                                                message:@"你的定位服务没有打开：设置》隐私》定位服务开启"
                                                                               delegate:nil
                                                                      cancelButtonTitle:nil
                                                                      otherButtonTitles:@"确定", nil];
                                
                                [alert show];

                                
                                break;
                            }
                                // 未确定
                            case kCLAuthorizationStatusNotDetermined:
                            {
                                break;
                            }
                                
                                // 去哪儿定位服务开启
                            default:
                                break;
                        }
                    }
                }
            }];
            [manager startUpdatingLocation];
        }
    }];

#endif
    
//
//    // pull
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        
//        [weakSelf startLoading];
//        
//        if (weakSelf.isSimulator) {  // 模拟器
//            weakSelf.currentPage = 0;
//            NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
//            
//            
//            [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//                //
//                [weakSelf.tableView.pullToRefreshView stopAnimating];
//                
//                if ([list count]==0) {
//                    [weakSelf showDefaultView];
//                }else{
//                
//                    weakSelf.currentPage +=1;
//                    
//                    [weakSelf.dataList removeAllObjects];
//                    [weakSelf.dataList addObjectsFromArray:list];
//                    [weakSelf.tableView reloadData];
//                }
//                
//                [weakSelf stopLoading];
//                
//            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                //
//                [weakSelf.tableView.pullToRefreshView stopAnimating];
//                [weakSelf stopLoading];
//            }];
//        }else{  // 真机
//            
//            // 定位刷新
//            INTULocationManager *locMgr = [INTULocationManager sharedInstance];
//            [locMgr requestLocationWithDesiredAccuracy:INTULocationAccuracyRoom timeout:10.0 delayUntilAuthorized:YES block:^(CLLocation *currentLocation, INTULocationAccuracy achievedAccuracy, INTULocationStatus status) {
//                if (status == INTULocationStatusSuccess) {
//                    weakSelf.location = currentLocation;
//                    if (currentLocation) {
//                        NSNumber *latitude = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
//                        NSNumber *longitude = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];
//                        NSString *loc =  [NSString stringWithFormat:@"%@,%@",longitude,latitude];
//                        weakSelf.locationStr = loc;
//                    }
//                    
//                    // 定位成功开始加载
//                    weakSelf.currentPage = 0;
//                    NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
//                    
//                    
//                    [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//                        //
//                        [weakSelf.tableView.pullToRefreshView stopAnimating];
//                        
//                        if ([list count]==0) {
//                            [weakSelf showDefaultView];
//                        }else{
//                            
//                            weakSelf.currentPage +=1;
//                            
//                            [weakSelf.dataList removeAllObjects];
//                            [weakSelf.dataList addObjectsFromArray:list];
//                            [weakSelf.tableView reloadData];
//                        }
//                        
//                        [weakSelf stopLoading];
//                        
//                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                        //
//                        [weakSelf.tableView.pullToRefreshView stopAnimating];
//                        [weakSelf stopLoading];
//                    }];
//
//                }else{   // 定位失败
//                    if (weakSelf.location) { // 真机，有位置信息,开始加载
//                        weakSelf.currentPage = 0;
//                        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
//                        
//                        [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//                            //
//                            [weakSelf.tableView.pullToRefreshView stopAnimating];
//                            
//                            if ([list count]==0) {
//                                [weakSelf showDefaultView];
//                            }else{
//                                
//                                weakSelf.currentPage +=1;
//                                
//                                [weakSelf.dataList removeAllObjects];
//                                [weakSelf.dataList addObjectsFromArray:list];
//                                [weakSelf.tableView reloadData];
//                            }
//                            
//                            [weakSelf stopLoading];
//                            
//                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                            //
//                            [weakSelf.tableView.pullToRefreshView stopAnimating];
//                            [weakSelf stopLoading];
//                        }];
//                    }else{ // 真机，没有位置信息
//                        
//                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                                        message:@"你的定位服务没有打开：设置》隐私》定位服务开启"
//                                                                       delegate:nil
//                                                              cancelButtonTitle:nil
//                                                              otherButtonTitles:@"确定", nil];
//                        
//                        [alert show];
//
//                        [weakSelf.tableView.pullToRefreshView stopAnimating];
//                        [weakSelf stopLoading];
//                        [weakSelf.tableView reloadData];
//                        [weakSelf showDefaultView];
//                    }
//                }
//             }];
//        }
//    }];
    
//#endif
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        
        
        // 真机，定位不成功
        if (!weakSelf.location&&!weakSelf.isSimulator) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        CGFloat h = [PDCenterCell cellHeightWithData:nil]*weakSelf.dataList.count;
        if (h<weakSelf.tableView.bounds.size.height) {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            return;
        }
        
        [weakSelf startLoading];
        
        NSNumber *p = [NSNumber numberWithInt:weakSelf.currentPage];
        
        [[PDHTTPEngine sharedInstance] appHomeWithLocation:weakSelf.locationStr page:p success:^(AFHTTPRequestOperation *operation, NSArray *list) {
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
                label.text = @"没有更多的菜";
                
                
                [weakSelf.tableView.infiniteScrollingView setCustomView:label forState:SVInfiniteScrollingStateStopped];
            
            }
            
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf stopLoading];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 40)];
            label.backgroundColor = [UIColor whiteColor];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = @"没有更多的菜";

            [weakSelf.tableView.infiniteScrollingView setCustomView:label forState:SVInfiniteScrollingStateStopped];
            
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            
            [weakSelf stopLoading];
        }];
    }];
    
    
    // 订单商品数量badge
    [[NSNotificationCenter defaultCenter] addObserverForName:kCartModifyNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [self setupBadge];
    }];
    
    // 新消息红点
    [[NSNotificationCenter defaultCenter] addObserverForName:kNewsHideNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        NSNumber *coupon_count = [PDAccountManager sharedInstance].coupon_count;
        NSNumber *news_count = [PDAccountManager sharedInstance].news_count;
        
        // 只要有券或者消息，就显示红点
        if([coupon_count intValue]>0||[news_count intValue]>0){
            newsMark.hidden = NO;
        }else{
            newsMark.hidden = YES;
        }
    }];
    

    [self.tableView triggerPullToRefresh];
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
    newsMark.hidden = YES;
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
    if (_dataList.count==0) {
        
    }else{
        [self hiddenDefaultView];
    }
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

-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data button:(UIButton *)addButton{
    NSLog(@"add");

    PDModelFood *food = (PDModelFood *)data;
    if ([food.stock integerValue]<=0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"你点的菜库存不足，请选择其它菜品"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"确定", nil];
        [alert show];
        
        return;
    }
    
    UIButton *button = addButton;
    CGRect frame =  [[UIApplication sharedApplication].keyWindow convertRect:button.frame toView:nil];

    NSLog(@"%@",NSStringFromCGRect(frame));
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.top = label.top +64;
    label.backgroundColor = [UIColor colorWithHexString:@"#c14a41"];
    label.font = [UIFont boldSystemFontOfSize:15];
    label.layer.cornerRadius = 4;
    label.clipsToBounds = YES;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"加入订单";
    
    [[UIApplication sharedApplication].keyWindow addSubview:label];
    
    [UIView animateWithDuration:0.4 animations:^{
        //
        label.center = CGPointMake(kAppWidth - 30, 40);
        label.transform = CGAffineTransformScale(label.transform,0.2,0.2);
        label.alpha = 0.5;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
    
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
