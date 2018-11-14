# MPModalView

[![Version](https://img.shields.io/cocoapods/v/MPModalView.svg?style=flat)](https://cocoapods.org/pods/MPModalView)
[![License](https://img.shields.io/cocoapods/l/MPModalView.svg?style=flat)](https://cocoapods.org/pods/MPModalView)
[![Platform](https://img.shields.io/cocoapods/p/MPModalView.svg?style=flat)](https://cocoapods.org/pods/MPModalView)

## Example

![](https://github.com/cyrus86/MPModalView/blob/master/screencapture.gif)

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

MPModalView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MPModalView'
```

## Usage

```swift
let modal = MPModalViewController(actionButtons: [ActionButton(type: .cancel),
                                                  ActionButton(type: .ok) { print("some callback") }],
                                  contentView: .text(title: "Modal", body: "with OK & Cancel button"))
modal.presentOnTop()
```

## Author

Martin Pfundmair, github@martin.pfundmair.de

## License

MPModalView is available under the MIT license. See the LICENSE file for more info.
