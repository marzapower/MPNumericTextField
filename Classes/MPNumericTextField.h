//
//  MPTextField.h
//
//  Version 1.4.0
//
//  Created by Daniele Di Bernardo on 05/04/14.
//  Copyright (c) 2017 marzapower. All rights reserved.
//
//  The MIT License (MIT)
//  
//  Copyright (c) [2014-2017] [Daniele Di Bernardo]
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

#import <UIKit/UIKit.h>
#import "MPNumericTextFieldDelegate.h"
#import "MPFormatterUtils.h"
#import "MPTextField.h"

typedef NS_ENUM(NSUInteger, MPNumericTextFieldType) {
  MPNumericTextFieldDecimal = 0,
  MPNumericTextFieldCurrency,
  MPNumericTextFieldPercentage,
  MPNumericTextFieldInteger
};

IB_DESIGNABLE
@interface MPNumericTextField : MPTextField

@property (nonatomic, copy)   NSString                     *encodedValue;
@property (nonatomic, assign) MPNumericTextFieldType        type;
@property (nonatomic, strong) NSLocale                     *locale;
@property (nonatomic, copy)   NSString                     *currencyCode;
@property (nonatomic, assign) NSNumber                     *numericValue;
@property (nonatomic, readonly) id<UITextFieldDelegate>     forwardDelegate;

@end
