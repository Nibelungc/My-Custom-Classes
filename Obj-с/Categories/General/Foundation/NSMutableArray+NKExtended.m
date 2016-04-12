//
//  NSMutableArray+NKExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/04/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "NSMutableArray+NKExtended.h"

@implementation NSMutableArray (NKExtended)

@end

@implementation NSMutableArray (NKQueue)

- (void) enqueue: (id) object {
    [self addObject: object];
}

- (id) dequeue {
    id object = [self lastObject];
    [self removeLastObject];
    return object;
}

- (id) peek {
    return [self lastObject];
}

@end