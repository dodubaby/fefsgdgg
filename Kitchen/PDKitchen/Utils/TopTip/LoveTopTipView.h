//
//  LoveTopTipView.h
//  iLove
//
//  Created by mtf on 12-11-27.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoveTopTipView : UIView
{
    UILabel *messageLabel;

}

+(LoveTopTipView *)shareInstance;

-(void)showMessage:(NSString *)message;    // 默认2.5s自动消失
-(void)showMessage:(NSString *)message duration:(NSTimeInterval)duration;

@end
