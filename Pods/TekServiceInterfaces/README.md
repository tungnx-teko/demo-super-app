# TekServiceInterfaces

[![CI Status](https://img.shields.io/travis/linhvt-teko/TekServiceInterfaces.svg?style=flat)](https://travis-ci.org/linhvt-teko/TekServiceInterfaces)
[![Version](https://img.shields.io/cocoapods/v/TekServiceInterfaces.svg?style=flat)](https://cocoapods.org/pods/TekServiceInterfaces)
[![License](https://img.shields.io/cocoapods/l/TekServiceInterfaces.svg?style=flat)](https://cocoapods.org/pods/TekServiceInterfaces)
[![Platform](https://img.shields.io/cocoapods/p/TekServiceInterfaces.svg?style=flat)](https://cocoapods.org/pods/TekServiceInterfaces)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

TekServiceInterfaces is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'TekServiceInterfaces'
```

## Build instruction

If you want to contribute, please follow this instruction

1. When adding new file, please select target `TekServiceInterfaces`, uncheck target `Pods-TekServiceInterfaces_Tests`, and then run `pod install` in `Example` folder.
2. Increase version in podspec file
3. Create new tag version: `git tag <version>`
4. Push to origin: `git push --tags`
5. Add repo, this should be run once each machine: `pod repo add teko-specs https://github.com/teko-vn/Specs-ios.git`
6. Push repo: `pod repo push teko-specs TekServiceInterfaces.podspec --verbose --allow-warnings`

## Author

linhvt-teko, linh.vt@teko.vn

## License

TekServiceInterfaces is available under the MIT license. See the LICENSE file for more info.
