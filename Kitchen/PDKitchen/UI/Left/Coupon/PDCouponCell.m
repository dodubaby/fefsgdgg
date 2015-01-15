//
//  PDCouponCell.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCouponCell.h"

@interface PDCouponCell()
{
    UIView *back;
    //UILabel *address;
    
    UILabel *price;
    UILabel *status;
    
    NSMutableArray *list;
    
}
@end

@implementation PDCouponCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        CGFloat h = [PDCouponCell cellHeightWithData:nil];
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, (h-20)/2, 100, 20)];
        [back addSubview:price];
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#999999"];
        
        status = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, (h-20)/2, 100, 20)];
        [back addSubview:status];
        status.font = [UIFont systemFontOfSize:15];
        status.textColor = [UIColor colorWithHexString:@"#999999"];
        status.textAlignment = NSTextAlignmentRight;
    }
    return self;
}

-(void)configData:(id)data{
    
    PDModelCoupon *coupon = data;
    
    price.text = [NSString stringWithFormat:@"%@元",coupon.price];
    [price sizeToFit];
    price.top = (back.height - price.height)/2;
    
    status.text = coupon.time_str;
    [status sizeToFit];
    status.top = (back.height - price.height)/2;
    status.right = back.width - kCellLeftGap;
    
    if ([coupon.is_overdue boolValue]) {  // 过期
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        price.textColor = [UIColor colorWithHexString:@"#999999"];
        status.textColor = [UIColor colorWithHexString:@"#999999"];
    }else{
        back.layer.borderColor = [[UIColor colorWithHexString:@"#c14a41"] CGColor];
        price.textColor = [UIColor colorWithHexString:@"#c14a41"];
        status.textColor = [UIColor colorWithHexString:@"#c14a41"];
    }
    

    
//    price.text = @"10元";
//    [price sizeToFit];
//    price.top = (back.height - price.height)/2;
//    
//    status.text = @"1天后过期";
//    [status sizeToFit];
//    status.top = (back.height - price.height)/2;
//    status.right = back.width - kCellLeftGap;
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 50+kCellLeftGap;
}

@end

/*
@interface PDCouponCell()
{
    UILabel *price;
    UILabel *status;
}
@end


@implementation PDCouponCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //

        
        CGFloat h = [PDCouponCell cellHeightWithData:nil];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, (h-20)/2, 100, 20)];
        [self addSubview:price];
        
        status = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth-100-3*kCellLeftGap, (h-20)/2, 100, 20)];
        [self addSubview:status];
        status.textAlignment = NSTextAlignmentRight;

    }
    
    return self;
}

-(void)configData:(id)data{

    price.text = @"10元代金券";
    status.text = @"可用";
    
    //[self showDebugRect];
    
}

+(CGFloat )cellHeightWithData:(id)data{
    return 80;
}

@end
 */
