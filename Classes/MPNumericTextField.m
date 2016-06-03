//
//  MPTextField.m
//
//  Version 1.1.0
//
//  Created by Daniele Di Bernardo on 05/04/14.
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

#import "MPNumericTextField.h"

MPNumericTextFieldDelegate *numericDelegate;

@interface MPNumericTextField()

@property (nonatomic, strong) MPNumericTextFieldDelegate *numericDelegate;

@end

@implementation MPNumericTextField

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self setDefaults];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self setDefaults];
  }
  return self;
}

- (id)init {
  if ((self = [super init])) {
    [self setDefaults];
  }
  return self;
}

- (void) setDefaults {
  self.locale = [NSLocale currentLocale];
  self.keyboardType = UIKeyboardTypeDecimalPad;
  self.type = MPNumericTextFieldDecimal;
  self.delegate = self.numericDelegate;
  self.textAlignment = NSTextAlignmentRight;
}

- (void) setType:(MPNumericTextFieldType)type {
  _type = type;
  
  switch (type) {
    case MPNumericTextFieldPercentage:
      self.placeholder = [MPFormatterUtils stringFromPercentage:@(0) locale:self.locale];
      self.keyboardType = UIKeyboardTypeDecimalPad;
      break;

    case MPNumericTextFieldCurrency:
      self.placeholder = [MPFormatterUtils stringFromCurrency:@(0) locale:self.locale];
      self.keyboardType = UIKeyboardTypeDecimalPad;
      break;

    case MPNumericTextFieldDecimal:
      self.placeholder = [MPFormatterUtils stringFromNumber:@(0) locale:self.locale];
      self.keyboardType = UIKeyboardTypeDecimalPad;
      break;
    
    case MPNumericTextFieldInteger:
      self.placeholder = [MPFormatterUtils stringFromInteger:@(0) locale:self.locale];
      self.keyboardType = UIKeyboardTypeNumberPad;
      break;
  }
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
  if (self.placeholderColor != nil) {
    CGRect placeholderRect = CGRectMake(rect.origin.x, (rect.size.height- self.font.pointSize)/2, rect.size.width, self.font.pointSize);
    
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineBreakMode = NSLineBreakByTruncatingTail;
    style.alignment = self.textAlignment;
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font,
                                 NSParagraphStyleAttributeName: style,
                                 NSForegroundColorAttributeName: self.placeholderColor};
    [self.placeholder drawInRect:placeholderRect withAttributes:attributes];
  } else {
    [super drawPlaceholderInRect:rect];
  }
}

- (void)setEncodedValue:(NSString *)encodedValue
{
  _encodedValue = encodedValue;
  self.text = encodedValue;
}

- (MPNumericTextFieldDelegate *) numericDelegate {
  if (numericDelegate == nil) {
    numericDelegate = [[MPNumericTextFieldDelegate alloc] init];
  }
  return numericDelegate;
}

- (void) setNumericValue:(NSNumber *)value {
  switch (_type) {
    case MPNumericTextFieldCurrency:
      self.encodedValue = [MPFormatterUtils stringFromCurrency:value locale:_locale];
      break;
    case MPNumericTextFieldDecimal:
      self.encodedValue = [MPFormatterUtils stringFromNumber:value locale:_locale];
      break;
    case MPNumericTextFieldPercentage:
      self.encodedValue = [MPFormatterUtils stringFromPercentage:value locale:_locale];
      break;
    case MPNumericTextFieldInteger:
      self.encodedValue = [MPFormatterUtils stringFromInteger:value locale:_locale];
      break;
  }
  
  self.text = self.encodedValue;
}

- (NSNumber *)numericValue {
  switch (_type) {
    case MPNumericTextFieldCurrency:
      return [MPFormatterUtils currencyFromString:_encodedValue locale:_locale];
    case MPNumericTextFieldDecimal:
      return [MPFormatterUtils numberFromString:_encodedValue locale:_locale];
    case MPNumericTextFieldPercentage:
      return [MPFormatterUtils percentageFromString:_encodedValue locale:_locale];
    case MPNumericTextFieldInteger:
      return [MPFormatterUtils integerFromString:_encodedValue locale:_locale];
  }
}

// Override basic delegate setter/getter functions
- (void)setDelegate:(id<UITextFieldDelegate>)delegate {
  if (!delegate || [delegate isKindOfClass:[MPNumericTextFieldDelegate class]]) {
    _forwardDelegate = nil;
    super.delegate = delegate;
  } else {
    _forwardDelegate = delegate;
  }
}

- (id<UITextFieldDelegate>)delegate {
  if (_forwardDelegate)
    return _forwardDelegate;
  else
    return numericDelegate;
}


@end
