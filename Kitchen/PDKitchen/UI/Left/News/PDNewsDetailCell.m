//
//  PDNewsDetailCell.m
//  PDKitchen
//
//  Created by bright on 15/1/13.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDNewsDetailCell.h"

@interface PDNewsDetailCell()
{
    
    UIView *back;
    
    EGOImageView *thumbnail;
    UIImageView *mark;
    
    UILabel *name;
    UILabel *time;
    
    
    UILabel *content;
    
    UILabel *read;
    UIButton *like;
}

@end

@implementation PDNewsDetailCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 140+30)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        thumbnail.frame = CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 130);
        
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        thumbnail.layer.borderWidth = 0.5f;
        thumbnail.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        mark = [[UIImageView alloc] initWithFrame:CGRectMake(thumbnail.width - 32, 5, 27, 27)];
        [thumbnail addSubview:mark];
        mark.backgroundColor = [UIColor clearColor];
        mark.image = [UIImage imageNamed:@"news_mark"];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, thumbnail.bottom+kCellLeftGap, 220, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#666666"];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(0, thumbnail.bottom+kCellLeftGap, 70, 20)];
        [self addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
        time.font = [UIFont systemFontOfSize:12];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, name.bottom+2*kCellLeftGap,kAppWidth-4*kCellLeftGap , 0)];
        [self addSubview:content];
        content.numberOfLines = 0;
        content.font = [UIFont systemFontOfSize:15];
        content.textColor = [UIColor colorWithHexString:@"#666666"];
        
        read = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, 0, 220, 20)];
        [self addSubview:read];
        read.font = [UIFont systemFontOfSize:15];
        read.textColor = [UIColor colorWithHexString:@"#666666"];
        
        like = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        [self addSubview:like];
        [like setTitle:@"收藏" forState:UIControlStateNormal];
        [like setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [like setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateHighlighted];
        like.titleLabel.font = [UIFont systemFontOfSize:15];
        [like setImage:[UIImage imageNamed:@"dt_up"] forState:UIControlStateNormal];
        [like setImage:[UIImage imageNamed:@"dt_up2"] forState:UIControlStateHighlighted];
        like.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        like.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        
        [like handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            //
            if(self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:likeNewsWithData:)]){
                [self.delegate pdBaseTableViewCellDelegate:self likeNewsWithData:self.data];
            }
        }];
    }
    return self;
}

-(void)configData:(id)data{
    
    PDModelNews *news = (PDModelNews *)data;
    
    name.text = news.title;
    time.text = news.time_str;
    time.right = kAppWidth - 2*kCellLeftGap;
    
    if (news.img) {
        thumbnail.imageURL = [NSURL URLWithString:news.img];
    }
    
    if ([news.is_read boolValue]) { // 新标签
        mark.hidden = YES;
    }else{
        mark.hidden = NO;
    }
    
    CGSize size= [news.contents sizeWithFontCompatible:[UIFont systemFontOfSize:15]
                                     constrainedToSize:CGSizeMake(kAppWidth-4*kCellLeftGap, MAXFLOAT)
                                         lineBreakMode:NSLineBreakByWordWrapping];
    content.height = size.height;
    content.text = news.contents;
    
    
    
    if (140+40+size.height+50+20+2*kCellLeftGap+kCellLeftGap<kAppHeight-64) { // 小于屏幕高度
        read.text = [NSString stringWithFormat:@"阅读%@",news.read];
        read.top = kAppHeight-64-30;
        
        NSString *likeText = @"0";
        if (news.like) {
            likeText = news.like;
        }
        
        [like setTitle:likeText forState:UIControlStateNormal];
        CGSize likeTextSize= [likeText sizeWithFontCompatible:[UIFont systemFontOfSize:13]
                                            constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        like.width = likeTextSize.width + 30;
        like.top = read.top - 5;
        like.right = kAppWidth - 10;
        
        back.height = kAppHeight-64-kCellLeftGap;
        
    }else{
    
        read.text = [NSString stringWithFormat:@"阅读%@",news.read];
        read.top = content.bottom + 50;
        
        NSString *likeText = @"0";
        if (news.like) {
            likeText = news.like;
        }
        
        [like setTitle:likeText forState:UIControlStateNormal];
        CGSize likeTextSize= [likeText sizeWithFontCompatible:[UIFont systemFontOfSize:13]
                                            constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                                                lineBreakMode:NSLineBreakByWordWrapping];
        
        like.width = likeTextSize.width + 30;
        like.top = read.top - 5;
        like.right = kAppWidth - 10;
        
        back.height = read.bottom - thumbnail.top+kCellLeftGap;
    }
    
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    PDModelNews *news = (PDModelNews *)data;
    // 内容高度
    CGSize size= [news.contents sizeWithFontCompatible:[UIFont systemFontOfSize:15]
                                    constrainedToSize:CGSizeMake(kAppWidth-4*kCellLeftGap, MAXFLOAT)
                                        lineBreakMode:NSLineBreakByWordWrapping];
    if (140+40+size.height+50+20+2*kCellLeftGap+kCellLeftGap<kAppHeight-64) { // 小于屏幕高度
        
        return kAppHeight-64+kCellLeftGap;
    }
    
    return 140+40+size.height+50+20+2*kCellLeftGap+kCellLeftGap;
}

@end
