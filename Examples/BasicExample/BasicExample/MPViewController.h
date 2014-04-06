//
//  MPViewController.h
//  BasicExample
//
//  Created by Daniele Di Bernardo on 06/04/14.
//  Copyright (c) 2014 marzapower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MPNumericTextField.h"

@interface MPViewController : UIViewController

@property(nonatomic, strong) IBOutlet MPNumericTextField *decimalField;
@property(nonatomic, strong) IBOutlet MPNumericTextField *percentageField;
@property(nonatomic, strong) IBOutlet MPNumericTextField *currencyField;

- (IBAction)getValues:(id)sender;

@end