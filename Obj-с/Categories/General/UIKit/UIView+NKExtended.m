//
//  UIView+NKExtended.m
//  GeoSearch
//
//  Created by Nick on 01/03/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UIView+NKExtended.h"

@implementation UIView (NKExtended)

- (UIView*) findSuperviewViewWithClass: (Class) clazz {
    if ([self isKindOfClass: clazz]){
        return self;
    } else if (self.superview){
        return [self.superview findSuperviewViewWithClass: clazz];
    } else {
        return nil;
    }
}

- (void) layoutIfNeededAnimatedWithDuration: (NSTimeInterval) duration {
    [UIView animateWithDuration: duration
                     animations:^{
                         [self layoutIfNeeded];
                     }];
}

+ (UIView*) loadFromNibByClassName {
    NSString* nibName = NSStringFromClass([self class]);
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed: nibName owner:self options:nil];
    return subviewArray.firstObject;
}

@end
