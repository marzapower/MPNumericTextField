//
//  MPTextField.h
//  BasicExample
//
//  Version 1.2.0
//
//  Created by Daniele Di Bernardo on 05/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNumericTextFieldDelegate.h"
#import "MPFormatterUtils.h"

enum MPNumericTextFieldType {
  MPNumericTextFieldDecimal = 0,
  MPNumericTextFieldCurrency,
  MPNumericTextFieldPercentage
};

@interface MPNumericTextField : UITextField

@property (nonatomic, strong) NSString                     *encodedValue;
@property (nonatomic, strong) UIColor                      *placeholderColor;
@property (nonatomic, assign) enum MPNumericTextFieldType   type;
@property (nonatomic, strong) NSLocale                     *locale;
@property (nonatomic, getter = numericDelegate) MPNumericTextFieldDelegate   *numericDelegate;

@end
