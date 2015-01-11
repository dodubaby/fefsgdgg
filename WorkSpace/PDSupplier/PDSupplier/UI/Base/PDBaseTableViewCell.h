//
//  PDBaseTableViewCell.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDUtils.h"
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

// 确认订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell confirmOrderWithData:(id)data;

// 完成订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell finishOrderWithData:(id)data;
// 取消订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell refundOrderWithData:(id)data;


@end
