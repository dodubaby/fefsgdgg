//
//  PDAddressCell.m
//  PDKitchen
//
//  Created by bright on 15/1/7.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDAddressCell.h"

@interface PDAddressCell()
{
    UIView *back;
    UILabel *address;
    
    NSMutableArray *list;
    
}
@end

@implementation PDAddressCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
    
        CGFloat h = [PDAddressCell cellHeightWithData:nil];
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap/2, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, back.width - 2*kCellLeftGap, back.height)];
        [back addSubview:address];
        address.font = [UIFont systemFontOfSize:15];
        address.textColor = [UIColor colorWithHexString:@"#333333"];
        address.text = @"32rtgrgtrtrhtrhtrhrh";
    }
    return self;
}

-(void)configData:(id)data{
    
     //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{

    return 50+kCellLeftGap;
}

@end