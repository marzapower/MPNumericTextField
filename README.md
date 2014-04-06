MPNumericTextField
==================

`MPNumericTextField` is a class that extends the basic `UITextField` to make you easily input formatted numbers in a text field.

It correctly handles decimal numbers, percentages and currency values, using either the current locale or a manually provided one.

Installation
------------

### Using [CocoaPods][cocoapods] (preferred one!)

[cocoapods]: http://cocoapods.org/

Just add the following line to the `Podfile` in your project:

```ruby
pod "MPNumericTextField", '~> 1.0.0'
```

### Manually

Just add to your project these main files:

  1. `MPNumericTextField.h`
  2. `MPNumericTextField.m`
  3. `MPNumericTextFieldDelegate.h`
  4. `MPNumericTextFieldDelegate.m`
  5. `MPFormatterUtils.h`
  6. `MPFormatterUtils.m`

that can be found inside the `Classes` folder.


Usage
-----

You can create a very simple numeric text field using:

```objective-c
MPNumericTextField *textField = [[MPNumericTextField alloc] init];
```

This will create a text field that will handle the input of decimal numbers, using the current locale
and the local text field delegate implementation (see `MPNumericTextFieldDelegate.{h|m}`).

### Decimal, percentage or currency?

You can change the default number style for the text field via the `type` property. It can be set to one of these values:

  1. `MPNumericTextFieldDecimal` (default one)
  2. `MPNumericTextFieldCurrency`
  2. `MPNumericTextFieldPercentage`

Eg. to change the number style of your text field to currency just do:

```objective-c
numericTextField.type = MPNumericTextFieldCurrency;
```

### Locales

By default behavior the `MPNumericTextField` will use the `[NSLocale currentLocale]` locale. But you can easily change this property too:

```objective-c
numericTextField.locale = myCustomLocale;
```

### Delegates

The `MPNumericTextField` class seamlessly uses the `MPNumericTextFieldDelegate` class as its own delegate. This delegate handles all the
logics that makes the text field draw numbers with the correct format while the user inserts numbers.

If you need to add a custom delegate to the text field, be sure to override this method in your delegate implementation:


```objective-c
- (BOOL)textField:(UITextField *)textField
        shouldChangeCharactersInRange:(NSRange)range
        replacementString:(NSString *)string{

  if ([textField isKindOfClass:MPNumericTextField.class]) {
    MPNumericTextField *numericTextField = (MPNumericTextField *)textField;
    return [numericTextField.numericDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
  } else {
    return YES;
  }
}
```

otherwise the `MPNumericTextField` will not work as intended.
