//
//  UICollectionView+NKExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 28/03/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UICollectionView+NKExtended.h"

@implementation UICollectionView (NKExtended)

- (NSIndexPath*) indexPathOfVisibleItem {
    CGRect visibleRect = (CGRect){.origin = self.contentOffset, .size = self.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    return [self indexPathForItemAtPoint:visiblePoint];
}

@end
