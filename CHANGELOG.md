# Change Log

## v0.3.3 (2021-05-16)
- New `Katex` class, allow use a custom `jsContext`.
- `KatexRenderer` is now just a wrapper of `Katex`.

## v0.3.2 (deprecated)

## v0.3.1 (2021-05-14)

- Change the default value of `KatexView.clipsToBounds` to `true`.
- Set to `KatexView.maxSize` will not reload the view if the new value is equal to the old one.
- `KatexRenderer.jsContext` is now public.

## v0.3.0 (2021-05-12)

- Add support for Swift Package Manager.
- `KatexRenderer.renderToString(latex:options:)` now returns a non-optional value instead of an optional one.


## v0.2.3

The `backgroundColor` property of `KatexView`'s inner webview is now setted to `.clear` instead of `.white`.


## v0.2.2

`KatexView` now support custom CSS. You can use its `customCss` property to control the display style. For example, to set the font-size to 1.1x:

```swift
katexView.customCss = ".katex { font-size: 1.1em; }"
```
