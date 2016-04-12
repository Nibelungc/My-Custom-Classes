//
//  UITableView+NKExtended.m
//  GeoSearch
//
//  Created by Nick on 01/03/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UITableView+NKExtended.h"

@implementation UITableView (NKExtended)

- (void) beginUpdatesBlock: (void(^)()) updateBlock
            withCompletion: (void(^)()) completion {
    
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        if (completion){
            completion();
        }
    }];
    
    [self beginUpdates];
    
    if (updateBlock){
        updateBlock();
    }
    
    [self endUpdates];
    
    [CATransaction commit];
    
}

@end
