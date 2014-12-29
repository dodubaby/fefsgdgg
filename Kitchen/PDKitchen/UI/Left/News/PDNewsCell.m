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
    
    UIImageView *thumbnail;
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
        
        
        NSLog(@"self.width == %f",self.width);
        
        thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, 130)];
        [self addSubview:thumbnail];
        thumbnail.backgroundColor = [UIColor clearColor];
        
        mark = [[UIImageView alloc] initWithFrame:CGRectMake(thumbnail.width - 40, 0, 40, 40)];
        [thumbnail addSubview:mark];
        mark.backgroundColor = [UIColor clearColor];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom+kCellLeftGap, 120, 20)];
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
    
    name.text = @"怎样做用户喜欢？";
    time.text = @"三天前";
    time.right = kAppWidth - 35;
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 140+35;
}


@end
