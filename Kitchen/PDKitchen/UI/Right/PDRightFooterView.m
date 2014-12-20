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
        price.textAlignment = NSTextAlignmentCenter;
        
        price.text = @"total: ¥300";
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        [self addSubview:submit];
        [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [submit setTitle:@"submit" forState:UIControlStateNormal];
        
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
    price.text = [NSString stringWithFormat: @"total: ¥%.2f",_totalPrice];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    price.frame = CGRectMake((self.width - price.width)/2, 10, price.width, price.height);
    submit.frame = CGRectMake((self.width - submit.width)/2, 60, submit.width, submit.height);
    
}

@end
