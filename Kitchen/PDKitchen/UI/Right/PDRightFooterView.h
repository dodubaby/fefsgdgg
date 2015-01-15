//
//  PDRightFooterView.h
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDUtils.h"

@protocol PDRightFooterViewDelegate;

@interface PDRightFooterView : UIView

@property (nonatomic,weak) id<PDRightFooterViewDelegate> delegate;
@property (nonatomic,assign) NSString *totalPrice;
@end


@protocol PDRightFooterViewDelegate <NSObject>

-(void)pdRightFooterView:(PDRightFooterView *)view submitWithTotal:(CGFloat) totalPrice;

@end