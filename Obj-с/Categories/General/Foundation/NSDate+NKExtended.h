//
//  NSDate+NKExtended.h
//  GeoSearch
//
//  Created by Nikolay Kagala on 25/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NKExtended)

+ (NSDate *) GMTDate;

@end

@interface NSDateFormatter (NKExtended)

+ (NSDateFormatter*) gs_dateFormatterDateOnly;

+ (NSDateFormatter*) gs_dateFormatterTimeOnly;

+ (NSDateFormatter*) gs_dateFormatter;

@end
