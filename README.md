<!-- Copy badges from SPI -->
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonnickel/snap-style)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonnickel/snap-style) 

> This package is part of the [SNAP](https://github.com/simonnickel/snap) suite.


# SnapStyle

A semantic styling system for multi-platform SwiftUI apps. Define visual attributes (colors, fonts, spacing, shapes) once, reference them by semantic key paths, and apply them consistently across your views.

[![Documentation][documentation badge]][documentation] 

[documentation]: https://swiftpackageindex.com/simonnickel/snap-style/main/documentation/snapstyle
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue


## Motivation

Without a styling system, design values are scattered across your views:

```swift
Text("Title")
    .font(.system(size: 18, weight: .bold))
    .foregroundStyle(.blue)
    .padding(.horizontal, 16)
```

Changing a value means finding every occurrence. Platform differences require `#if` checks in view code. There is no connection between the font of a title and the font of an icon — each is defined independently.

With SnapStyle, views reference semantic assignments instead of literal values:

```swift
Text("Title")
    .style(element: .title)
    .style(component: .contentCard)
```

The component defines what `.title` means in this context, which font, which foreground color, which padding. The definition can also adapt to the context, e.g. when the container is highlighted, selected, or disabled. Change the definition once and every `.contentCard` in the app updates.

- **Consistency** -- define once, apply everywhere.
- **Maintainability** -- platform-specific adjustments happen in definitions, not in views.
- **DynamicType scaling** -- fonts and numbers (paddings, spacings, corner radii) scale automatically.
- **Context-aware styling** -- values can be defined based on the context, e.g. hierarchy or state (normal, highlighted, disabled, selected) without any logic in your views.
- **Overridability** -- definitions can be overridden at any point in the view hierarchy for theming or user customization.


## Concepts

SnapStyle is built around a few core ideas:

**Attributes** are the types of visual properties you can define: `Surface` (colors/materials), `Font`, `Number` (dimensions/spacing), `Padding`, `Shape`, `Icon`, `Accent`, and `Composition` (layered combinations of surface, foreground, and background).

**Definitions** assign values to semantic key paths on each attribute type (e.g. `\.title`, `\.screenTitle`, `\.list` on `Style.Attribute.Font`). A definition can be a static value, a reference to another key path, or a builder that receives the current context and returns a value dynamically — for example, returning a different font weight depending on the element hierarchy, or a different surface depending on the container's interaction state. The package ships with a preset of common definitions; these can be overridden or extended.

**Components** group attribute definitions together for a view hierarchy. A `.contentCard` component assigns specific fonts, compositions, shapes, and paddings to its elements. Components have a `Container` (surface, shape, padding of the wrapping view) and map attribute key paths to `Element` types.

**Elements** are semantic roles within a component: `.title`, `.label`, `.icon`, `.value`, `.accessory`, `.separator`, `.footnote`. Each can have a `.primary`, `.secondary`, or `.tertiary` hierarchy.

**Context** is the accumulated state flowing through the environment: color scheme, font design, font width, scale factor, current component, container stack, and element. Attribute definitions can use the context to return different values.

**Caching** — Resolved attribute values are cached per (key path, context) pair, so a definition is only evaluated once for each unique context. When definitions are overridden in a subtree via `.style(update:)` or `.styleOverride(...)`, the relevant caches are reset automatically.

## Demo Project

The [SnapStyleDemo](/SnapStyleDemo) app showcases the built-in components, attribute definitions, and context configuration options. It includes examples for cards, lists, buttons, and a configuration screen to experiment with accent colors, font design, font width, corner radii, and scale factor.

## Installation

Add it as a package dependency to an Xcode project:
```swift
https://github.com/simonnickel/snap-style
```
Or to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/simonnickel/snap-style.git", from: "0.1.0")
]
```

Then add `SnapStyle` as a dependency of your target:

```swift
.target(name: "YourTarget", dependencies: [
    .product(name: "SnapStyle", package: "snap-style")
])
```

## Usage

### Setup

Apply `.styleSetup()` at the root of your view hierarchy:

```swift
@State var style: Style = Style()

var body: some View {
    ContentView()
        .styleSetup(style)
}
```

### Components and Elements

Apply a component to a view hierarchy, then assign elements to individual views:

```swift
StyleStack(spacing: \.spacingElements) {
    Image(systemName: "star")
        .style(element: .icon)
    Text("Title")
        .style(element: .title)
    Text("Some detail")
        .style(element: .label)
}
.style(component: .contentCard)
```

The component applies the container's styling (background surface, shape, padding) and sets up element attribute mappings in the environment. Assigning an element to a child view applies these attributes.

### Applying Attributes Directly

Use `.style(...)` modifiers to apply individual attributes by key path:

```swift
Text("Hello")
    .style(font: \.screenTitle)
    .style(foreground: \.accent)
    .style(padding: \.spacingGroups, .horizontal)
    .style(background: \.accentBackground)
    .style(shape: \.containerCard)
```

### Provided Views

SnapStyle provides views that integrate with the style system.

**Layout** -- Containers that structure content with style-defined spacing, insets, and configuration.

| View | Purpose |
|------|---------|
| `StyleScreen` | Screen container with readable content width, scroll view, and inset configuration |
| `StyleStack` | HStack/VStack with style-defined spacing, animatable axis switching |
| `StyleLazyVStack` / `StyleLazyHStack` | Lazy stack variants with style-defined spacing |
| `StyleList` | Styled List with section spacing and insets |
| `StyleListRow` | List row with variants: `.plain`, `.navigate`, `.selected`, `.pick`, and more |
| `StyleSpacer` | Spacer with a style-defined minimum length |

**Components** -- Interactive and content views that resolve their styling from the component/element system.

| View | Purpose |
|------|---------|
| `StyleButton` | Button with variants: `.default`, `.primary`, `.secondary`, `.plain`, `.icon`, `.component` |
| `StyleLabel` | Applies element-based font, composition, and padding |
| `StyleIcon` | Styled icon from a `Style.Attribute.Icon` key path |
| `StyleShapeView` | Renders a shape from a `Style.Attribute.Shape` key path |

**Utilities** -- General-purpose layout helpers, not specific to the style system.

| View | Purpose |
|------|---------|
| `StyleFlowLayout` | Flow layout that wraps content to the next line |
| `ScrollingHStack` | Horizontally scrolling stack |
| `CornerContainer` | Positions content in corners of a frame |

### Context Configuration

Adjust the context for a subtree:

```swift
ContentView()
    .style(fontDesign: .rounded)
    .style(fontWidth: .expanded)
    .style(scaleFactor: 1.2)
    .style(accent: \.destructive)
```

### Overriding Definitions

Override specific attribute definitions for a subtree:

```swift
ContentView()
    .styleOverride(
        fonts: [\.title: .base(.value(.with(size: 24, weight: .heavy)))],
        surfaces: [\.accent: .base(.value(.color(.purple)))]
    )
```

Override which key path a component resolves for a specific element type. For example, use a different font for icons inside a component:

```swift
HStack {
    Image(systemName: "star")
        .style(element: .icon)
    Text("Custom icon font")
        .style(element: .label)
}
.style(define: .icon, font: \.screenTitle)
.style(component: .contentCard)
```

### Custom Components

Define your own components by providing a container and element-to-attribute mappings:

```swift
extension Style.Component {
    static let myCard: Self = .init("myCard",
        container: .contentCard,
        fonts: { element in
            switch element {
                case .title: \.screenTitle
                case .icon: \.listIcon
                default: \.content
            }
        },
    )
}
```

### Custom Containers

Define containers with surface, composition, shape, and padding:

```swift
extension Style.Container.Properties {
    static let myContainer: Self = .init("myContainer",
        composition: { \.containerContentCard },
        shape: { \.containerCard },
        padding: { \.containerCard },
    )
}
```


## Attribute Types

An attribute is a type of visual property — color, font, spacing, shape, etc. Each attribute type defines a set of semantic key paths (e.g. `\.accent`, `\.screenTitle`, `\.spacingGroups`) that resolve to concrete values based on the current context. Attributes can be applied directly to a view via `.style(...)` modifiers.

### Core Attributes

Core attributes are applied directly to a view. They don't participate in the component's element mapping, but serve as building blocks that element attributes reference in their definitions — for example, a Composition assembles multiple Surface key paths into foreground, background, and overlay layers, and a Shape can reference a Number key path for its corner radius.

| Attribute | Key path examples | Description |
|-----------|-------------------|-------------|
| **Surface** | `\.accent`, `\.light0`, `\.onAccent`, `\.interactive` | Colors and materials, applied via `.style(foreground:)` or `.style(background:)` |
| **Number** | `\.spacingGroups`, `\.cornerRadiusCard`, `\.widthReadableContent` | Dimensions, spacing, corner radii (DynamicType-scaled), applied via `.style(padding:edges:)`, `.style(maxWidth:)`, etc. |
| **Icon** | `\.favorite`, `\.settings`, `\.indicatorNavigation` | System image names, used via `StyleIcon` |
| **Accent** | `\.primary`, `\.secondary`, `\.destructive` | Accent color definitions, applied via `.style(accent:)` |

### Element Attributes

Element attributes integrate with the component/element system: a `Style.Component` maps each `ElementType` (`.title`, `.label`, `.icon`, etc.) to a key path for each element attribute. Applying `.style(element: .title)` then resolves the correct font, composition, padding, and shape for that element based on the component's mapping.

| Attribute | Key path examples | Description |
|-----------|-------------------|-------------|
| **Font** | `\.title`, `\.screenTitle`, `\.list`, `\.buttonTitle` | Font size, weight, design, width, text style |
| **Composition** | `\.contentContainer`, `\.accentContainer`, `\.listRow` | Layered combinations of `Surfaces` for foreground, background, and overlay |
| **Padding** | `\.containerCard`, `\.listRow`, `\.anyElement` | Edge insets for containers and elements |
| **Shape** | `\.containerCard`, `\.circle`, `\.capsule` | Clip/background shapes |


## Targets

The package is split into layered targets. Import `SnapStyle` to get everything:

| Target | Description |
|--------|-------------|
| **SnapStyle** | Umbrella target, re-exports all others |
| **SnapStyleBase** | Core types: `Style`, `Style.Context`, attribute protocols, value builders, caching |
| **SnapStyleComponents** | `Style.Component`, `Style.Element`, `Style.Container` |
| **SnapStyleDefinitions** | Built-in definitions and values for all attribute types |
| **SnapStyleModifier** | View modifiers: `.style(font:)`, `.style(foreground:)`, `.style(component:)`, etc. |
| **SnapStyleLayout** | `StyleScreen`, `StyleStack`, `StyleList`, `StyleButton`, `StyleLabel`, and other views |
| **SnapStyleViews** | Additional convenience views |
| **SnapStyleDebug** | Debug views for inspecting style state and caches |


## Known Limitations

- Custom accent colors do not replicate the iOS behavior where `.accentColor` grays out when a popover or sheet is presented.
- Readable content width (`\.widthReadableContent`) is implemented manually since UIKit's `readableContentGuide` is not available in SwiftUI.

