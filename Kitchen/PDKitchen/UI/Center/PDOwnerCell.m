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
    UIView *back;
    
    EGOImageView *avatar;
    UILabel *name;
    UIButton *comment;
    
    UILabel *about;
    
    UIImageView *line;
    
    UILabel *age;
    UILabel *hometown;
    UILabel *skill;
    
    UILabel *ageHint;
    UILabel *hometownHint;
    UILabel *skillHint;

    
}
@end

@implementation PDOwnerCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth - 2*10, 250)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        //
//        share = [[UIButton alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, 50, 30)];
//        [self addSubview:share];
//        [share setTitle:@"分享" forState:UIControlStateNormal];
//        [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
//        [share handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:shareWithData:)]) {
//                [self.delegate pdBaseTableViewCellDelegate:self shareWithData:nil];
//            }
//        }];
//        
//        
//        favorite = [[UIButton alloc] initWithFrame:CGRectMake(share.right + kCellLeftGap, kCellLeftGap, 50, 30)];
//        [self addSubview:favorite];
//        [favorite setTitle:@"收藏" forState:UIControlStateNormal];
//        [favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
//        [favorite handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
//            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:favoriteWithData:)]) {
//                [self.delegate pdBaseTableViewCellDelegate:self favoriteWithData:nil];
//            }
//        }];
        
        avatar = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_owner"]];
        avatar.frame = CGRectMake(10, 10, 45, 45);
        [back addSubview:avatar];
        avatar.backgroundColor = [UIColor clearColor];
        avatar.layer.borderWidth = 0.5f;
        avatar.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(avatar.right + kCellLeftGap, avatar.top+10, 90, 20)];
        [back addSubview:name];
        name.font = [UIFont systemFontOfSize:14];
        name.textColor = [UIColor colorWithHexString:@"#666666"];
        
        comment = [[UIButton alloc] initWithFrame:CGRectMake(back.width - 90 -10, avatar.top+10, 90,30)];
        [back addSubview:comment];
        [comment setTitle:@"给厨师留言" forState:UIControlStateNormal];
        [comment setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        comment.titleLabel.font = [UIFont systemFontOfSize:14];
        comment.layer.cornerRadius = 4;
        comment.layer.borderWidth = 0.5f;
        comment.layer.borderColor = [UIColor colorWithHexString:@"#c14a41"].CGColor;
        
        [comment handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:commentWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self commentWithData:nil];
            }
        }];
        
        about = [[UILabel alloc] initWithFrame:CGRectMake(avatar.left, avatar.bottom +10, back.width-35-10, 20)];
        [back addSubview:about];
        about.numberOfLines = 0;
        about.font = [UIFont systemFontOfSize:13];
        about.textColor = [UIColor colorWithHexString:@"#999999"];
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, back.width - 20, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        [back addSubview:line];
        
        CGFloat w = (back.width - 20)/3.0f;
        
        age = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, w, 20)];
        [back addSubview:age];
        age.textAlignment = NSTextAlignmentCenter;
        age.font = [UIFont systemFontOfSize:18];
        age.textColor = [UIColor colorWithHexString:@"#666666"];
        
        hometown = [[UILabel alloc] initWithFrame:CGRectMake(age.right, 0, w, 20)];
        [back addSubview:hometown];
        hometown.textAlignment = NSTextAlignmentCenter;
        hometown.font = [UIFont systemFontOfSize:18];
        hometown.textColor = [UIColor colorWithHexString:@"#666666"];
        
        skill = [[UILabel alloc] initWithFrame:CGRectMake(hometown.right, 0, w, 20)];
        [back addSubview:skill];
        skill.textAlignment = NSTextAlignmentCenter;
        skill.font = [UIFont systemFontOfSize:18];
        skill.textColor = [UIColor colorWithHexString:@"#666666"];
        
        ageHint = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, w, 20)];
        [back addSubview:ageHint];
        ageHint.textAlignment = NSTextAlignmentCenter;
        ageHint.font = [UIFont systemFontOfSize:12];
        ageHint.textColor = [UIColor colorWithHexString:@"#999999"];
        ageHint.text = @"厨师年龄";
        
        hometownHint = [[UILabel alloc] initWithFrame:CGRectMake(age.right, 0, w, 20)];
        [back addSubview:hometownHint];
        hometownHint.textAlignment = NSTextAlignmentCenter;
        hometownHint.font = [UIFont systemFontOfSize:12];
        hometownHint.textColor = [UIColor colorWithHexString:@"#999999"];
        hometownHint.text = @"厨师籍贯";
        
        skillHint = [[UILabel alloc] initWithFrame:CGRectMake(hometown.right, 0, w, 20)];
        [back addSubview:skillHint];
        skillHint.textAlignment = NSTextAlignmentCenter;
        skillHint.font = [UIFont systemFontOfSize:12];
        skillHint.textColor = [UIColor colorWithHexString:@"#999999"];
        skillHint.text = @"擅长菜系";
    }
    
    return self;
}

-(void)configData:(id)data{
    
    PDModelCooker *cooker = (PDModelCooker *)data;
    name.text = cooker.cooker_name;
    age.text = cooker.age;
    hometown.text = cooker.cooker_from;
    skill.text = cooker.specialty;//@"川菜湘菜";
    //avatar.image = [UIImage imageNamed:@"厨师.jpg"];
    if (cooker.img) {
        avatar.imageURL = [NSURL URLWithString:cooker.img];
    }
    about.text = cooker.about;
    [about sizeToFit];
    
    line.top = about.bottom +12;
    
    age.top = hometown.top = skill.top = line.top + 10;
    
    ageHint.top = hometownHint.top = skillHint.top = age.bottom + 10;
    
    back.height = ageHint.bottom + 10;
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    PDModelCooker *cooker = (PDModelCooker *)data;
    
    CGFloat h = 0;
    
    // 电话高度
    h = h  + 20;
    
    // 头像高度
    h = h + 15 +45 + 10;
    
    // 介绍高度
    CGSize size= [cooker.about sizeWithFontCompatible:[UIFont systemFontOfSize:12]
                                    constrainedToSize:CGSizeMake(kAppWidth-2*kCellLeftGap-35-10, MAXFLOAT)
                                        lineBreakMode:NSLineBreakByWordWrapping];
    h = h + size.height + 10;
    
    // 附加高度
    h = h+20+10+20+10+10;

    return h;
}

@end
