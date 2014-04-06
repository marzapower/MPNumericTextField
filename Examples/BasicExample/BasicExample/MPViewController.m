//
//  MPViewController.m
//  BasicExample
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//

#import "MPViewController.h"

@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  UIColor *placeholderColor = [UIColor lightGrayColor];
  _decimalField.placeholderColor = placeholderColor;
  _percentageField.placeholderColor = placeholderColor;
  _currencyField.placeholderColor = placeholderColor;
  
  _decimalField.type = MPNumericTextFieldDecimal;
  _percentageField.type = MPNumericTextFieldPercentage;
  _currencyField.type = MPNumericTextFieldCurrency;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
