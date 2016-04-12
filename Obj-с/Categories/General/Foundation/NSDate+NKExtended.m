//
//  NSDate+NKExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 25/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NSDate+NKExtended.h"

@implementation NSDate (NKExtended)

+ (NSDate *) GMTDate {
    NSDate *localDate = [NSDate date];
    NSTimeInterval timeZoneOffset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    NSTimeInterval gmtTimeInterval = [localDate timeIntervalSinceReferenceDate] - timeZoneOffset;
    return [NSDate dateWithTimeIntervalSinceReferenceDate:gmtTimeInterval];
}

@end

@implementation NSDateFormatter (GSExtended)

+ (NSDateFormatter*) formatterWithDateStyle: (NSDateFormatterStyle) dateStyle
                                  TimeStyle: (NSDateFormatterStyle) timeStyle
                             relativeFormat: (BOOL) relative
                                   cacheKey: (NSString*) cacheKey {
    NSCache* dateFormatterCache = [self gs_formatterCache];
    if ([dateFormatterCache objectForKey: cacheKey]){
        return [dateFormatterCache objectForKey: cacheKey];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeStyle = timeStyle;
    dateFormatter.dateStyle = dateStyle;
    dateFormatter.locale = [NSLocale currentLocale];
    dateFormatter.doesRelativeDateFormatting = relative;
    [dateFormatterCache setObject: dateFormatter forKey: cacheKey];
    return dateFormatter;
}


+ (NSDateFormatter*) gs_dateFormatterDateOnly {
    NSString* cacheKey = NSStringFromSelector(_cmd);
    return [self formatterWithDateStyle: NSDateFormatterShortStyle
                              TimeStyle: NSDateFormatterNoStyle
                         relativeFormat: YES
                               cacheKey: cacheKey];
}

+ (NSDateFormatter*) gs_dateFormatterTimeOnly {
    NSString* cacheKey = NSStringFromSelector(_cmd);
    return [self formatterWithDateStyle: NSDateFormatterNoStyle
                              TimeStyle: NSDateFormatterShortStyle
                         relativeFormat: YES
                               cacheKey: cacheKey];
}

+ (NSDateFormatter*) gs_dateFormatter {
    NSString* cacheKey = NSStringFromSelector(_cmd);
    return [self formatterWithDateStyle: NSDateFormatterShortStyle
                              TimeStyle: NSDateFormatterShortStyle
                         relativeFormat: YES
                               cacheKey: cacheKey];
}

+ (NSCache*) gs_formatterCache {
    static NSCache* dateFormatterCache = nil;
    if (!dateFormatterCache){
        dateFormatterCache = [[NSCache alloc] init];
    }
    return dateFormatterCache;
}

@end
