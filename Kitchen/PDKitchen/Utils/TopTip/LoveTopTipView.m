//
//  LoveTopTipView.m
//  iLove
//
//  Created by mtf on 12-11-27.
//  Copyright (c) 2012年 www.fanxer.com. All rights reserved.
//

#import "LoveTopTipView.h"

@implementation LoveTopTipView


static LoveTopTipView *_instance = nil;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = NO;
        self.alpha = 1.0f;
        UIImageView* backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35.0, 0, 250, 46)];
        backgroundImageView.image = [UIImage imageNamed:@"top_tip_panel"];
        [self addSubview:backgroundImageView];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(35.0, 0, 250, 46)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.font = [UIFont boldSystemFontOfSize:14.0f];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:messageLabel];
    }
    
    return self;
}

-(void)showMessage:(NSString *)message {
	[self showMessage:message duration:2.5f];
}


-(void)showMessage:(NSString *)message duration:(NSTimeInterval)duration {
    
	dispatch_async(dispatch_get_main_queue(), ^{
        messageLabel.text = [NSString stringWithFormat:@"%@", message];
        
        self.frame=CGRectMake(self.frame.origin.x, -26.0, self.frame.size.width, self.frame.size.height);
        
        if (nil == self.superview) {
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }
        
        [UIView beginAnimations:@"show" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        self.alpha=1.0;
        CGRect rect=self.frame;
        rect.origin.y=20.0;
        self.frame=rect;
        [UIView commitAnimations];
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
    });
}

-(void)hide{
	
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView beginAnimations:@"hide" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:1.0];
        self.alpha=0.0;
        CGRect rect=self.frame;
        rect.origin.y=-26.0;
        self.frame=rect;
        [UIView commitAnimations];
    });
}

+(LoveTopTipView *)shareInstance{
	@synchronized(self) {
		if (!_instance) {
			_instance = [[LoveTopTipView alloc] initWithFrame:CGRectMake(0, -46, 320, 46)];
		}
	}
	return _instance;
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (!_instance) {
			_instance = [super allocWithZone:zone];
			
			return _instance;
		}
	}
	
	return nil;
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

@end
