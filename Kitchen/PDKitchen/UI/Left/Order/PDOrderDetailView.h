//
//  PDOrderDetailView.h
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDBaseView.h"
#import "PDModel.h"

/**
 *  订单详情
 */

@interface PDOrderDetailView : PDBaseView
-(void)configData:(PDModelOrderDetail*)orderdetail;

@property(nonatomic,strong)PDModelOrderDetail *order_detail;
@end
