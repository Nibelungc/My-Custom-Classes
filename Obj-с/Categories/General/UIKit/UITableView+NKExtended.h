//
//  UITableView+NKExtended.h
//  GeoSearch
//
//  Created by Nick on 01/03/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (NKExtended)

- (void) beginUpdatesBlock: (void(^)()) updateBlock
            withCompletion: (void(^)()) completion;

@end
