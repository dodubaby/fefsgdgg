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

@interface PDCenterDetailViewController()<PDBaseTableViewCellDelegate>

{
    NSMutableArray *list;
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
    
    self.tableView.tableFooterView = moreView;
    
    //
    
    __weak PDCenterDetailViewController *weakSelf = self;
    
    [[PDHTTPEngine sharedInstance] appDetailWithFoodID:self.foodid success:^(AFHTTPRequestOperation *operation, PDModelFoodDetail * foodDetail) {
        
        NSLog(@"%@",foodDetail);
        
        weakSelf.foodDetail = foodDetail;
        
        [weakSelf setupData];
        [weakSelf.tableView reloadData];
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
    }];
}

-(void)setupRightMenuButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 30, 40);
    [button setImage:[UIImage imageNamed:@"center_order"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightDrawerButton  = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
    
    //    UIBarButtonItem * rightDrawerButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"center_order"]
    //                                                                                 style:UIBarButtonItemStylePlain
    //                                                                                target:self
    //                                                                                action:@selector(rightDrawerButtonPress:)];
    //    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
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

//    // 收藏
//    if ([self userLogined]) {
//        NSString *userid = [PDAccountManager sharedInstance].userid;
//        [[PDHTTPEngine sharedInstance] collectAddWithUserid:userid food_id:@1 success:^(AFHTTPRequestOperation *operation, NSArray *list) {
//            //
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            //
//        }];
//    }
    
    // 删除收藏
    if ([self userLogined]) {
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] collectDeleteWithUserid:userid food_id:@1 success:^(AFHTTPRequestOperation *operation, NSArray *list) {
            //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
        }];
    }
    
    /*
    // 点赞
    if ([self userLogined]) {
        
        NSString *userid = [PDAccountManager sharedInstance].userid;
        [[PDHTTPEngine sharedInstance] appLikeWithUserid:userid foodid:@1 success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //
        }];
    }
     */

    
    // 
    
}

// 留言
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell commentWithData:(id)data{

    PDCommentsInputViewController *vc = [[PDCommentsInputViewController alloc] init];
    vc.foodid = self.foodid;
    vc.cookerid = _foodDetail.cook_object.cooker_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
