//
//  PDSettingCell.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDSettingCell.h"
@interface PDSettingCell()
{
    UIButton *setbtn;
    
}
@end
@implementation PDSettingCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        NSLog(@"self.width == %f",self.width);
        
        setbtn = [[UIButton alloc] initWithFrame:CGRectMake(20+kCellLeftGap, kCellLeftGap, kAppWidth-kCellLeftGap*2-40, 80)];
        [self addSubview:setbtn];
        [setbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        setbtn.userInteractionEnabled=NO;
        [setbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    [setbtn setTitle:data forState:UIControlStateNormal];
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{
    
    return 100;
}


@end
