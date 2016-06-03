//
//  MPNumericTextFieldDelegate.m
//
//  Version 1.1.0
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 Charcoal Design. All rights reserved.
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

#import "MPNumericTextFieldDelegate.h"
#import "MPNumericTextField.h"
#import "MPFormatterUtils.h"

#ifndef min
#define min(a,b) a < b ? a : b
#endif

@implementation MPNumericTextFieldDelegate

/*
 * Reads the forward delegate from the `MPNumericTextField` instance, if present.
 * If the `textField` object is not a numeric text field returns a nil value.
 */
- (id<UITextFieldDelegate>) getForwardDelegateFrom:(UITextField *)textField {
  if ([textField isKindOfClass:[MPNumericTextField class]]) {
    return ((MPNumericTextField *)textField).forwardDelegate;
  }
  return nil;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
    return [delegate textFieldShouldBeginEditing:textField];
  } else {
    return YES;
  }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
    return [delegate textFieldDidBeginEditing:textField];
  }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
    return [delegate textFieldShouldEndEditing:textField];
  } else {
    [textField resignFirstResponder];
    return YES;
  }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
    return [delegate textFieldDidEndEditing:textField];
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
    return [delegate textFieldShouldReturn:textField];
  } else {
    [textField resignFirstResponder];
    return YES;
  }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
  BOOL result = YES;
  id delegate = [self getForwardDelegateFrom:textField];
  if (delegate && [delegate respondsToSelector:@selector(textFieldShouldClear:)]) {
    result = [delegate textFieldShouldClear:textField];
  }
  
  if (result && [textField isKindOfClass:MPNumericTextField.class]) {
    MPNumericTextField *fxText = (MPNumericTextField *)textField;
    fxText.encodedValue = nil;
  }
  
  return result;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  if (![textField isKindOfClass:MPNumericTextField.class]) {
    return YES;
  }
  
  BOOL result = NO; //default to reject
  
  MPNumericTextField *fxText = (MPNumericTextField *)textField;
  NSLocale *locale = fxText.locale;
  NSNumberFormatter *currencyFormatter = [MPFormatterUtils currencyFormatter:locale];
  
  NSMutableCharacterSet *numberSet = [[NSCharacterSet decimalDigitCharacterSet] mutableCopy];
  [numberSet formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
  NSCharacterSet *nonNumberSet = [numberSet invertedSet];
  
  if([string length] == 0){ //backspace
    result = YES;
  }
  else{
    if([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0){
      result = YES;
    }
  }
  
  //here we deal with the UITextField on our own
  if (result){
    //grab a mutable copy of what's currently in the UITextField
    NSMutableString* oldString = [[textField text] mutableCopy];
    NSNumber *n = nil;
    double mul;
    
    switch (fxText.type) {
      case MPNumericTextFieldCurrency:
        n = [MPFormatterUtils currencyFromString:fxText.encodedValue locale:locale];
        mul = pow(10, [currencyFormatter maximumFractionDigits] + 1);
        n = @(round(([n doubleValue] * mul))/10);
        break;
      case MPNumericTextFieldDecimal:
        n = [MPFormatterUtils numberFromString:fxText.encodedValue locale:locale];
        mul = pow(10, [currencyFormatter maximumFractionDigits] + 1);
        n = @(round(([n doubleValue] * mul))/10);
        break;
      case MPNumericTextFieldPercentage:
        n = [MPFormatterUtils percentageFromString:fxText.encodedValue locale:locale];
        n = @(round(([n doubleValue] * 10000))/10);
        break;
      case MPNumericTextFieldInteger:
        n = [MPFormatterUtils integerFromString:fxText.encodedValue locale:locale];
        break;
    }
    
    NSMutableString* mstring = [[n stringValue] mutableCopy];
    
    @try {
      if([mstring length] == 0){
        //special case...nothing in the field yet, so set a currency symbol first
        [mstring appendString:[locale objectForKey:NSLocaleCurrencySymbol]];
        
        //now append the replacement string
        [mstring appendString:string];
      }
      else {
        range.location -= [oldString length] - [mstring length];
        //adding a char or deleting?
        if([string length] > 0){
          [mstring insertString:string atIndex:range.location];
        }
        else {
          //delete case - the length of replacement string is zero for a delete
          range.length = min(range.length, [mstring length]);
          [mstring deleteCharactersInRange:range];
        }
      }
    }
    @catch (__unused id exception) {
      mstring = [@"" mutableCopy];
    }
    
    NSNumber *number = [MPFormatterUtils numberFromString:mstring locale:locale];
    double rate = pow(10, currencyFormatter.maximumFractionDigits);
    
    //now format the number back to the proper currency string
    //and get the grouping separators added in and put it in the UITextField
    switch (fxText.type) {
      case MPNumericTextFieldCurrency:
        number = @(number.doubleValue / rate);
        fxText.encodedValue = [MPFormatterUtils stringFromCurrency:number locale:locale];
        break;
      case MPNumericTextFieldDecimal:
        number = @(number.doubleValue / rate);
        fxText.encodedValue = [MPFormatterUtils stringFromNumber:number locale:locale];
        break;
      case MPNumericTextFieldPercentage:
        number = [MPFormatterUtils percentageFromString:mstring locale:locale];
        fxText.encodedValue = [MPFormatterUtils stringFromPercentage:number locale:locale];
        break;
      case MPNumericTextFieldInteger:
        number = @(number.integerValue);
        fxText.encodedValue = [MPFormatterUtils stringFromInteger:number locale:locale];
    }
  }
  
  //always return no since we are manually changing the text field
  return NO;
}

@end
