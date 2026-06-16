@../snap/agents/AGENTS.md

# SnapStyle

A semantic styling system for SwiftUI (iOS 17+, macOS 15+). All styling state flows through `@Environment(\.style)` as a `ContextWrapper` (bundles `Style` + `Context`).

## Target Structure

Strictly layered — dependencies only flow downward:

| Target | Purpose |
|--------|---------|
| `1-Base` | `Style`, `Context`, attribute protocols, caching |
| `2-Components` | `Component`, `Element`, `Container` definitions |
| `3-Definitions` | Built-in attribute key path definitions and preset values |
| `4-Modifier` | View modifiers (`.style()` family) |
| `5-Layout` | Styled views (`StyleScreen`, `StyleStack`, `StyleButton`, etc.) |
| `6-Views` | Utility layout views |
| `X-Debug` / `X-Examples` | Debug / example views |

## Attributes

Seven types in two groups:
- *Core* (`Icon`, `Number`, `Surface`): applied at the style/component level.
- *Element* (`Composition`, `Font`, `Padding`, `Shape`): implement `StyleElementAttribute`, making them mappable per `ElementType` in a `Component`. Adding a new element-mappable attribute requires implementing `StyleElementAttribute` and registering one `@Entry` environment key per `ElementType` in `3-Definitions`.

## Container

`Container.Properties` is the static style descriptor passed via `Component.container`; `Container` is the live runtime instance built from the stack during rendering.

## Value Resolution

```swift
.base(.value(...))                    // static
.base(.reference(\.otherKeyPath))     // reference another key path
.builder { context in ... }           // dynamic from Context
.builderWrapper { contextWrapper in } // access Style + Context + caches
```

## View Modifier Chain

```swift
.styleSetup(style)    // root setup — once at app root
.style(component: _)  // apply component mapping & container
.style(element: _)    // assign semantic element role
.style(font:)         // direct attribute application
.styleOverride()      // override definitions for a subtree
```

## Testing

Tests use helper key paths defined in `TestHelpers.swift` (e.g., `\.testNumber`, `\.testSurface`).
