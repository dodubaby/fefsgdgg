//
//  PDBaseTableViewCell.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDUtils.h"
#import "PDModel.h"
#import "UIKit+AFNetworking.h"


#define kCellLeftGap 10

@protocol PDBaseTableViewCellDelegate;
@interface PDBaseTableViewCell : UITableViewCell

@property(nonatomic,weak) id<PDBaseTableViewCellDelegate> delegate;
@property (nonatomic,strong) id data;

-(void)configData:(id)data;

+ (CGFloat )cellHeightWithData:(id)data;

@end

@protocol PDBaseTableViewCellDelegate <NSObject>

@optional

// example
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell;

// 添加订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data;

// 减少
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell reduceWithData:(id)data;
// 增加
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addWithData:(id)data;

// 分享
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell shareWithData:(id)data;

// 收藏
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell favoriteWithData:(id)data;

// 留言
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell commentWithData:(id)data;

@end
