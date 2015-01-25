//
//  PDNewsCell.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDNewsCell.h"


@interface PDNewsCell()
{
    
    UIView *back;
    
    EGOImageView *thumbnail;
    UIImageView *mark;
    
    UILabel *name;
    UILabel *time;
    UILabel *person;
    UILabel *from;
    
    UIButton *removeButton;
}
@end

@implementation PDNewsCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, (kAppWidth-2*kCellLeftGap)*280.0f/680+10+30)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"cm_food"]];
        thumbnail.frame = CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, (kAppWidth-2*kCellLeftGap)*280.0f/680);
        
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        thumbnail.layer.borderWidth = 0.5f;
        thumbnail.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        mark = [[UIImageView alloc] initWithFrame:CGRectMake(thumbnail.width - 32, 5, 27, 27)];
        [thumbnail addSubview:mark];
        mark.backgroundColor = [UIColor clearColor];
        mark.image = [UIImage imageNamed:@"news_mark"];
        mark.hidden = YES;
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, thumbnail.bottom+kCellLeftGap, 220, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:15];
        name.textColor = [UIColor colorWithHexString:@"#666666"];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(0, thumbnail.bottom+kCellLeftGap, 70, 20)];
        [self addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
        time.font = [UIFont systemFontOfSize:12];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        
        removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        removeButton.frame = CGRectMake(0, 0, 30, 30);
        removeButton.top = thumbnail.bottom+kCellLeftGap-5;
        removeButton.right = kAppWidth - kCellLeftGap;
        [self addSubview:removeButton];
        
        [removeButton setBackgroundImage:[UIImage imageNamed:@"news_delete"] forState:UIControlStateNormal];
        
        
        [removeButton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            //
            if(self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:deleteNewsWithData:)]){
                [self.delegate pdBaseTableViewCellDelegate:self deleteNewsWithData:self.data];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    PDModelNews *news = (PDModelNews *)data;
    
    name.text = news.title;
    time.text = news.time_str;
    time.right = kAppWidth - 38;
    
    if (news.img) {
        thumbnail.imageURL = [NSURL URLWithString:news.img];
    }
    
    if ([news.is_read boolValue]) { // 新标签
        mark.hidden = YES;
    }else{
        mark.hidden = NO;
    }
    
//    name.text = @"怎样做用户喜欢？";
//    time.text = @"三天前";
//    time.right = kAppWidth - 35;
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return (kAppWidth-2*kCellLeftGap)*280.0f/680+10+40;
}


@end
