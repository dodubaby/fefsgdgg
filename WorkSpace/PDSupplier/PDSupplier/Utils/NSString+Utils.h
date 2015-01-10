//
//  NSString+Utils.h
//  PDKitchen
//
//  Created by bright on 14/12/18.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utils)

- (CGSize)sizeWithFontCompatible:(UIFont *)font;
- (CGSize)sizeWithFontCompatible:(UIFont *)font
                        forWidth:(CGFloat)width
                   lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGSize)sizeWithFontCompatible:(UIFont *)font
               constrainedToSize:(CGSize)size;
- (CGSize)sizeWithFontCompatible:(UIFont *)font
               constrainedToSize:(CGSize)size
                   lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (NSString*)md5;



@end
