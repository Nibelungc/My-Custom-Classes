//
//  UIViewController+EmptyBackButton.m
//  DPO
//
//  Created by Denis Baluev on 23/10/15.
//  Copyright © 2015 Admin. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+EmptyBackButton.h"

@implementation UIViewController (EmptyBackButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(my_viewDidLoad);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void) my_viewDidLoad{
    [self my_viewDidLoad];
    self.navigationController.navigationBar.topItem.backBarButtonItem  =
    [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: nil action: nil];
}

@end
