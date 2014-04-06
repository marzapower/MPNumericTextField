//
//  MPFormatterUtils.m
//
//  Version 1.0.0
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
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
