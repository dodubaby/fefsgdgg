//
//  PDRightCell.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDRightCell.h"


@interface PDRightCell()
{
    
    CGFloat buttonStartX;
    
    UILabel *name;
    UILabel *price;
    
    UILabel *count;
    
    UIButton *reduceButton;
    UIButton *addButton;
    
    NSInteger amount;
}


@end

@implementation PDRightCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //

        
        
        if (kAppWidth>320) {
            buttonStartX = 180;
        }else{
            buttonStartX = 135;
        }
        
        amount = 3;
        
        CGFloat h = [PDRightCell cellHeightWithData:nil];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, (h-20)/2, 80, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(name.right+kCellLeftGap, (h-20)/2, 60, 20)];
        [self addSubview:price];
        price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        
        count = [[UILabel alloc] initWithFrame:CGRectMake(buttonStartX, (h-20)/2, 70, 20)];
        [self addSubview:count];
        count.textAlignment = NSTextAlignmentCenter;
        count.font = [UIFont systemFontOfSize:15];
        count.textColor = [UIColor colorWithHexString:@"#333333"];
        
        reduceButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartX, (h-20)/2, 20, 20)];
        [self addSubview:reduceButton];
        [reduceButton setTitle:@"-" forState:UIControlStateNormal];
        [reduceButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartX+50, (h-20)/2, 20, 20)];
        [self addSubview:addButton];
        [addButton setTitle:@"+" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // ------
        [reduceButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            //
            amount--;
            count.text = [NSString stringWithFormat:@"%ld",amount];
            
            NSLog(@"%ld",amount);
            
            
            if (self.delegate
                &&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:reduceWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self reduceWithData:nil];
            }
        }];
        
        // ++++++
        [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            //
            amount++;
            count.text = [NSString stringWithFormat:@"%ld",amount];
            
            NSLog(@"%ld",amount);
            
            if (self.delegate
                &&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addWithData:nil];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    name.text = @"name";
    price.text = @"30";
    [price sizeToFit];
    
    count.text = [NSString stringWithFormat:@"%ld",amount];
    
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 55;
}


@end
