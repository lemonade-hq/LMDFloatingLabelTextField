# LMDTextField

[![CI Status](http://img.shields.io/travis/talthent-l/LMDFloatingLabelTextField.svg?style=flat)](https://travis-ci.org/talthent-l/LMDFloatingLabelTextField)
[![Version](https://img.shields.io/cocoapods/v/LMDFloatingLabelTextField.svg?style=flat)](http://cocoapods.org/pods/LMDFloatingLabelTextField)
[![License](https://img.shields.io/cocoapods/l/LMDFloatingLabelTextField.svg?style=flat)](http://cocoapods.org/pods/LMDFloatingLabelTextField)
[![Platform](https://img.shields.io/cocoapods/p/LMDFloatingLabelTextField.svg?style=flat)](http://cocoapods.org/pods/LMDFloatingLabelTextField)

## Demo

![alt text](https://github.com/lemonade-hq/LMDTextField/blob/master/Screenshots/demo.gif)

## Screenshot

![alt text](https://github.com/lemonade-hq/LMDTextField/blob/master/Screenshots/screenshot1.PNG)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### Cocoapods

Install Cocoapods

```bash
$ gem install cocoapods
```

Add `LMDFloatingLabelTextField` in your `Podfile`.

```ruby
use_frameworks!

pod 'LMDFloatingLabelTextField'
```

Install the pod

```bash
$ pod install
```

### Manually

Copy `LMDFloatingLabelTextField` folder to your project. Enjoy.

## Customizable Properties

`placeholderText` - Please make sure you put something here. it will look awful without it.

`placeholderFont` - Default is system(14).

`placeholderSizeFactor` - While editing, placeholder will shrink according to this number. deafult is 0.7.

`placeholderTextColor` - Default is - ![#B7B7B7](https://placehold.it/15/B7B7B7/000000?text=+) `#B7B7B7`

`themeColor` - Replaces tintColor. Carret color. default is ![#FF0083](https://placehold.it/15/FF0083/000000?text=+) `#FF0083`

`borderColor` - Border color while editing. default is ![#4a4a4a](https://placehold.it/15/4a4a4a/000000?text=+) `#4a4a4a`

`errorBorderColor` - Border color on error. default is ![#FF0083](https://placehold.it/15/FF0083/000000?text=+) `#FF0083`

`textFieldTextColor` - Replaces textColor. default is ![#4A4A4A](https://placehold.it/15/4A4A4A/000000?text=+) `#4A4A4A`

`disabledTextColor` - TextColor when textfield is disabled. default is ![#B7B7B7](https://placehold.it/15/B7B7B7/000000?text=+) `#B7B7B7`

`disabledBackgroundColor` - Background color when textfield is disabled. default is ![#f7f7f7](https://placehold.it/15/f7f7f7/000000?text=+) `#f7f7f7`

`enabledBackgroundColor` - Background color when textfield is not disabled. default is ![#FFFFFF](https://placehold.it/15/FFFFFF/000000?text=+) `#FFFFFF`
    
## Author

Tal Cohen, talthent@gmail.com

LEMONADE INC.

## License

LMDFloatingLabelTextField is available under the MIT license. See the LICENSE file for more info.
