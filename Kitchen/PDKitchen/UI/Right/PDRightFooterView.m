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
    
    UIImageView *line;
             
    UILabel *price;
    UIButton *submit;
    
}

@end

@implementation PDRightFooterView

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1.0)];
        [self addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
        [self addSubview:price];
        price.textAlignment = NSTextAlignmentRight;
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#666666"];
        price.text = nil;
        
        submit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        [self addSubview:submit];
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:submit.size];
        [submit setBackgroundImage:image forState:UIControlStateNormal];
        [submit setTitle:@"提交订单" forState:UIControlStateNormal];
        submit.backgroundColor = [UIColor colorWithHexString:@"#c14a41"];
        [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        submit.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        submit.layer.cornerRadius = 4;
        submit.clipsToBounds = YES;
        
        [submit handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdRightFooterView:submitWithTotal:)]) {
                [self.delegate pdRightFooterView:self submitWithTotal:0];
            }
        }];
        
        //[self showDebugRect];
    }
    
    return self;
}

-(void)setTotalPrice:(NSString *)totalPrice{
    _totalPrice = totalPrice;
    
    price.text = _totalPrice;
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    [price sizeToFit];
    
    NSLog(@"%f",self.width);
    
    price.frame = CGRectMake(self.width - price.width - 10, 10, price.width, price.height);
    submit.frame = CGRectMake(self.width - submit.width - 10, price.bottom+10, submit.width, submit.height);
    
}

@end
