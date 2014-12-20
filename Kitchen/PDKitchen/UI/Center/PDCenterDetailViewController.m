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
#import "PDCenterCell.h"
#import "PDOwnerCell.h"
#import "PDCommentCell.h"

@interface PDDetailCellItem : NSObject
@property (nonatomic,strong) Class cellClazz;
@property (nonatomic,strong) id data;

@end

@implementation PDDetailCellItem
@end


@interface PDCenterDetailViewController()

{
    NSMutableArray *list;
}

@end

@implementation PDCenterDetailViewController


- (void)setupData{
    
    list = [[NSMutableArray alloc] init];

    PDDetailCellItem *item = nil;
    item = [PDDetailCellItem new];
    item.cellClazz = [PDCenterCell class];
    [list addObject:item];
    

    item = [PDDetailCellItem new];
    item.cellClazz = [PDOwnerCell class];
    [list addObject:item];
    
    //PDCommentCell
    for (int i = 0; i<5; i++) {
        item = [PDDetailCellItem new];
        item.cellClazz = [PDCommentCell class];
        [list addObject:item];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    [self setupData];
    
    
    UIButton *seeMore = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 44)];
    [seeMore setTitle:@"查看更多评论" forState:UIControlStateNormal];
    [seeMore setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [seeMore handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
        //
        
        PDCommentsViewController *vc = [[PDCommentsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    
    self.tableView.tableFooterView = seeMore;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PDDetailCellItem *item = list[indexPath.row];
    return [item.cellClazz cellHeightWithData:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PDDetailCellItem *item = list[indexPath.row];
    
    PDBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(item.cellClazz)];
    if (!cell) {
        cell = [[item.cellClazz alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(item.cellClazz)];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    //cell.textLabel.text = list[indexPath.row];
    [cell setData:nil];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

// 分享
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell shareWithData:(id)data{

}

// 收藏
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell favoriteWithData:(id)data{

}

// 留言
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell commentWithData:(id)data{

}

@end
