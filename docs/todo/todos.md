# TODO

Outstanding work on the package.

## TODO-1: Demo-only library product

`SnapStyleExamples` is a public library product, although it only exists so the demo app can access example views. Every product is visible to consumers.

- Decide whether the demo can access the example views without a public product. An Xcode project can only depend on products, not on targets.
- If it can, remove the product. Otherwise, keep it and remove this item.
