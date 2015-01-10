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
    
    UIImageView *line;
}

@end

@implementation PDCommentCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, kAppWidth-2*kCellLeftGap, 1.0)];
        [self addSubview:line];
        line.backgroundColor = [UIColor colorWithHexString:@"#e6e6e6"];
        
        name = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap-120, 20)];
        [self addSubview:name];
        name.font = [UIFont systemFontOfSize:12];
        name.textColor = [UIColor colorWithHexString:@"#999999"];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-120, kCellLeftGap, 120, 20)];
        [self addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
        time.font = [UIFont systemFontOfSize:12];
        time.textColor = [UIColor colorWithHexString:@"#999999"];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, name.bottom+kCellLeftGap, kAppWidth-2*kCellLeftGap, 0)];
        [self addSubview:content];
        content.font = [UIFont systemFontOfSize:15];
        content.lineBreakMode = NSLineBreakByWordWrapping;
        content.numberOfLines = 0;
        content.textColor = [UIColor colorWithHexString:@"#999999"];
    }
    
    return self;
}

-(void)hiddenLine:(BOOL) hide{
    line.hidden = hide;
}

-(void)configData:(id)data{

    name.text = @"138xxxx8090";
    time.text = @"5分钟前";
    
    content.text = kCellContent;
    [content sizeToFit];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    CGFloat h = 3*kCellLeftGap+20;
    
    CGSize size= [kCellContent sizeWithFontCompatible:[UIFont systemFontOfSize:15]
                                             constrainedToSize:CGSizeMake(kAppWidth-2*kCellLeftGap, MAXFLOAT)
                                        lineBreakMode:NSLineBreakByWordWrapping];
                  
    
    h += size.height;
    
    return h;
}

@end
