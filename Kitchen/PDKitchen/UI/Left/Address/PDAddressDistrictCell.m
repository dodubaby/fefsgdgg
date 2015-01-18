//
//  PDAddressDistrictCell.m
//  PDKitchen
//
//  Created by bright on 15/1/18.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDAddressDistrictCell.h"

@interface PDAddressDistrictCell()
{
    UIView *back;
    UILabel *address;
    
    NSMutableArray *list;
    
}
@end

@implementation PDAddressDistrictCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        CGFloat h = [PDAddressDistrictCell cellHeightWithData:nil];
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, back.width - 2*kCellLeftGap, back.height)];
        [back addSubview:address];
        address.numberOfLines = 2;
        address.font = [UIFont systemFontOfSize:15];
        address.textColor = [UIColor colorWithHexString:@"#333333"];
    }
    return self;
}

-(void)configData:(id)data{
    
    PDModelDistrict *dt = data;
    address.text = dt.title;
    [address sizeToFit];
    address.top = (back.height - address.height)/2;
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 50+kCellLeftGap;
}

@end