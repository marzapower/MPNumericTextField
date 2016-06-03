//
//  MPFormatterUtils.m
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

#import "MPFormatterUtils.h"

@implementation MPFormatterUtils

+ (NSNumberFormatter *)currencyFormatter:(NSLocale *)locale
{
  static NSNumberFormatter *currencyFormatter;
  if (!currencyFormatter) {
    currencyFormatter  = [[NSNumberFormatter alloc] init];
    [currencyFormatter setLocale:locale];
    [currencyFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    
    if (currencyFormatter.maximumFractionDigits > 0) {
      currencyFormatter.generatesDecimalNumbers = YES;
      currencyFormatter.maximumFractionDigits = 2;
      currencyFormatter.minimumFractionDigits = 2;
      currencyFormatter.roundingIncrement = @(0.01);
    }
  }
  
  return currencyFormatter;
}

+ (NSString *)stringFromPercentage:(NSNumber *)number locale:(NSLocale *)locale
{
  if (!number) {
		return @"";
	}
	
	static NSNumberFormatter *percentFormatter;
	if (percentFormatter == NULL) {
		percentFormatter  = [[NSNumberFormatter alloc] init];
    percentFormatter.locale = locale;
		[percentFormatter setGeneratesDecimalNumbers:YES];
		[percentFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		[percentFormatter setMinimumFractionDigits:3];
		[percentFormatter setMaximumFractionDigits:3];
		[percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
	}
	
	NSNumber *numberRevisited = [NSNumber numberWithDouble:([number doubleValue]/100.0)];
	
	// get formatted string
	NSString* formatted = [percentFormatter stringFromNumber:numberRevisited];
	return formatted;
}

+ (NSString *)shortStringFromPercentage:(NSNumber *)number locale:(NSLocale *)locale
{
  if (!number) {
		return @"";
	}
	
	static NSNumberFormatter *percentFormatter;
	if (percentFormatter == NULL) {
		percentFormatter  = [[NSNumberFormatter alloc] init];
    percentFormatter.locale = locale;
		[percentFormatter setGeneratesDecimalNumbers:YES];
		[percentFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
		[percentFormatter setMinimumFractionDigits:0];
		[percentFormatter setMaximumFractionDigits:0];
		[percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
	}
	
	NSNumber *numberRevisited = [NSNumber numberWithDouble:([number doubleValue]/100.0)];
	
	// get formatted string
	NSString* formatted = [percentFormatter stringFromNumber:numberRevisited];
	return formatted;
}

+ (NSString *)stringFromCurrency:(NSNumber *)currency locale:(NSLocale *)locale
{
	// get formatted string
	NSString* formatted = [[self currencyFormatter:locale] stringFromNumber:currency];
	return formatted;
}

+ (NSString *)stringFromNumber:(NSNumber *)currency locale:(NSLocale *)locale
{
	// get formatted string
  NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
	[myNumFormatter setLocale:locale];
	[myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
  
	NSString* formatted = [myNumFormatter stringFromNumber:currency];
	return formatted;
}

+ (NSString *)stringFromInteger:(NSNumber *)integer locale:(NSLocale *)locale
{
    // get formatted string
    NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
    [myNumFormatter setLocale:locale];
    [myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [myNumFormatter setGeneratesDecimalNumbers:NO];
    [myNumFormatter setMinimumFractionDigits:0];
    [myNumFormatter setMaximumFractionDigits:0];
    
    NSString* formatted = [myNumFormatter stringFromNumber:integer];
    return formatted;
}

+ (NSNumber *)numberFromString:(NSString *)string locale:(NSLocale *)locale
{
	// localization allows other thousands separators, also.
	NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
	[myNumFormatter setLocale:locale];
	[myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
	[myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	
	NSNumber *tempNum = [myNumFormatter numberFromString:string];
	
	return tempNum;
}

+ (NSNumber *)integerFromString:(NSString *)string locale:(NSLocale *)locale
{
    // localization allows other thousands separators, also.
    NSNumberFormatter * myNumFormatter = [[NSNumberFormatter alloc] init];
    [myNumFormatter setLocale:locale];
    [myNumFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [myNumFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [myNumFormatter setGeneratesDecimalNumbers:NO];
    [myNumFormatter setMinimumFractionDigits:0];
    [myNumFormatter setMaximumFractionDigits:0];
    
    NSNumber *tempNum = [myNumFormatter numberFromString:string];
    
    return [NSNumber numberWithInt:tempNum.intValue];
}

+ (NSNumber *)currencyFromString:(NSString *)string locale:(NSLocale *)locale
{
  NSNumberFormatter *currencyFormatter = [self currencyFormatter:locale];
  return [currencyFormatter numberFromString:string];
}

+ (NSNumber *)percentageFromString:(NSString *)string locale:(NSLocale *)locale
{
  NSMutableString *mstring = [string mutableCopy];
  
  NSString* localeSeparator = [locale objectForKey:NSLocaleGroupingSeparator];
  NSString* localeDecSeparator = [locale objectForKey:NSLocaleDecimalSeparator];
  NSString* currencySymbol = [locale objectForKey:NSLocaleCurrencySymbol];
  
  // Cancello i separatori delle migliaia ...
  mstring = [[mstring stringByReplacingOccurrencesOfString:localeSeparator withString:@""] mutableCopy];
  // ... il simbolo della valuta ...
  mstring = [[mstring stringByReplacingOccurrencesOfString:currencySymbol withString:@""] mutableCopy];
  // ... gli spazi vuoti ...
  mstring = [[mstring stringByReplacingOccurrencesOfString:@" " withString:@""] mutableCopy];
  // ... e i separatori dei decimali ...
  mstring = [[mstring stringByReplacingOccurrencesOfString:localeDecSeparator withString:@""] mutableCopy];
  // ... e il %
  mstring = [[mstring stringByReplacingOccurrencesOfString:@"%" withString:@""] mutableCopy];
  
  NSNumber *number = @([mstring intValue] / 1000.0);
  
  return number;
}

@end
