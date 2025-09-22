<!-- Copy badges from SPI -->
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonnickel/snap-style)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonnickel/snap-style) 

> This package is part of the [SNAP](https://github.com/simonnickel/snap) suite.


# SnapStyle

A toolset to abstract Colors, Fonts, Icons and Numbers of a multi-platform SwiftUI app. Define semantic attributes in a Theme and apply them to your views for a consistent UI with maintainability in mind.

[![Documentation][documentation badge]][documentation] 

[documentation]: https://swiftpackageindex.com/simonnickel/snap-style/main/documentation/snapstyle
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue


## Motivation

Consistency in look and feel is important, especially for a growing app project. Goal of SnapStyle is to define any visual attribute in a single place. Create a consistent UI with simple adjustments and quick experiments, but strong maintainability. Tweak a few attributes or adjust components to fit platform changes just once and have the whole app updated.

Instead of defining design attributes all over the place, you register a semantic key, assign a definition and use it in your SwiftUI views. Definitions can be overwritten in the View hierarchy to allow different styles and support user customisation like Themes or Accent color selection.

Comes with:

 - Base attributes (Surface, Font, Icon, Number, Shape, Padding) and composed attributes (Composition, Accent, Components).
 - A preset of common semantic definitions for these attributes, with platform specific default values.
 - ViewModifier to apply them to your views.
 - Wrapper of stock SwiftUI views to set attributes from Style definitions (e.g. StyleStack(spacing:)).
 - Convenience views for common layout and style tasks (e.g. StyleScreen, StyleElement).
 - Configuration and Context is provided via Environment to access and configure definitions.

Fonts and Numbers are scaled by DynamicType by default. This brings some additional benefits:

UI sizes (paddings, spacings, ...) defined by the Theme will scale with DynamicType.
By adjusting the configurations scale factor, the whole UI can be zoomed by a simple value change.


## Setup

// TODO package: Setup
Steps to setup the package ...


## Demo project

The [demo project](/PackageDemo) shows ...

// TODO package: Update Screenshot
<img src="/screenshot.png" height="400">


## How to use

// TODO package: How to use
Details about package content ...


## Targets

### SnapStyle
The main target to import using the package in an app. Provides access to internal targets.

### Base
Base implementation of Values, Caching and Context.

### Components
Implementation of Components and Elements. To build a semantic content structure.

### Definitions
Base set of definitions and values.

### KeyModifier
ViewModifier to use the definitions in SwiftUI Views.

### Layout
SwiftUI Views to structure Views.

### Views
Convenience Views and Container for common solutions, using the style definitions. 

### SnapStyleDebug
Some helper views to look into the setup and caches, prevents exposing implementation for accidental misuse.


## Features
 - Screen definition limiting the content to \.widthReadableContent (UIKits readableContentGuide is not available in SwiftUI).

## Not supported
- The iOS default behaviour of .accentColor shows as grayed out when a popover or sheet is presented. Seems to be not possible to replicate for custom tint colors. 
