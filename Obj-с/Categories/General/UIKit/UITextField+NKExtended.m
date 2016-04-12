//
//  UITextField+NKExtended.m
//  GeoSearch
//
//  Created by Nikolay Kagala on 26/01/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UITextField+NKExtended.h"
#import <objc/runtime.h>

static char nextFieldHashKey;
static char prevFieldHashKey;

@implementation UITextField (NKExtended)

#pragma mark - Properties

- (void) setNextTextField:(UITextField *)nextTextField {
    objc_setAssociatedObject(self, &nextFieldHashKey, nextTextField, OBJC_ASSOCIATION_RETAIN);
}

- (UITextField*) nextTextField {
    return objc_getAssociatedObject(self, &nextFieldHashKey);
}

- (void) setPrevTextFiled:(UITextField *)prevTextFiled {
    objc_setAssociatedObject(self, &prevFieldHashKey, prevTextFiled, OBJC_ASSOCIATION_ASSIGN);
}

- (UITextField*) prevTextFiled {
    return objc_getAssociatedObject(self, &prevFieldHashKey);
}

#pragma mark - Navigation

- (BOOL) goToNextTextField {
    return [self goToTextField: self.nextTextField];
}

- (BOOL) goToPreviousTextField {
    return [self goToTextField: self.prevTextFiled];
}

- (BOOL) goToTextField: (nullable UITextField*) textField {
    if ([self isTextFieldActive: textField]) {
        [textField becomeFirstResponder];
        return YES;
    }
    return NO;
}

- (BOOL) isTextFieldActive: (UITextField*) textField {
    return textField && !textField.hidden;
}

#pragma mark - Presentation

- (void) setKeyboardToolbarEnabled: (BOOL) enabled {
    UIToolbar* toolBar = nil;
    if (enabled){
        toolBar = [[UIToolbar alloc] init];
        [toolBar sizeToFit];
        
        UIBarButtonItem* doneButton =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                      target: self
                                                      action: @selector(resignFirstResponder)];
        
        UIImage* leftImage = [UIImage imageNamed:@"left_arrow"];
        
        UIBarButtonItem* prevButton =
        [[UIBarButtonItem alloc] initWithImage: leftImage
                                         style: UIBarButtonItemStylePlain
                                        target: self
                                        action: @selector(goToPreviousTextField)];
        
        UIImage* rightImage = [UIImage imageNamed:@"right_arrow"];
        
        UIBarButtonItem* nextButton =
        [[UIBarButtonItem alloc] initWithImage: rightImage
                                         style: UIBarButtonItemStylePlain
                                        target: self
                                        action: @selector(goToNextTextField)];
        
        UIBarButtonItem* flexibleSpace =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                      target: nil action: nil];
        
        toolBar.items = @[prevButton, nextButton, flexibleSpace, doneButton];
        UIColor* disabledColor = [UIColor grayColor];
        UIWindow* window = [UIApplication sharedApplication].windows.firstObject;
        UIColor* enabledColor = window.tintColor;
        UIColor* backgroundColor = window.backgroundColor;
        prevButton.tintColor = [self isTextFieldActive: self.prevTextFiled] ? enabledColor : disabledColor;
        nextButton.tintColor = [self isTextFieldActive: self.nextTextField] ? enabledColor : disabledColor;
        doneButton.tintColor = enabledColor;
        toolBar.barTintColor = backgroundColor;
    }
    self.inputAccessoryView = toolBar;
}

- (void) shake {
    CABasicAnimation *animation =
    [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.1];
    [animation setRepeatCount:2];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self center].x - 3.0f, [self center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self center].x + 3.0f, [self center].y)]];
    [[self layer] addAnimation:animation forKey:@"position"];
}

@end
