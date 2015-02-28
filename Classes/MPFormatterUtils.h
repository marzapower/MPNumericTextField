//
//  MPFormatterUtils.h
//
//  Version 1.1.0
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//
//  The MIT License (MIT)
//  
//  Copyright (c) [2014-2015] [Daniele Di Bernardo]
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//  
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
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
