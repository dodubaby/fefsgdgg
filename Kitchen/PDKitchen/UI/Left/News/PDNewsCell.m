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
    
    UIButton *addButton;
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
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, thumbnail.bottom-kCellLeftGap-20, 120, 20)];
        [thumbnail addSubview:name];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(name.right+kCellLeftGap, thumbnail.bottom-kCellLeftGap-20, 70, 20)];
        [thumbnail addSubview:time];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    name.text = @"name";
    time.text = @"time";
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 150;
}


@end
