//
//  NSDictionary+NKExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NSDictionary+NKExtended.h"

static NSString *toString(id object) {
    return [NSString stringWithFormat: @"%@", object];
}

static NSString *urlEncode(id object) {
    NSString *string = toString(object);
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

@implementation NSDictionary (NKExtended)

-(NSString*) urlEncodedString {
    NSMutableArray *parts = [NSMutableArray array];
    for (id key in self) {
        id value = [self objectForKey: key];
        NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
        [parts addObject: part];
    }
    return [parts componentsJoinedByString: @"&"];
}

- (NSArray*) valuesForKeys: (NSArray*) keys {
    NSMutableArray* values = nil;
    
    for (id key in keys) {
        if (![self.allKeys containsObject: key]){
            continue;
        }
        if (!values){
            values = [NSMutableArray arrayWithObject: self[key]];
        } else {
            [values addObject: self[key]];
        }
    }
    
    return values;
}

@end
