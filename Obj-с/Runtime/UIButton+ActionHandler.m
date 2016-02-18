//
//  UIButton+ActionHandler.m
//  SampleProject(OBJC)
//
//  Created by Nikolay Kagala on 18/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import "UIButton+ActionHandler.h"
#import <objc/runtime.h>

static char action_handler_hash_key;

@implementation UIButton (ActionHandler)

- (void)setActionHandler:(ActionHandler)actionHandler {
    objc_setAssociatedObject(self, &action_handler_hash_key, actionHandler, OBJC_ASSOCIATION_COPY);
    [self addTarget:self action: @selector(customAction:) forControlEvents: UIControlEventTouchUpInside];
}

- (ActionHandler)actionHandler {
    return objc_getAssociatedObject(self, &action_handler_hash_key);
}

- (void) customAction: (id) sender {
    if (self.actionHandler){
        self.actionHandler(sender);
    }
}

@end
