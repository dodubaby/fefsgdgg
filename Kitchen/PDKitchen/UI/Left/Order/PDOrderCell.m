//
//  PDOrderCell.m
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderCell.h"

@interface PDOrderCell()
{
    UIView *back;
    

    EGOImageView *thumbnail;
    UILabel *name;
    UILabel *price;
    
    UILabel *total;
    
}
@end

@implementation PDOrderCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        back = [[UIView alloc] initWithFrame:CGRectZero];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        back.frame = CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth - 2*kCellLeftGap, 1*(kCellLeftGap+70)+40);
        [self addSubview:back];
        
        
        thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        [back addSubview:thumbnail];
        thumbnail.frame = CGRectMake(kCellLeftGap, kCellLeftGap, 115, 70);
        //thumbnail.image = [UIImage imageNamed:@"菜1.jpg"];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(thumbnail.right + kCellLeftGap, thumbnail.top, 200, 20)];
        [back addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(thumbnail.right + kCellLeftGap, name.bottom+5, 200, 20)];
        [back addSubview:price];
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        
        
        //price.text = @"23.5 x3";
        
        
        UILabel *totalHint = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 1*(kCellLeftGap+70)+10, 50, 20)];
        [back addSubview:totalHint];
        totalHint.font = [UIFont systemFontOfSize:15];
        totalHint.textColor = [UIColor colorWithHexString:@"#333333"];
        totalHint.text = @"共计：";
        
        total = [[UILabel alloc] initWithFrame:CGRectMake(totalHint.right+5, totalHint.top, 160, 20)];
        [back addSubview:total];
        total.font = [UIFont systemFontOfSize:15];
        total.textColor = [UIColor colorWithHexString:@"#c14a41"];
        
        //total.text = @"¥143.5";
        
        UILabel *look = [[UILabel alloc] initWithFrame:CGRectMake(back.width - 70 - kCellLeftGap, totalHint.top, 70, 20)];
        [back addSubview:look];
        look.textAlignment = NSTextAlignmentRight;
        look.font = [UIFont systemFontOfSize:15];
        look.textColor = [UIColor colorWithHexString:@"#333333"];
        look.text = @"查看";
        
    }
    return self;
}

-(void)configData:(id)data{
    
    
    PDModelOrder *order = data;
    
    if ([order.food_img length]>0) {
        thumbnail.imageURL = [NSURL URLWithString:order.food_img];
    }
    
    name.text = order.food_name;
    price.text = [NSString stringWithFormat:@"%@ x%@",order.food_price,order.food_num];

    CGFloat p = [order.food_price floatValue]*[order.food_num integerValue];
    total.text = [NSString stringWithFormat:@"¥%.02f",p];
    
    //[self showDebugRect];
}

/*
-(void)configData:(id)data{
    
    [self removeAllSubViews];
    
    back.frame = CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth - 2*kCellLeftGap, list.count*(kCellLeftGap+70)+40);
    [self addSubview:back];
    
    for (int i = 0; i<[list count]; i++) {
        EGOImageView *thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        [back addSubview:thumbnail];
        thumbnail.frame = CGRectMake(kCellLeftGap, kCellLeftGap+i*(kCellLeftGap+70), 115, 70);
        thumbnail.image = [UIImage imageNamed:@"菜1.jpg"];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(thumbnail.right + kCellLeftGap, thumbnail.top, 200, 20)];
        [back addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        name.text = list[i];
        
        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(thumbnail.right + kCellLeftGap, name.bottom+5, 200, 20)];
        [back addSubview:price];
        price.font = [UIFont systemFontOfSize:15];
        price.textColor = [UIColor colorWithHexString:@"#333333"];
        price.text = @"23.5 x3";
    }
    
    UILabel *totalHint = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, list.count*(kCellLeftGap+70)+10, 50, 20)];
    [back addSubview:totalHint];
    totalHint.font = [UIFont systemFontOfSize:15];
    totalHint.textColor = [UIColor colorWithHexString:@"#333333"];
    totalHint.text = @"共计：";
    
    UILabel *total = [[UILabel alloc] initWithFrame:CGRectMake(totalHint.right+5, totalHint.top, 160, 20)];
    [back addSubview:total];
    total.font = [UIFont systemFontOfSize:15];
    total.textColor = [UIColor colorWithHexString:@"#c14a41"];
    total.text = @"¥143.5";
    
    UILabel *look = [[UILabel alloc] initWithFrame:CGRectMake(back.width - 70 - kCellLeftGap, totalHint.top, 70, 20)];
    [back addSubview:look];
    look.textAlignment = NSTextAlignmentRight;
    look.font = [UIFont systemFontOfSize:15];
    look.textColor = [UIColor colorWithHexString:@"#333333"];
    look.text = @"查看";
    
    //[self showDebugRect];
}
 */

+(CGFloat )cellHeightWithData:(id)data{
    
    // n*height+ 40 + gap
    
    return (kCellLeftGap+70)+40+kCellLeftGap;
}

@end
