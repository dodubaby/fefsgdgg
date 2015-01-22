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

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 减少
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell reduceWithData:(id)data;
// 增加
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addWithData:(id)data;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 添加订单
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell addOrderWithData:(id)data;

// 赞菜品
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell likeFoodWithData:(id)data;

// 分享
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell shareWithData:(id)data;

// 收藏
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell favoriteWithData:(id)data;

// 留言
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell commentWithData:(id)data;

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// 删除消息
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell deleteNewsWithData:(id)data;

// 赞消息
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell likeNewsWithData:(id)data;

// 地址管理
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell deleteAddressWithData:(id)data;

// 开始输入手机号
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell phoneTextFieldDidBeginEditing:(UITextField *)textField;

// 开始输入其它要求
-(void)pdBaseTableViewCellDelegate:(PDBaseTableViewCell *)cell requestTextViewDidBeginEditing:(UITextView *)textView;

@end
