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
    
    EGOImageView *thumbnail;
    
    UILabel *name;
    UILabel *price;
    UILabel *person;
    UIButton *like;
    
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
        thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        thumbnail.frame =CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 205);
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        thumbnail.layer.borderWidth = 0.5f;
        thumbnail.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom+20, 120, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#333333"];
        
        person = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, name.bottom+kCellLeftGap, 90, 20)];
        [self addSubview:person];
        person.font = [UIFont systemFontOfSize:13];
        person.textColor = [UIColor colorWithHexString:@"#666666"];
        
        
        like = [[UIButton alloc] initWithFrame:CGRectMake(105 + kCellLeftGap, person.top, 120, 20)];
        [self addSubview:like];
        [like setTitle:@"收藏" forState:UIControlStateNormal];
        [like setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [like setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        like.titleLabel.font = [UIFont systemFontOfSize:13];
        [like setImage:[UIImage imageNamed:@"dt_up"] forState:UIControlStateNormal];
        [like setImage:[UIImage imageNamed:@"dt_up2"] forState:UIControlStateHighlighted];
        like.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        like.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [like handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:likeFoodWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self likeFoodWithData:self.data];
            }
            
        }];
        
//        like = [[UILabel alloc] initWithFrame:CGRectMake(120+15, person.top, 120, 20)];
//        [self addSubview:like];
//        like.font = [UIFont systemFontOfSize:13];
//        like.textColor = [UIColor colorWithHexString:@"#666666"];
//        
//        UIImageView *up = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dt_up"]];
//        [like addSubview:up];
//        up.left = - up.width;
//        up.top = -(up.height - like.height)/2;
        
        price = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth - kCellLeftGap -100, thumbnail.bottom+20, 100, 40)];
        price.textAlignment = NSTextAlignmentRight;
        [self addSubview:price];
        price.font = [UIFont systemFontOfSize:24];
        price.textColor = [UIColor colorWithHexString:@"#666666"];
        
        share = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, person.bottom+10, 60, 30)];
        [self addSubview:share];
        [share setTitle:@"分享" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [share setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        share.titleLabel.font = [UIFont systemFontOfSize:13];
        [share setImage:[UIImage imageNamed:@"dt_share"] forState:UIControlStateNormal];
        [share setImage:[UIImage imageNamed:@"dt_share2"] forState:UIControlStateHighlighted];
        share.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        share.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        [share handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:shareWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self shareWithData:self.data];
            }
        }];
        
        favorite = [[UIButton alloc] initWithFrame:CGRectMake(105 + kCellLeftGap, person.bottom+10, 60, 30)];
        [self addSubview:favorite];
        [favorite setTitle:@"收藏" forState:UIControlStateNormal];
        [favorite setTitle:@"已收藏" forState:UIControlStateHighlighted];
        [favorite setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [favorite setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        favorite.titleLabel.font = [UIFont systemFontOfSize:13];
        [favorite setImage:[UIImage imageNamed:@"dt_favorite"] forState:UIControlStateNormal];
        [favorite setImage:[UIImage imageNamed:@"dt_favorite2"] forState:UIControlStateHighlighted];
        favorite.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        favorite.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        [favorite handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:favoriteWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self favoriteWithData:self.data];
            }
        }];
        
        addButton = [[UIButton alloc] initWithFrame:CGRectMake(kAppWidth - 90 -kCellLeftGap*2,  person.bottom + 10, 90, 30)];
        [self addSubview:addButton];
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"#c14a41"] size:addButton.size];
        [addButton setBackgroundImage:image forState:UIControlStateNormal];
        [addButton setTitle:@"加入菜单" forState:UIControlStateNormal];
        [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        addButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        addButton.layer.cornerRadius = 4;
        addButton.clipsToBounds = YES;
        
        [addButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData: button:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:self.data button:addButton];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    PDModelFood *food = (PDModelFood *)data;
    
    name.text = food.food_name;
    person.text = [NSString stringWithFormat:@"%@人吃过",food.eat_sum];
    
    NSString *likeText = @"0";
    if (food.like_sum) {
       likeText = [NSString stringWithFormat:@"%@人",food.like_sum ];
    }
    
    CGSize size= [likeText sizeWithFontCompatible:[UIFont systemFontOfSize:13]
                                       constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                           lineBreakMode:NSLineBreakByWordWrapping];
    
    like.width = size.width + 30;
    [like setTitle:likeText forState:UIControlStateNormal];
    
    
    price.text = [NSString stringWithFormat:@"¥%@",food.price];
    [price sizeToFit];
    price.right = kAppWidth - 2*kCellLeftGap;
    
    
    if (food.food_img) {
        thumbnail.imageURL = [NSURL URLWithString:food.food_img];
    }
    if ([food.is_collect integerValue]==1) {
        favorite.highlighted=YES;
    }else{
        favorite.highlighted=NO;
    }
    
    /*
    name.text = @"肉酱面";
    person.text = @"4234人吃过";
    like.text = @"235人";
    price.text = @"¥25.5";
    [price sizeToFit];
    price.right = kAppWidth - 2*kCellLeftGap;
    //    person.text = @"person";
    
    thumbnail.image = [UIImage imageNamed:@"菜1.jpg"];

     */
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 10+205+120;
    
    //return 210;
}


@end
