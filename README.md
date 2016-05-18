# OKObserver

A lightweight framework which makes KVO easily to use.

[![CI Status](http://img.shields.io/travis/Draveness/OKObserver.svg?style=flat)](https://travis-ci.org/Draveness/OKObserver)
[![Version](https://img.shields.io/cocoapods/v/OKObserver.svg?style=flat)](http://cocoapods.org/pods/OKObserver)
[![License](https://img.shields.io/cocoapods/l/OKObserver.svg?style=flat)](http://cocoapods.org/pods/OKObserver)
[![Platform](https://img.shields.io/cocoapods/p/OKObserver.svg?style=flat)](http://cocoapods.org/pods/OKObserver)

## Installation

OKObserver is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "OKObserver"
```

## Usage

Use `OKObserver` to bind view and model.

```objectivec
[OKObserve(object, color) update:OKObserve(self.view, backgroundColor)];
```

Easily to use API for KVO

```objectivec
[OKObserve(object, color) whenUpdated:^(UIColor *backgroundColor) {
    self.view.backgroundColor = backgroundColor;
}];
```

The two usage above has the same function.

## Author

Draveness, stark.draven@gmail.com

## License

OKObserver is available under the MIT license. See the LICENSE file for more info.
