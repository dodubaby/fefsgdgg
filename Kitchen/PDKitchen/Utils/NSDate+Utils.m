//
//  NSDate+Utils.m
//  PDKitchen
//
//  Created by bright on 15/1/20.
//  Copyright (c) 2015年 mtf. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate(Utils)

+ (NSDate *)convertDateToLocalTime:(NSDate *)forDate {
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    NSTimeInterval timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    return newDate;
    
}

- (NSDate *)localTime
{
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    NSInteger seconds = [tz secondsFromGMTForDate:self];
    return [NSDate dateWithTimeInterval:seconds sinceDate:self];
}

@end
