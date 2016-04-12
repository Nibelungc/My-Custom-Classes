//
//  UIView+NKExtended.h
//  GeoSearch
//
//  Created by Nick on 01/03/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NKExtended)

- (UIView*) findSuperviewViewWithClass: (Class) clazz;

- (void) layoutIfNeededAnimatedWithDuration: (NSTimeInterval) duration;

+ (instancetype) loadFromNibByClassName;

@end
