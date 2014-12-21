//
//  PDOrderCell.m
//  PDKitchen
//
//  Created by bright on 14/12/21.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "PDOrderCell.h"

@interface PDOrderCell()
{
    UILabel *look;
}
@end


@implementation PDOrderCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        CGFloat h = [PDOrderCell cellHeightWithData:nil];
        
        look = [[UILabel alloc] initWithFrame:CGRectMake(200, h-40-kCellLeftGap, 70, 40)];
        look.textColor = [UIColor redColor];
        look.text = @"查看";
        [self addSubview:look];
    }
    return self;
}

-(void)configData:(id)data{
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    return 120;
}

@end
