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
    UILabel *sortlab;
    UIImageView *bgborderimg;
    UIImageView *newmarkimg;
    UILabel *totallab;
    UILabel *everyla[100];
    UILabel *msglab;
    UILabel *timelab;
    UILabel *phonelab;
    UILabel *addresslab;
    UIButton *receivebtn;
    UIButton *finishbtn;
    UIButton *cancelbtn;
    
}
@end

@implementation PDOrderCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        NSLog(@"self.width == %f",self.width);
        
        
        sortimg = [[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, 0, 22.5, 22.5)];
        sortimg.image=[UIImage imageNamed:@"订单号背景"];
        [self addSubview:sortimg];
        sortlab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 22.5, 22.5)];
        sortlab.backgroundColor=[UIColor clearColor];
        sortlab.font=[UIFont systemFontOfSize:kAppFontSize];
        sortlab.textColor=[UIColor colorWithHexString:kAppNormalColor];
        sortlab.textAlignment=NSTextAlignmentCenter;
        sortlab.text=@"1";
        [sortimg addSubview:sortlab];

        newmarkimg = [[UIImageView alloc] initWithFrame:CGRectMake(kAppWidth-kCellLeftGap-30, 11+5, 26, 26)];
        [self addSubview:newmarkimg];
        newmarkimg.image=[UIImage imageNamed:@"新"];
        newmarkimg.backgroundColor = [UIColor clearColor];

        
        NSInteger height=sortimg.bottom;
        for (int i=0; i<5; i++) {
            everyla[i]=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, height+kCellLeftGap, kAppWidth-kCellLeftGap*6, 20)];
            everyla[i].font=[UIFont systemFontOfSize:kAppFontSize];
            everyla[i].textColor=[UIColor colorWithHexString:kAppTitleColor];
            height=everyla[i].bottom;
            [self addSubview:everyla[i]];
        }
        msglab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, height+kCellLeftGap, kAppWidth-kCellLeftGap*6, 20)];
        msglab.font=[UIFont systemFontOfSize:kAppFontSize];
        msglab.textColor=[UIColor colorWithHexString:kAppRedColor];
        [self addSubview:msglab];
        
        phonelab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, msglab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*6, 20)];
        phonelab.font=[UIFont systemFontOfSize:kAppFontSize];
        phonelab.textColor=[UIColor colorWithHexString:kAppTitleColor];
        [self addSubview:phonelab];
        
        timelab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, phonelab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*6, 20)];
        timelab.font=[UIFont systemFontOfSize:kAppFontSize];
        timelab.textColor=[UIColor colorWithHexString:kAppRedColor];
        [self addSubview:timelab];
        
        addresslab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, timelab.bottom+kCellLeftGap, kAppWidth-kCellLeftGap*6, 20)];
        addresslab.font=[UIFont systemFontOfSize:kAppFontSize];
        addresslab.textColor=[UIColor colorWithHexString:kAppTitleColor];
        [self addSubview:addresslab];
        
        totallab=[[UILabel alloc] initWithFrame:CGRectMake(kCellLeftGap*3, addresslab.bottom+kCellLeftGap*2, kAppWidth-kCellLeftGap*6, 20)];
        totallab.font=[UIFont systemFontOfSize:kAppFontSize];
        totallab.textColor=[UIColor colorWithHexString:kAppTitleColor];
        [self addSubview:totallab];
        
        
        receivebtn = [[UIButton alloc] initWithFrame:CGRectMake(3*kCellLeftGap, totallab.bottom+kCellLeftGap, (kAppWidth-8*kCellLeftGap)/3, 40)];
        [receivebtn setTitle:@"接单" forState:UIControlStateNormal];
        [receivebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [receivebtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
        receivebtn.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
        receivebtn.titleLabel.font=[UIFont systemFontOfSize:kAppBtnSize];
        [receivebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        receivebtn.layer.cornerRadius = kBtnCornerRadius;
        receivebtn.layer.masksToBounds = YES;
        receivebtn.layer.borderWidth = 1;
        receivebtn.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
        [self addSubview:receivebtn];
        
        finishbtn = [[UIButton alloc] initWithFrame:CGRectMake(receivebtn.right+kCellLeftGap, totallab.bottom+kCellLeftGap, (kAppWidth-8*kCellLeftGap)/3, 40)];
        [finishbtn setTitle:@"完成" forState:UIControlStateNormal];
        [finishbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [finishbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
        finishbtn.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
        finishbtn.titleLabel.font=[UIFont systemFontOfSize:kAppBtnSize];
        [finishbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        finishbtn.layer.cornerRadius = kBtnCornerRadius;
        finishbtn.layer.masksToBounds = YES;
        finishbtn.layer.borderWidth = 1;
        finishbtn.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
        [self addSubview:finishbtn];
        
        cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(finishbtn.right+kCellLeftGap, totallab.bottom+kCellLeftGap, (kAppWidth-8*kCellLeftGap)/3, 40)];
        [cancelbtn setTitle:@"确认退单" forState:UIControlStateNormal];
        [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelbtn handleControlEvents:UIControlEventTouchUpInside actionBlock:^(id sender) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(pdBaseTableViewCellDelegate:addOrderWithData:)]) {
                [self.delegate pdBaseTableViewCellDelegate:self addOrderWithData:nil];
            }
        }];
        cancelbtn.backgroundColor=[UIColor colorWithHexString:kAppRedColor];
        cancelbtn.titleLabel.font=[UIFont systemFontOfSize:kAppBtnSize];
        [cancelbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelbtn.layer.cornerRadius = kBtnCornerRadius;
        cancelbtn.layer.masksToBounds = YES;
        cancelbtn.layer.borderWidth = 1;
        cancelbtn.layer.borderColor = [[UIColor colorWithHexString:kAppRedColor] CGColor];
        [self addSubview:cancelbtn];
        
        bgborderimg=[[UIImageView alloc] initWithFrame:CGRectMake(kCellLeftGap, 11, kAppWidth-kCellLeftGap*2, cancelbtn.bottom+kCellLeftGap)];
        bgborderimg.backgroundColor=[UIColor clearColor];
        bgborderimg.layer.cornerRadius = 0;
        bgborderimg.layer.masksToBounds = YES;
        bgborderimg.layer.borderWidth = 1;
        bgborderimg.layer.borderColor = [[UIColor colorWithHexString:kAppLineColor] CGColor];
        [self addSubview:bgborderimg];
        [self sendSubviewToBack:bgborderimg];
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
        receivebtn.hidden=NO;
        finishbtn.hidden=NO;
        cancelbtn.hidden=NO;
    }else{
        receivebtn.hidden=YES;
        finishbtn.hidden=YES;
        cancelbtn.hidden=YES;
    }
    //[self showDebugRect];
}

+(CGFloat )cellHeightWithData:(id)data{

    if (1) {
        
    }else{
        
    }
    return 412;
}

@end
