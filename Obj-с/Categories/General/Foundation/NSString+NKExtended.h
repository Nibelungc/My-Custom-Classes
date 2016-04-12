//
//  NSString+NKExtended.h
//  GeoSearch
//
//  Created by Nick on 12/04/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NKExtended)

+ (NSString*) stringForCount: (NSInteger) count withWords: (NSArray*) words;

+ (NSString *) encodeStringForURL:(NSString *)string;

- (BOOL) isEmpty;

- (BOOL) isEmail;

- (NSString*) uppercaseFirstLetterString;

- (NSString *) md5;

- (NSString *) sha1;

@end
