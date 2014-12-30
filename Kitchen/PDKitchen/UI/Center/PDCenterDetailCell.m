//
//  PDCenterDetailCell.m
//  PDKitchen
//
//  Created by bright on 14/12/30.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCenterDetailCell.h"

@interface PDCenterDetailCell()
{
    
    UIImageView *thumbnail;
    
    UILabel *name;
    UILabel *price;
    UILabel *person;
    UILabel *like;
    
    UIButton *share;
    UIButton *favorite;
    
    UIButton *addButton;
}
@end

@implementation PDCenterDetailCell



-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        
        
        //NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 205)];
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        thumbnail.layer.borderWidth = 0.5f;
        thumbnail.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom+20, 120, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        person = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, name.bottom+kCellLeftGap, 100, 20)];
        [self addSubview:person];
        person.font = [UIFont systemFontOfSize:13];
        person.textColor = [UIColor colorWithHexString:@"#666666"];
        
        like = [[UILabel alloc] initWithFrame:CGRectMake(120, person.top, 120, 20)];
        [self addSubview:like];
        like.font = [UIFont systemFontOfSize:13];
        like.textColor = [UIColor colorWithHexString:@"#666666"];
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth - kCellLeftGap -100, thumbnail.bottom+20, 100, 40)];
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        price.font = [UIFont systemFontOfSize:30];
        
        share = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, person.bottom+10, 50, 30)];
        [self addSubview:share];
        [share setTitle:@"分享" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [share handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:shareWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self shareWithData:nil];
            }
        }];
        
        
        favorite = [[UIButton alloc] initWithFrame:CGRectMake(share.right + kCellLeftGap, person.bottom+10, 50, 30)];
        [self addSubview:favorite];
        [favorite setTitle:@"收藏" forState:UIControlStateNormal];
        [favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [favorite handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:favoriteWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self favoriteWithData:nil];
            }
        }];
        
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth - 90 -kCellLeftGap,  person.bottom + 10, 90, 30)];
        [self addSubview:addButton];
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:addButton.size];
        [addButton setBackgroundImage:image forState:UIControlStateNormal];
        [addButton setTitle:@"加入菜单" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        addButton.layer.cornerRadius = 4;
        addButton.clipsToBounds = YES;
        
        [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    name.text = @"肉酱面";
    person.text = @"4234人吃过";
    like.text = @"235人";
    price.text = @"25.5";
    [price sizeToFit];
    price.right = kAppWidth - kCellLeftGap;
    //    person.text = @"person";
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 10+205+120;
    
    //return 210;
}


@end
