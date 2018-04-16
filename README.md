[MetovaJSONCodable](https://cocoapods.org/pods/MetovaJSONCodable)

<p align="center">
<a href="https://travis-ci.org/metova/MetovaJSONCodable" target="_blank"><img src="https://travis-ci.org/metova/MetovaJSONCodable.svg?branch=master" alt="Build Status"></a> 
<a href="https://cocoapods.org/pods/MetovaJSONCodable" target="_blank"><img src="https://img.shields.io/cocoapods/v/MetovaJSONCodable.svg" alt="CocoaPods Compatible"/></a>
<a href="http://metova.github.io/MetovaJSONCodable/" target="_blank"><img src="https://cdn.rawgit.com/metova/MetovaJSONCodable/master/docs/badge.svg" alt="Documentation"/></a>
<a href="https://coveralls.io/github/metova/MetovaJSONCodable?branch=master" target="_blank"><img src="https://coveralls.io/repos/github/metova/MetovaJSONCodable/badge.svg?branch=master&dummy=no_cache_please_1" alt="Coverage Status"/></a>
<a href="http://cocoadocs.org/docsets/MetovaJSONCodable" target="_blank"><img src="https://img.shields.io/cocoapods/p/MetovaJSONCodable.svg?style=flat" alt="Platform"/></a>
<a href="http://twitter.com/metova" target="_blank"><img src="https://img.shields.io/badge/twitter-@Metova-3CAC84.svg" alt="Twitter"/></a>
<br/>
</p>

MetovaJSONCodable is a lightweight Codable protocol with addtional support for JSON

- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
    - [Object example](#object-example)
    - [JSON](#json)
- [Documentation](#documentation)
- [Credits](#credits)
- [License](#license)

## Requirements

- Swift 4.0
- iOS 9+

## Installation

MetovaJSONCodable is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'MetovaJSONCodable'
```

## Usage

Any object that previously conformed to the Codable protocol can now use the JSONCodable protocol.

#### Object example

```swift
struct Token: JSONCodable {

   var tokenID: Int
   var email: String
   var authenticationToken: String
}
```

#### JSON

```swift
let tokenJSON: JSON =
    [
    "testID": 1,
    "email": "test@email.com",
    "authenticationToken": "token"
    ]
    
let token = Token(from: tokenJSON)
```

## Documentation

Documentation can be found [here](http://metova.github.io/MetovaJSONCodable/).

## Credits

MetovaJSONCodable is owned and maintained by [Metova Inc.](https://metova.com)

[Contributors](https://github.com/Metova/MetovaJSONCodable/graphs/contributors)

## License

MetovaJSONCodable is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
