//
//  PDCenterCell.m
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCenterCell.h"


@interface PDCenterCell()
{

    UIImageView *thumbnail;
    UIImageView *avatar;
    
    UILabel *name;
    UILabel *price;
    UILabel *person;
    UILabel *from;
    
    UIButton *addButton;
}
@end

@implementation PDCenterCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        //NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 130)];
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, thumbnail.height - 40, 40, 40)];
        [thumbnail addSubview:avatar];
        avatar.backgroundColor = [UIColor clearColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom+kCellLeftGap, 120, 20)];
        [self addSubview:name];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(name.right+kCellLeftGap, thumbnail.bottom+kCellLeftGap, 70, 20)];
        [self addSubview:price];
        
        person = [[UILabel alloc] initWithFrame:CGRectMake(price.right+kCellLeftGap, thumbnail.bottom+kCellLeftGap, 100, 20)];
        [self addSubview:person];
        
        from = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, name.bottom+kCellLeftGap, 120, 20)];
        [self addSubview:from];
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth - 20-kCellLeftGap, name.bottom+kCellLeftGap, 20, 20)];
        [self addSubview:addButton];
        [addButton setTitle:@"+" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{

    name.text = @"name";
    price.text = @"price";
    person.text = @"person";
    [person sizeToFit];
    from.text = @"from";
    
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 210;
}

@end
