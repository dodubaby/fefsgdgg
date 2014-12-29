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
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 205)];
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom + 15, 45, 45)];
        [self addSubview:avatar];
        avatar.backgroundColor = [UIColor clearColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + kCellLeftGap, avatar.top, 120, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth - kCellLeftGap -100, thumbnail.bottom+20, 100, 40)];
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        price.font = [UIFont systemFontOfSize:30];
        
//        person = [[UILabel alloc] initWithFrame:CGRectMake(price.right+kCellLeftGap, thumbnail.bottom+kCellLeftGap, 100, 20)];
//        [self addSubview:person];
        
        from = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + kCellLeftGap, avatar.top + 22, 120, 20)];
        [self addSubview:from];
        from.font = [UIFont systemFontOfSize:13];
        from.textColor = [UIColor colorWithHexString:@"#666666"];
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth - 90 -kCellLeftGap, avatar.bottom +5, 90, 30)];
        [self addSubview:addButton];
        addButton.backgroundColor = [UIColor colorWithHexString:@"#c14a41"];
        [addButton setTitle:@"加入菜单" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        addButton.layer.cornerRadius = 4;
        
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
    [price sizeToFit];
    price.right = kAppWidth - kCellLeftGap;
//    person.text = @"person";
    [person sizeToFit];
    from.text = @"from";
    
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 10+205+120;
    
    //return 210;
}

@end
