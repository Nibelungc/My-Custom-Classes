//
//  NSString+NKExtended.m
//  GeoSearch
//
//  Created by Nick on 12/04/16.
//  Copyright © 2016 Sequenia. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>

#import "NSString+NKExtended.h"

@implementation NSString (NKExtended)

+ (NSString *) encodeStringForURL:(NSString *)string {
    NSString *encodedString =
    (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                          (CFStringRef)string,
                                                                          NULL,
                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                          kCFStringEncodingUTF8 ));
    return encodedString;
}

/**
 * Метод возвращает окончание для множественного числа слова на основании числа и массива окончаний
 * count NSInteger Число на основе которого нужно сформировать окончание
 * words NSArray Массив слов для чисел (1, 4, 5, 0),
 *       например ['яблоко', 'яблока', 'яблок', 'нет яблок']
 */

+ (NSString*) stringForCount: (NSInteger) count withWords: (NSArray*) words{
    if (!words || words.count < 4){
        return nil;
    }
    if (count == 0){
        return words[3];
    }
    NSString* resultString;
    NSInteger i,j;
    j = count % 100;
    if (j >= 11 && j <= 19) {
        resultString = words[2];
    }
    else {
        i = j % 10;
        switch (i)
        {
            case (1): resultString = words[0]; break;
            case (2):
            case (3):
            case (4): resultString = words[1]; break;
            default: resultString = words[2];
        }
    }
    return [NSString stringWithFormat: @"%ld %@", count, resultString];
    
}

- (BOOL) isEmpty {
    return [self isEqualToString:@""];
}

- (BOOL) isEmail {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject: self];
}

- (NSString *)sha1 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG) data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

- (NSString *)md5 {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString*) uppercaseFirstLetterString {
    NSString* resultString = self;
    if (self.length > 0) {
        resultString = [self stringByReplacingCharactersInRange: NSMakeRange(0,1)
                                                     withString: [[self substringToIndex:1] capitalizedString]];
    }
    return resultString;
}

@end
