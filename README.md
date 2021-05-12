# KatexUtils

`KatexUtils` provides a UIView `KatexView` to render a LaTeX expression for iOS apps using KaTeX. It also provide a wrapper of KaTeX engine called `KatexRenderer` to access KaTeX's `renderToString` API. 

[![Version](https://img.shields.io/cocoapods/v/KatexUtils.svg?style=flat)](https://cocoapods.org/pods/KatexUtils)
[![License](https://img.shields.io/cocoapods/l/KatexUtils.svg?style=flat)](https://cocoapods.org/pods/KatexUtils)
[![Platform](https://img.shields.io/cocoapods/p/KatexUtils.svg?style=flat)](https://cocoapods.org/pods/KatexUtils)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

Use `KatexView` to create a UIView that renders a LaTeX formula:

```swift
var katexView = KatexView(latex: "a^2 + b^2 = c^2")
```


Use custom rendering options just like in KaTeX:

```swift
var katexView = KatexView(latex: #"c = \pm\sqrt{a^2 + b^2}\in\RR"#,
                          options: [
                            .displayMode: true,
                            .macros: [#"\RR"#: #"\mathbb{R}"#]
                          ])
```

`KatexView` will automaticlly make itself scrollable when it's frame can not contains the whole formula. You can also observe the  `status` property to handle error or do some customize change when rendering is finished successfully:

```swift
cancellable = katexView.$status.sink { [weak self] status in
    let MAXWIDTH : CGFloat = 300.0
    let MAXHEIGHT : CGFloat = 100.0
    let contentSize = self?.katexView.intrinsicContentSize

    switch status {
    case .finished:
        self?.katexView.frame =
            CGRect(x: 0,
                   y: 0,
                   width: min(contentSize?.width ?? .infinity, MAXWIDTH),
                   height: min(contentSize?.height  ?? .infinity, MAXHEIGHT))
    case .error(let message):
        fatalError(message)
    default:
        return
    }
}
```

`KatexRenderer` use KaTeX to render a LaTeX formula to a HTML string:

```swift
let str = KatexRenderer.renderToString(latex: "a^2 + b^2 = c^2", options: [.displayMode : true])
```

## Requirements

- iOS 13.0
- Swift 5.3

## Installation

### CocoaPods

KatexUtils is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'KatexUtils', '~> 0.3.0'
```

### Installation with Swift Package Manager

Once you have your Swift package set up, adding KatexUtils as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/nks5117/KatexUtils.git", .upToNextMinor(from: "0.3.0"))
]
```

## Author

Ni Kesu, 1026001096@qq.com

## License

KatexUtils is available under the MIT license. See the LICENSE file for more info.
