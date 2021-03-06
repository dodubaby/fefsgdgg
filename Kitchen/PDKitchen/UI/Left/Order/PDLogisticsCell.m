//
//  PDLogisticsCell.m
//  PDKitchen
//
//  Created by bright on 15/1/6.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "PDLogisticsCell.h"

@interface PDLogisticsCell()
{
    UIView *back;
    UILabel *time;
    UILabel *content;
    UIButton *actionButton;
}

@end

@implementation PDLogisticsCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        
        CGFloat h = [PDLogisticsCell cellHeightWithData:nil];
        
        back = [[UIView alloc] initWithFrame:CGRectMake(kCellLeftGap, kCellLeftGap/2, kAppWidth - 2*kCellLeftGap, h - kCellLeftGap)];
        [self addSubview:back];
        back.layer.borderWidth = 0.5f;
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        
        time = [[UILabel alloc] initWithFrame:CGRectMake(2*kCellLeftGap, (back.height - 40)/2, 50, 40)];
        [back addSubview:time];
        time.font = [UIFont systemFontOfSize:15];
        time.textColor = [UIColor colorWithHexString:@"#333333"];
        
        content = [[UILabel alloc] initWithFrame:CGRectMake(time.right + kCellLeftGap, time.top, 70, 40)];
        [back addSubview:content];
        content.font = [UIFont systemFontOfSize:15];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        
        actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [actionButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        [actionButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        actionButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [back addSubview:actionButton];
    }
    
    return self;
}

-(void)configData:(id)data{
    //[self showDebugRect];
    
    PDModelLogistics *ls = data;
    
    if ([_isCurrent boolValue]) { // 选中
        back.layer.borderColor = [[UIColor colorWithHexString:@"#c14a41"] CGColor];
        time.textColor = [UIColor colorWithHexString:@"#c14a41"];
        content.textColor = [UIColor colorWithHexString:@"#c14a41"];
        [actionButton setTitleColor:[UIColor colorWithHexString:@"#c14a41"] forState:UIControlStateNormal];
    }else{
        back.layer.borderColor = [[UIColor colorWithHexString:@"#e6e6e6"] CGColor];
        time.textColor = [UIColor colorWithHexString:@"#333333"];
        content.textColor = [UIColor colorWithHexString:@"#333333"];
        [actionButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    }
    
//    1、确认订单；
//    2、中间物流配送；
//    3、终级物流配送；
//    4、已就餐；
    
    int status = [ls.status intValue];
    NSString *statusStr = ls.status_title;
    NSString *phoneStr = nil;
    
    switch (status) {
        case 1:
            //
        {
        
//            statusStr = @"确认订单";
            phoneStr = [NSString stringWithFormat:@"客服：%@",ls.custom];
        }
            break;
        case 2:
            //
        {
        
//            statusStr = @"中间物流配送";
            phoneStr = [NSString stringWithFormat:@"物流：%@",ls.dispatching];
        }
            break;
        case 3:
            //
//            statusStr = @"终级物流配送";
            phoneStr = [NSString stringWithFormat:@"物流：%@",ls.dispatching];
            break;
        case 4:
            //
//            statusStr = @"已就餐";
            phoneStr = nil;
            
            break;
            
        default:
            
            statusStr = nil;
            phoneStr = nil;
            
            break;
    }
    
    
    time.text = ls.time;
    content.text = statusStr;
    [content sizeToFit];
    content.frame = CGRectMake(time.right + kCellLeftGap, time.top, content.width, 40);
    
    

    [actionButton setTitle:phoneStr forState:UIControlStateNormal];
    [actionButton sizeToFit];
    actionButton.frame = CGRectMake(content.right + kCellLeftGap, time.top, actionButton.width, 40);
}

+(CGFloat )cellHeightWithData:(id)data{
    return 50+kCellLeftGap;
}

@end
