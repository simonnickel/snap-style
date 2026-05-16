@../snap/agents/AGENTS.md

# SnapStyle

A semantic styling system for SwiftUI (iOS 17+, macOS 15+). Views reference visual properties via type-safe key paths (`\.title`, `\.contentCard`). All styling state flows through `@Environment(\.style)` as a `ContextWrapper` (bundles `Style` + `Context`).

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

## Core Types

**Attributes** — eight types split into two groups:
- *Core* (`Accent`, `Icon`, `Number`, `Surface`): applied at the style/component level.
- *Element* (`Composition`, `Font`, `Padding`, `Shape`): implement `StyleElementAttribute`, making them mappable per `ElementType` in a `Component`. When adding a new element-mappable attribute, implement `StyleElementAttribute` and register one `@Entry` environment key per `ElementType` in `3-Definitions`.

**`Style`** — holds `BuilderContainer` (definition storage) and `CacheContainer` (per-attribute caches, invalidated when definitions change).

**`Context`** — dictionary-based accumulated state (color scheme, font design/width, scale factor, component, container stack, element hierarchy).

**`Component`** — groups attribute definitions, maps `ElementType` → key paths for element attributes. Supports `.adjusted()` for variants.

**`Element`** — combines `ElementType` (`.title`, `.label`, `.icon`, `.value`, `.accessory`, `.separator`, `.footnote`) and `Hierarchy` (`.primary`, `.secondary`, `.tertiary`).

**`Container.Properties`** — static style descriptor (`surface`, `composition`, `shape`, `padding`, `border`); passed via `Component.container`. Supports `.adjusted()` for variants.

**`Container`** — live runtime instance wrapping `properties: Container.Properties`, `parent: Container.Properties?`, `state: InteractionState`, nesting `level`.

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
