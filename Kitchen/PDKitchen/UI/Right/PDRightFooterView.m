//
//  PDRightFooterView.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDRightFooterView.h"

@interface PDRightFooterView()
{
    
    UILabel *price;
    UIButton *submit;
}

@end

@implementation PDRightFooterView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        [self addSubview:price];
        price.textAlignment = NSTextAlignmentRight;
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#666666"];
        price.text = @"3份美食 共计113元";
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        [self addSubview:submit];
        [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submit setTitle:@"提交订单" forState:UIControlStateNormal];
        submit.backgroundColor = [UIColor colorWithHexString:@"#c14a41"];
        [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        submit.layer.cornerRadius = 4;
        
        
        [submit handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdRightFooterView:submitWithTotal:)]) {
                [self.delegate pdRightFooterView:self submitWithTotal:self.totalPrice];
            }
        }];
        
        [self showDebugRect];
    }
    
    return self;
}

-(void)setTotalPrice:(CGFloat)totalPrice{

    _totalPrice = totalPrice;
    price.text = [NSString stringWithFormat: @"3份美食 共计113元"];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    [price sizeToFit];
    price.frame = CGRectMake(self.width - price.width - 10, 10, price.width, price.height);
    submit.frame = CGRectMake(self.width - submit.width - 10, price.bottom+10, submit.width, submit.height);
    
}

@end
