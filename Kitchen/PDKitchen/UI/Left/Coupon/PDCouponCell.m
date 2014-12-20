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

    price.text = @"price";
    status.text = @"status";
    
    [self showDebugRect];
    
}

+(CGFloat )cellHeightWithData:(id)data{
    return 80;
}

@end
