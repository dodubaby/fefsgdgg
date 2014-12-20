//
//  PDCommentCell.m
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDCommentCell.h"

@interface  PDCommentCell()
{
    UILabel *name;
    UILabel *content;
    UILabel *time;
}

@end

@implementation PDCommentCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap-120, 20)];
        [self addSubview:name];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-120, kCellLeftGap, 120, 20)];
        [self addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, name.bottom+kCellLeftGap, kAppWidth-2*kCellLeftGap, 0)];
        [self addSubview:content];
        content.font = [UIFont systemFontOfSize:14];
        content.lineBreakMode = NSLineBreakByWordWrapping;
        content.numberOfLines = 0;
        
    }
    
    return self;
}

-(void)configData:(id)data{

    name.text = @"123243534566";
    time.text = @"3 day ago";
    
    content.text = kCellContent;
    [content sizeToFit];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    CGFloat h = 3*kCellLeftGap+20;
    
    CGSize size= [kCellContent sizeWithFontCompatible:[UIFont systemFontOfSize:14]
                                             constrainedToSize:CGSizeMake(kAppWidth-2*kCellLeftGap, MAXFLOAT)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                  
    
    h += size.height;
    
    return h;
}

@end
