# Change Log

## v0.2.3

The `backgroundColor` property of `KatexView`'s inner webview is now setted to `.clear` instead of `.white`.

## v0.2.2

`KatexView` now support custom CSS. You can use its `customCss` property to control the display style. For example, to set the font-size to 1.1x:

```swift
katexView.customCss = ".katex { font-size: 1.1em; }"
```
