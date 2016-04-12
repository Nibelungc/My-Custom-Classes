//
//  NSMutableArray+NKExtended.h
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/04/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NKExtended)

@end

@interface NSMutableArray (NKQueue)

- (void) enqueue: (id) object;

- (id) dequeue;

- (id) peek;

@end
