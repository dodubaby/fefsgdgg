//
//  PDOrderTimeCell.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDOrderTimeCell.h"


@interface PDOrderTimeCell()
{
    UIView *back;
    UILabel *content;
    
    
}
@end

@implementation PDOrderTimeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        CGFloat h = [PDOrderTimeCell cellHeightWithData:nil];
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, back.width - 2*kCellLeftGap, back.height)];
        [back addSubview:content];
        content.numberOfLines = 2;
        content.font = [UIFont systemFontOfSize:15];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        content.textAlignment = NSTextAlignmentCenter;
        content.height = 20;
        content.width = back.width - 2*kCellLeftGap;
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{

    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        back.layer.borderColor = [[UIColor colorWithHexString:@"#c14a41"] CGColor];
        content.textColor = [UIColor colorWithHexString:@"#c14a41"];
    }else{
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
    }
}

-(void)configData:(id)data{
//    
//    if (_isFirst) {
//        back.layer.borderColor = [[UIColor colorWithHexString:@"#c14a41"] CGColor];
//        content.textColor = [UIColor colorWithHexString:@"#c14a41"];
//    }else{
//        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
//        content.textColor = [UIColor colorWithHexString:@"#333333"];
//    }
    
    if ([data isKindOfClass:[NSString class]]) { // 立即
        content.text = data;
    }else if([data isKindOfClass:[NSDate class]]){  // 时间
        
        NSDate *date = data;  // 标准时间
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setTimeZone:[NSTimeZone localTimeZone]]; // 本地时间
        [dateFormatter setDateFormat:@"HH:mm"];
        NSString *dateStr = [dateFormatter stringFromDate:date];
        content.text = dateStr;
    }
    //[address sizeToFit];
    content.top = (back.height - content.height)/2;
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 50+kCellLeftGap;
}


@end
