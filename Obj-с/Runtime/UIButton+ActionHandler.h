//
//  UIButton+ActionHandler.h
//  SampleProject(OBJC)
//
//  Created by Nikolay Kagala on 18/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionHandler)(id sender);

@interface UIButton (ActionHandler)

@property (copy, nonatomic) ActionHandler actionHandler;

@end
