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

        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap, kAppWidth-2*kCellLeftGap, h-kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        address = [[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, back.width - 2*kCellLeftGap-20, back.height)];
        [back addSubview:address];
        address.numberOfLines = 2;
        address.font = [UIFont systemFontOfSize:15];
        address.textColor = [UIColor colorWithHexString:@"#333333"];
        
        UIButton *deletebutton=[[UIButton alloc] initWithFrame:CGRectMake(address.right, (back.height-20)/2, 20, 20)];
        [deletebutton setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deletebutton setBackgroundImage:[UIImage imageNamed:@"delete1"] forState:UIControlStateHighlighted];
        [back addSubview:deletebutton];
        [deletebutton handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:deleteAddressWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self deleteAddressWithData:self.data];
            }
        }];
    }
    return self;
}

-(void)configData:(id)data{
    
    PDModelAddress *addressData = data;
    
    address.text = addressData.address;
    
    [address sizeToFit];
    address.top = (back.height - address.height)/2;
     //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{

    return 50+kCellLeftGap;
}

@end