//
//  PDOwnerCell.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOwnerCell.h"

@interface PDOwnerCell()
{
    UIButton *share;
    UIButton *favorite;
    
    UILabel *phone;
    
    UIImageView *avatar;
    UILabel *name;
    
    UILabel *age;
    UILabel *hometown;
    UILabel *skill;
    
    UILabel *about;
    
    UIButton *comment;
    
}
@end

@implementation PDOwnerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        share = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, 50, 30)];
        [self addSubview:share];
        [share setTitle:@"分享" forState:UIControlStateNormal];
        [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [share handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:shareWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self shareWithData:nil];
            }
        }];
        
        
        favorite = [[UIButton alloc] initWithFrame:CGRectMake(share.right + kCellLeftGap, kCellLeftGap, 50, 30)];
        [self addSubview:favorite];
        [favorite setTitle:@"收藏" forState:UIControlStateNormal];
        [favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [favorite handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:favoriteWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self favoriteWithData:nil];
            }
        }];
        
        phone = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, share.bottom + kCellLeftGap, kAppWidth - 2*kCellLeftGap, 20)];
        [self addSubview:phone];
        
        
        avatar = [[UIImageView alloc] initWithFrame:CGRectMake((kAppWidth-60)/2, phone.bottom + kCellLeftGap, 80, 80)];
        [self addSubview:avatar];
        
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + kCellLeftGap, phone.bottom + kCellLeftGap+40, 90, 20)];
        [self addSubview:name];
        
        CGFloat w = (kAppWidth - 4*kCellLeftGap)/3.0f;
        
        age = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, avatar.bottom + kCellLeftGap, w, 20)];
        [self addSubview:age];
        age.textAlignment = NSTextAlignmentCenter;
        
        hometown = [[UILabel alloc] initWithFrame:CGRectMake(age.right + kCellLeftGap, avatar.bottom + kCellLeftGap, w, 20)];
        [self addSubview:hometown];
        hometown.textAlignment = NSTextAlignmentCenter;
        
        skill = [[UILabel alloc] initWithFrame:CGRectMake(hometown.right + kCellLeftGap, avatar.bottom + kCellLeftGap, w, 20)];
        [self addSubview:skill];
        skill.textAlignment = NSTextAlignmentCenter;
        
        about = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, age.bottom + kCellLeftGap, kAppWidth-2*kCellLeftGap, 20)];
        [self addSubview:about];
        about.numberOfLines = 0;
        about.font = [UIFont systemFontOfSize:14];
        
        
        comment = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, about.bottom+kCellLeftGap, 110,30)];
        [self addSubview:comment];
        [comment setTitle:@"给厨师留言" forState:UIControlStateNormal];
        [comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [comment handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:commentWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self commentWithData:nil];
            }
        }];
        
    }
    
    return self;
}

-(void)configData:(id)data{
    
    phone.text = @"订餐电话：24547687698798";
    
    name.text = @"超级大厨";
    
    age.text = @"43";
    hometown.text = @"四川";
    skill.text = @"川菜，湘菜";
    
    about.text = kCellContent;
    [about sizeToFit];
    
    comment.top = about.bottom+kCellLeftGap;
}


+(CGFloat )cellHeightWithData:(id)data{
    return 350;
}

@end
