//
//  UITextField+NKExtended.h
//  GeoSearch
//
//  Created by Nikolay Kagala on 26/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (NKExtended)

@property (strong, nonatomic, nullable) UITextField* nextTextField;

@property (weak, nonatomic, nullable) UITextField* prevTextFiled;

- (BOOL) goToNextTextField;

- (void) setKeyboardToolbarEnabled: (BOOL) enabled;

- (void) shake;

@end
