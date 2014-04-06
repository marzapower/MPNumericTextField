//
//  MPFormatterUtils.h
//
//  Version 1.0.0
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPFormatterUtils : NSObject

+ (NSNumberFormatter *)currencyFormatter:(NSLocale *)locale;
+ (NSString *)stringFromPercentage:(NSNumber *)number locale:(NSLocale *)locale;
+ (NSString *)shortStringFromPercentage:(NSNumber *)number locale:(NSLocale *)locale;
+ (NSString *)stringFromCurrency:(NSNumber *)currency locale:(NSLocale *)locale;
+ (NSString *)stringFromNumber:(NSNumber *)currency locale:(NSLocale *)locale;
+ (NSNumber *)numberFromString:(NSString *)string locale:(NSLocale *)locale;
+ (NSNumber *)currencyFromString:(NSString *)string locale:(NSLocale *)locale;
+ (NSNumber *)percentageFromString:(NSString *)string locale:(NSLocale *)locale;

@end
