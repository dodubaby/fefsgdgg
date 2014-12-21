//
//  PDOrderCell.m
//  PDSupplier
//
//  Created by zdf on 14/12/21.
//  Copyright (c) 2014年 Man. All rights reserved.
//

#import "PDOrderCell.h"


@interface PDOrderCell()
{
    
    UIImageView *sortimg;
    UIImageView *newmarkimg;
    UILabel *totallab;
    UILabel *everyla[100];
    UILabel *msglab;
    UILabel *timelab;
    UILabel *phonelab;
    UILabel *addresslab;
    UIButton *submitbtn;
    
}
@end

@implementation PDOrderCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        NSLog(@"self.width == %f",self.width);
        
        sortimg = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, 35, 35)];
        sortimg.backgroundColor=[UIColor grayColor];
        [self addSubview:sortimg];
        
        newmarkimg = [[UIImageView alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-20, kCellLeftGap, 20, 20)];
        [self addSubview:newmarkimg];
        newmarkimg.backgroundColor = [UIColor grayColor];

        totallab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, sortimg.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
        [self addSubview:totallab];
        NSInteger height=totallab.bottom;
        for (int i=0; i<5; i++) {
            everyla[i]=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, height+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
            height=everyla[i].bottom;
            [self addSubview:everyla[i]];
        }
        msglab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, height+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
        [self addSubview:msglab];
        
        timelab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, msglab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
        
        [self addSubview:timelab];
        
        phonelab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, timelab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
        
        [self addSubview:phonelab];
        
        addresslab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap, phonelab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2, 20)];
        
        [self addSubview:addresslab];
        
        submitbtn = [[UIButton alloc] initWithFrame:CGRectMake(20+kCellLeftGap, addresslab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*2-40, 40)];
        [self addSubview:submitbtn];
        [submitbtn setTitle:@"确认订单" forState:UIControlStateNormal];
        [submitbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [submitbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
    }
    
    return self;
}

-(void)configData:(id)data{
    
    totallab.text=@"总计:80元";
    for (int i=0; i<5; i++) {
        everyla[i].text=@"鲍鱼饭＊2  80元";
    }
    msglab.text=@"不要太甜";
    timelab.text=@"就餐时间";
    phonelab.text=@"下单人电话";
    addresslab.text=@"下单人地址";
    if (self.type==OrderTypeToday) {
        submitbtn.hidden=NO;
    }else{
        submitbtn.hidden=YES;
    }
    [self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{

    return 270+(20+kCellLeftGap)*4;
}

@end
