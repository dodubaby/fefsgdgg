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
    
    UIImageView *line;
    
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

        buttonStartX = 155;
        
        amount = 3;
        CGFloat h = [PDRightCell cellHeightWithData:nil];
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kAppWidth, 1.0)];
        [self addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, (h-20)/2, 100, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:13];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(name.right+kCellLeftGap, (h-20)/2, 60, 20)];
        [self addSubview:price];
        price.backgroundColor = [UIColor clearColor];
        price.font = [UIFont systemFontOfSize:13];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        
        count = [[UILabel alloc] initWithFrame:CGRectMake(buttonStartX, (h-20)/2, 90, 20)];
        [self addSubview:count];
        count.textAlignment = NSTextAlignmentCenter;
        count.font = [UIFont systemFontOfSize:13];
        count.textColor = [UIColor colorWithHexString:@"#333333"];
        
        CGFloat cellHeight = [[self class] cellHeightWithData:nil];
    
        reduceButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartX, (cellHeight-40)/2, 40, 40)];
        [self addSubview:reduceButton];
        [reduceButton setImage:[UIImage imageNamed:@"od_reduce"] forState:UIControlStateNormal];
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonStartX+50, (cellHeight-40)/2, 40, 40)];
        [self addSubview:addButton];
        [addButton setImage:[UIImage imageNamed:@"od_add"] forState:UIControlStateNormal];
        
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
    
    name.text = @"红烧肉红烧肉";
    price.text = @"¥30";
    [price sizeToFit];
    
    count.text = [NSString stringWithFormat:@"%ld",amount];
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 55;
}


@end
