<!-- Copy badges from SPI -->
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/simonnickel/snap-style)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fsimonnickel%2Fsnap-style%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/simonnickel/snap-style) 

> This package is part of the [SNAP](https://github.com/simonnickel/snap) suite.


# SnapStyle

A toolset to abstract Colors, Fonts, Icons and Numbers of a multi-platform SwiftUI app. Define semantic attributes in a Theme and apply them to your views for a consistent UI with maintainability in mind.

[![Documentation][documentation badge]][documentation] 

[documentation]: https://swiftpackageindex.com/simonnickel/snap-style/main/documentation/snapstyle
[documentation badge]: https://img.shields.io/badge/Documentation-DocC-blue

// TODO: Update feature set, namings, how to use and list of components

## Motivation

Consistency in look and feel is important. Especially for a growing app project, when you decide to tweak a few attributes or need adjustments to fit platform changes or design trends. Goal of SnapTheme is to define visual attributes in a single place, to allow: A consistent UI with simple adjustments and quick experiments, but strong maintainability.

Instead of defining design attributes all over the place, you register a semantic key, assign a definition and use it in your SwiftUI views. You can also define multiple Themes to let the user choose it's favorite.

Comes with:

Base attributes (Color, Font, Icon, Number) and composed attributes (Surface, Background, TextSurface).
A preset of common semantic definitions for these attributes (e.g. .textTitle, .textSubtitle) with platform specific default values.
ViewModifier to apply them to your views.
Wrapper of stock SwiftUI views to set attributes from Style definitions (e.g. ThemeVStack(spacing:)).
Convenience views for common layout and style tasks (e.g. ThemeScreen, ThemeElement).
The Theme is injected in the Environment to be available to ViewModifier and Views.

Fonts and Numbers are scaled by DynamicType by default. This brings some additional benefits:

UI sizes (paddings, spacings, ...) defined by the Theme will scale with DynamicType.
By adjusting the Themes scale factor, the whole UI can be zoomed by a simple value change.

## Setup

Steps to setup the package ...


## Demo project

The [demo project](/PackageDemo) shows ...

<img src="/screenshot.png" height="400">


## How to use

Details about package content ...


## Targets

### SnapStyle
The main target to import using the package in an app.

### SnapStyleBase
Base implementation of Values, Caching and Context.

### SnapStyleDebug
Some helper views to look into the setup and caches, prevents exposing implementation for accidental misuse.


## Features
 - Screen definition limiting the content to \.widthReadableContent (UIKits readableContentGuide is not available in SwiftUI).

## Not supported
- The iOS default behaviour of .accentColor shows as grayed out when a popover or sheet is presented. Seems to be not possible to replicate for custom tint colors. 
