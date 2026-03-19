# SnapStyleExamples

This target provides example views that are shared between the package previews and the demo app (`SnapStyleDemo`). It is **not intended for consumers** of the `SnapStyle` library.

## Architecture

Example views are defined with `package` access level inside the implementation targets (e.g. `5-Layout/Examples/`). This allows them to be used directly in `#Preview` blocks within the same target, while keeping them invisible to external consumers of the package.

Since the demo app is an Xcode project (not a target within this Swift package), it cannot see `package`-level types. The `SnapStyleExamples` target acts as a bridge: it is part of the same Swift package (so it can access `package` types), and it provides thin `public` wrapper views that the demo app can use.

```
Implementation Target (e.g. 5-Layout)
├── Examples/
│   └── StyleStackExample.swift          <- package access, used in #Preview blocks
│
X-Examples (this target)
├── ExampleStyleStack+Public.swift       <- public wrapper, used by demo app
```

## How to add a new example

1. Create a `package struct` in the appropriate implementation target's `Examples/` directory.
2. Add `#Preview` blocks in that file or use the example in other previews within the same target.
3. Create a `public struct` wrapper in this target (`X-Examples/`) that delegates to the `package` type.

## Constraints

- Examples can only use types available in their target's dependency chain. An example in `5-Layout` cannot use types from `6-Views`.
- Examples in a target are usable in previews of that target and any target that depends on it, but not in targets lower in the dependency chain (that would be a circular dependency).

## Manual configuration

The demo app (`SnapStyleDemo.xcodeproj`) was manually configured to depend on `SnapStyleExamples`:

- **Target:** SnapStyleDemo
- **General > Frameworks, Libraries, and Embedded Content:** `SnapStyleExamples` was added from the `snap-style` local package reference.
