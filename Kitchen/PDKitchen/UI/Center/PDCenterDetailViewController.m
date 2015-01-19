//
//  PDCenterDetailViewController.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDCenterDetailViewController.h"
#import "PDCommentsViewController.h"
#import "PDCommentsInputViewController.h"
#import "PDCenterDetailCell.h"
#import "PDOwnerCell.h"
#import "PDCommentCell.h"

#import "AppDelegate.h"

@interface PDDetailCellItem : NSObject
@property (nonatomic,strong) Class cellClazz;
@property (nonatomic,strong) id data;

@end

@implementation PDDetailCellItem
@end

@interface PDCenterDetailViewController()

{
    NSMutableArray *list;
    
    UILabel *badge;
}

@property (nonatomic,strong) PDModelFoodDetail *foodDetail;

@end

@implementation PDCenterDetailViewController


- (void)setupData{
    
    if (!list) {
        list = [[NSMutableArray alloc] init];
    }
    
    [list removeAllObjects];
    
    if (_foodDetail.detail_object) {
        PDDetailCellItem *item = [PDDetailCellItem new];
        item.cellClazz = [PDCenterDetailCell class];
        item.data = _foodDetail.detail_object;
        [list addObject:item];
    }
    

    if (_foodDetail.cook_object) {
    
        PDDetailCellItem *item = [PDDetailCellItem new];
        item.cellClazz = [PDOwnerCell class];
        item.data = _foodDetail.cook_object;
        [list addObject:item];
        
    }
    
    //PDCommentCell
    if (_foodDetail.message_object) {
        [_foodDetail.message_object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            PDDetailCellItem *item = [PDDetailCellItem new];
            item.cellClazz = [PDCommentCell class];
            item.data = obj;
            [list addObject:item];
        }];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.mm_drawerController setPanDisableSide:MMPanDisableSideLeft];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"肉酱面";
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setupBackButton];
    [self setupRightMenuButton];
    
//    [self setupData];
    
    UIView *moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 44)];
    
    
    UIButton *seeMore = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, 7, kAppWidth-2*kCellLeftGap, 30)];
    [seeMore setTitle:@"查看更多留言" forState:UIControlStateNormal];
    [seeMore setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [moreView addSubview:seeMore];
    seeMore.titleLabel.font = [UIFont systemFontOfSize:13];
    
    seeMore.layer.borderWidth = 0.5f;
    seeMore.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
    
    
    [seeMore handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        PDCommentsViewController *vc = [[PDCommentsViewController alloc] init];
        vc.foodid = self.foodid;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    //
    __weak PDCenterDetailViewController *weakSelf = self;
    
    [self startLoading];
    
    [[PDHTTPEngine sharedInstance] appDetailWithFoodID:self.foodid success:^(AFHTTPRequestOperation *operation, PDModelFoodDetail * foodDetail) {
        
        
        NSLog(@"%@",foodDetail);
        
        weakSelf.foodDetail = foodDetail;
        
        
        
        if (!foodDetail) {
            [self showDefaultView];
        }
        
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
        weakSelf.tableView.tableFooterView = moreView;
        //
        
        [weakSelf stopLoading];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        [weakSelf stopLoading];
    }];
    
    // 订单商品数量badge
    [[NSNotificationCenter defaultCenter] addObserverForName:kCartModifyNotificationKey object:nil queue:nil usingBlock:^(NSNotification *note) {
        //
        [self setupBadge];
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
    
    if (list.count==0) {
        
    }else{
        [self hiddenDefaultView];
    }
    
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PDDetailCellItem *item = list[indexPath.row];
    return [item.cellClazz cellHeightWithData:item.data];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PDDetailCellItem *item = list[indexPath.row];
    
    PDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(item.cellClazz)];
    if (!cell) {
        cell = [[item.cellClazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(item.cellClazz)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.delegate = self;
    [cell setData:item.data];
    
    if ([cell isKindOfClass:[PDCommentCell class]]) {
        PDCommentCell *commentCell = (PDCommentCell *)cell;
        if (indexPath.row == 2) {
            [commentCell hiddenLine:YES];
        }else{
            [commentCell hiddenLine:NO];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


// 添加订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data{
    NSLog(@"add");
    
    [[PDCartManager sharedInstance] addFood:data];
    // 通知购物车更改
    [[NSNotificationCenter defaultCenter] postNotificationName:kCartModifyNotificationKey object:nil];
    
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

// 赞菜品
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell likeFoodWithData:(id)data{
    
    PDModelFood *fd = (PDModelFood *)data;
    // 点赞
    if ([self userLogined]) {
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] appLikeWithUserid:userid foodid:fd.food_id success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"点赞成功");
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSString *message = error.userInfo[@"Message"];
            if (!message) {
                message = [error localizedDescription];
            }
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:message
                                                            delegate:nil
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"确定", nil];
            [alert show];
            
        }];
    }
    
}


// 分享
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell shareWithData:(id)data{

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //[delegate loginWeibo];
    
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"分享"
                                                       delegate:nil
                                              cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微博", @"微信朋友圈",@"微信好友",nil];
    [sheet showInView:self.view clickedBlock:^(NSInteger buttonIndex) {
        //
        NSLog(@"%ld",buttonIndex);
        
        switch (buttonIndex) {
            case 0: //微博 
            {
                //[delegate performSelector:@selector(loginWeibo) withObject:nil afterDelay:0.5];
                
                [delegate performSelector:@selector(loginWeixin) withObject:nil afterDelay:0.5];
            }
                break;
                
            default:
                break;
        }
    }];
}

// 收藏
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell favoriteWithData:(id)data{

    PDModelFood *fd = (PDModelFood *)data;
//    // 收藏
//    if ([self userLogined]) {
//        NSString *userid = [PDAccountManager sharedInstance].userid;
//        [[PDHTTPEngine sharedInstance] collectAddWithUserid:userid food_id:fd.food_id success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            //
//            NSLog(@"收藏成功");
//            
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //
//            NSString *message = error.userInfo[@"Message"];
//            if (!message) {
//                message = [error localizedDescription];
//            }
//            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
//                                                             message:message
//                                                            delegate:nil
//                                                   cancelButtonTitle:nil
//                                                   otherButtonTitles:@"确定", nil];
//            [alert show];
//        }];
//    }
    
    if ([self userLogined]) {
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] collectDeleteWithUserid:userid food_id:fd.food_id success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
            NSLog(@"取消收藏成功");
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
            NSString *message = error.userInfo[@"Message"];
            if (!message) {
                message = [error localizedDescription];
            }
            UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:message
                                                            delegate:nil
                                                   cancelButtonTitle:nil
                                                   otherButtonTitles:@"确定", nil];
            [alert show];
        }];
    }
}

// 留言
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell commentWithData:(id)data{

    PDCommentsInputViewController *vc = [[PDCommentsInputViewController alloc] init];
    vc.foodid = self.foodid;
    vc.cookerid = _foodDetail.cook_object.cooker_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
