// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "snap-style",
	platforms: [
		.iOS(.v18), .macOS(.v15)
	],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SnapStyle",
            targets: ["SnapStyle", "SnapStyleViews", "SnapStyleLayout", "SnapStyleAttributeModifier", "SnapStyleDefinitions", "SnapStyleComponents", "SnapStyleBase", "SnapStyleDebug"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/simonnickel/snap-foundation.git", branch: "main"),
        .package(url: "https://github.com/simonnickel/snap-core.git", branch: "main"),
    ],
    targets: [
        // The main target to import, it just exports the other targets.
        .target(
            name: "SnapStyle",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                "SnapStyleAttributeModifier",
                "SnapStyleLayout",
                "SnapStyleViews",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/X-SnapStyle",
        ),
        // Views
        .target(
            name: "SnapStyleViews",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                "SnapStyleAttributeModifier",
                "SnapStyleLayout",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/6-Views",
        ),
        // Layout
        .target(
            name: "SnapStyleLayout",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                "SnapStyleAttributeModifier",
                .product(name: "SnapFoundation", package: "snap-foundation"),
                .product(name: "SnapCore", package: "snap-core"),
            ],
            path: "Sources/5-Layout",
        ),
        // Modifier
        .target(
            name: "SnapStyleAttributeModifier",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/4-AttributeModifier",
        ),
        // Values
        .target(
            name: "SnapStyleDefinitions",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/3-Definitions",
        ),
        // Components and Elements
        .target(
            name: "SnapStyleComponents",
            dependencies: [
                "SnapStyleBase",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/2-Components",
        ),
        // Implementation of core features.
        .target(
            name: "SnapStyleBase",
            dependencies: [
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/1-Base",
        ),
        // A separate target for Debugging related helper.
        .target(
            name: "SnapStyleDebug",
            dependencies: [
                "SnapStyle",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/X-Debug",
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
