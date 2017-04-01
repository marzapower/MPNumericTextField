MPNumericTextField
==================

`MPNumericTextField` is a class that extends the basic `UITextField` to make you easily input formatted numbers in a text field.

It correctly handles decimal numbers, integer numbers, percentages and currency values, using either the current locale or a manually provided one.

![Screenshot of BasicExample](https://raw.githubusercontent.com/marzapower/MPNumericTextField/master/Examples/BasicExample/screenshot.png)

Installation
------------

### Using [CocoaPods][cocoapods] (preferred one!)

[cocoapods]: http://cocoapods.org/

Just add the following line to the `Podfile` in your project:

```ruby
pod "MPNumericTextField", '~> 1.4.0'
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
  2. `MPNumericTextFieldInteger`
  3. `MPNumericTextFieldCurrency`
  4. `MPNumericTextFieldPercentage`

Eg. to change the number style of your text field to currency just do:

```objective-c
numericTextField.type = MPNumericTextFieldCurrency;
```

### Getting and setting the numeric value

You can access the numeric value of your text field via the `numericValue` property. Eg:

```objective-c
MPNumericTextField *textField = [[MPNumericTextField alloc] init];
textField.type = MPNumericTextFieldPercentage;
textField.numericValue = @(2.25);

// ... (make changes to the text field) ...

NSNumber *currentValue = textField.numericValue;
```

### Locales

By default behavior the `MPNumericTextField` will use the `[NSLocale currentLocale]` locale. But you can easily change this property too:

```objective-c
numericTextField.locale = myCustomLocale;
```

### Custom currencies

When using `MPNumericTextField` for displaying currencies, an old limitation was to be stuck with the currency code provided by `NSLocale`.

Starting from v. 1.3.0 it's possible to set a custom currency code to represent those values using the desired currency:

```objective-c
numericTextField.currencyCode = @"JPY";
```

### Delegates

The `MPNumericTextField` class seamlessly uses the `MPNumericTextFieldDelegate` class as its own delegate. This delegate handles all the
logics that makes the text field draw numbers with the correct format while the user inserts numbers.

You can decide to set a new custom delegate for your objects, and the `MPNumericTextField` will treat them as forward delegates
to make them work correctly with the existing one.

Unlike version 1.0.0 of this library, starting from 1.1.0 you can start using the standard `-setDelegate:` and `-delegate` methods
from `UITextField` to set up your custom delegates without worrying about the basic numeric field functionalities.

### Bonus: placeholder color

You can choose to change the default placeholder color in your text field. Just use the `placeholderColor` property:

```objective-c
numericTextField.placeholderColor = [UIColor redColor];
```

If this property is set to `nil`, it will use the default system color.


## Support

Feel free to apport changes to the source code of this project and to send a pull request on Github to merge your contribution to the original project.

If you need further assistance, please contact me on Twitter: [@marzapower][twitter].

[twitter]: http://www.twitter.com/marzapower

## Release notes

Version 1.4.0

 - [new] The new `MPTextField` class opens the usage of `placeholderColor` outside of the handling of the numeric text field
 - [fix] No more default right alignement for the text field if loaded from a NIB file

Version 1.3.0

 - [new] Custom currency codes for the text field
 - [new] Nullability modifiers for the utility methods in `MPFormatterUtils`

Version 1.2.1

 - [fix] Doesn't use cached locale anymore when system locale changes

Version 1.2.0

 - [New] Added support to integer-only numbers with `MPNumericTextFieldInteger`
 - [Enh] Better support for Swift integration

Version 1.1.0

 - [Fix] Added support for all delegate methods in `MPNumericTextFieldDelegate`
 - [New] Added support for custom delegates without boilerplate code
 - [New] Added IB_DESIGNABLE keyword to `MPNumericTextField`
 - [Enh] Some little code enhancements

Version 1.0.0

 - First public release
