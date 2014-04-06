MPNumericTextField
==================

Installation
------------

### Manually

Just add to your project these main files:
  1. MPNumericTextField.h
  2. MPNumericTextField.m
  3. MPNumericTextFieldDelegate.h
  4. MPNumericTextFieldDelegate.m
  5. MPFormatterUtils.h
  6. MPFormatterUtils.m

### Using [CocoaPods][cocoapods]

[cocoapods]: http://cocoapods.org/

Just add the following line to the `Podfile` in your project:

```ruby
pod "MPNumericTextField"
```

Usage
-----

You can create a very simple numeric text field using:

```objc
MPNumericTextField *textField = [[MPNumericTextField alloc] init];
```

This will create a text field that will handle the input of decimal numbers, using the current locale
and the local text field delegate implementation (see `MPNumericTextFieldDelegate.{h|m}`).