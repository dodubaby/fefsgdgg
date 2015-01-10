//
//  UIImage+Utils.m
//  PDKitchen
//
//  Created by bright on 14/12/30.
//  Copyright (c) 2014年 mtf. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage(Utils)

+ (UIImage*)imageWithColor:(UIColor*)color{
    return [UIImage imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage*)imageWithColor:(UIColor*) color size:(CGSize) size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,[color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
