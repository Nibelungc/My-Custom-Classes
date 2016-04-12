//
//  NSDictionary+NKExtended.h
//  GeoSearch
//
//  Created by Nikolay Kagala on 04/02/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NKExtended)

-(NSString*) urlEncodedString;

- (NSArray*) valuesForKeys: (NSArray*) keys;

@end
