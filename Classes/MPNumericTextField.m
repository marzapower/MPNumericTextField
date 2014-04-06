//
//  MPTextField.m
//  BasicExample
//
//  Version 1.2.0
//
//  Created by Daniele Di Bernardo on 05/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//

#import "MPNumericTextField.h"

MPNumericTextFieldDelegate *numericDelegate;

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
  self.type = MPNumericTextFieldDecimal;
  self.delegate = self.numericDelegate;
  self.textAlignment = NSTextAlignmentRight;
}

- (void) setType:(enum MPNumericTextFieldType)type {
  _type = type;
  
  NSNumber *number = [MPFormatterUtils numberFromString:self.encodedValue locale:self.locale];
  switch (type) {
    case MPNumericTextFieldPercentage:
      self.placeholder = [MPFormatterUtils stringFromPercentage:number locale:self.locale];
      break;

    case MPNumericTextFieldCurrency:
      self.placeholder = [MPFormatterUtils stringFromCurrency:number locale:self.locale];
      break;

    case MPNumericTextFieldDecimal:
      self.placeholder = [MPFormatterUtils stringFromNumber:number locale:self.locale];
      break;
  }
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
  if (self.placeholderColor != nil) {
    CGRect placeholderRect = [self placeholderRectForBounds:self.bounds];
    
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

@end
