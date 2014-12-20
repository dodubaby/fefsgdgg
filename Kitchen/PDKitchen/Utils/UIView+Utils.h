//
//  UIView+Utils.h
//  PDKitchen
//
//  Created by bright on 14/12/17.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

// sub view
- (NSArray *)allSubviewsForView:(UIView *)view;
- (NSArray *)allSubviews;
- (void)removeAllSubViews;

- (UIView *)findFirstResponder;
- (BOOL)findAndResignFirstResponder;

// debug
- (void)showDebugRect;

// super view
- (UIView *)findSuperViewWithClass:(Class)superViewClass;

@end
