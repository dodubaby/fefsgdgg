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
        
        removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        removeButton.frame = CGRectMake(0, 0, 15, 20);
        removeButton.top = thumbnail.bottom+kCellLeftGap;
        removeButton.right = kAppWidth - kCellLeftGap;
        [self addSubview:removeButton];
        
    }
    
    return self;
}

-(void)configData:(id)data{
    
    PDModelNews *news = (PDModelNews *)data;
    
    name.text = news.title;
    time.text = news.time_str;
    time.right = kAppWidth - 35;
    
    if (news.img) {
        thumbnail.imageURL = [NSURL URLWithString:news.img];
    }
    
//    name.text = @"怎样做用户喜欢？";
//    time.text = @"三天前";
//    time.right = kAppWidth - 35;
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 140+40;
}


@end
