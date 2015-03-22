//
//  PDOrderDetailView.m
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderDetailView.h"

@interface PDOrderDetailView ()
{
    UILabel *foodlab;
    UILabel *logisticslab;
    UILabel *eattimelab;
    UILabel *priceDetail;
    UILabel *addresslab;
    
}
@end
@implementation PDOrderDetailView


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        int leftinset=24;
        int updownspace=15;
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 0.5)];
        [self addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
        foodlab=[[UILabel alloc] initWithFrame:CGRectMake(leftinset, 30, kAppWidth-2*leftinset, 20)];
        foodlab.font = [UIFont systemFontOfSize:15];
        foodlab.textColor = [UIColor colorWithHexString:@"#333333"];
        logisticslab=[[UILabel alloc] initWithFrame:CGRectMake(leftinset, foodlab.bottom+updownspace, kAppWidth-2*leftinset, 20)];
        logisticslab.font = [UIFont systemFontOfSize:15];
        logisticslab.textColor = [UIColor colorWithHexString:@"#333333"];
        eattimelab=[[UILabel alloc] initWithFrame:CGRectMake(leftinset, logisticslab.bottom+updownspace, kAppWidth-2*leftinset, 20)];
        eattimelab.font = [UIFont systemFontOfSize:15];
        eattimelab.textColor = [UIColor colorWithHexString:@"#333333"];
        priceDetail=[[UILabel alloc] initWithFrame:CGRectMake(leftinset, eattimelab.bottom+updownspace, kAppWidth-2*leftinset, 20)];
        priceDetail.font = [UIFont systemFontOfSize:15];
        priceDetail.textColor = [UIColor colorWithHexString:@"#333333"];
        addresslab=[[UILabel alloc] initWithFrame:CGRectMake(leftinset, priceDetail.bottom+updownspace, kAppWidth-2*leftinset, 20)];
        addresslab.font = [UIFont systemFontOfSize:15];
        addresslab.textColor = [UIColor colorWithHexString:@"#333333"];
        [self addSubview:foodlab];
        [self addSubview:logisticslab];
        [self addSubview:eattimelab];
        [self addSubview:priceDetail];
        [self addSubview:addresslab];
        
    }
    return self;
}
-(void)configData:(PDModelOrderDetail*)orderdetail
{
    _order_detail=orderdetail;
    foodlab.text=[NSString stringWithFormat:@"%@ %@元   x%@",orderdetail.food_object.name,orderdetail.food_object.price,orderdetail.food_object.num];
    logisticslab.text=[NSString stringWithFormat:@"配送费：%@元",orderdetail.order_object.send_price];
    eattimelab.text=[NSString stringWithFormat:@"就餐时间：%@",orderdetail.order_object.eat_time];
    priceDetail.text=[NSString stringWithFormat:@"优惠券：%@元 还需支付%@元",orderdetail.order_object.coupon_price,orderdetail.order_object.money];
    addresslab.text=[NSString stringWithFormat:@"配送地址：%@",orderdetail.order_object.address];
    
}

@end
