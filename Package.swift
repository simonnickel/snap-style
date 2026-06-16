// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "snap-style",
	platforms: [
		.iOS(.v17), .macOS(.v15)
	],
    products: [
        .library(
            name: "SnapStyle",
            targets: ["SnapStyle", "SnapStyleViews", "SnapStyleView", "SnapStyleDefinitions", "SnapStyleComponents", "SnapStyleBase", "SnapStyleDebug"]),
        // Examples target, not intended for consumers. Used by the demo app and previews.
        .library(
            name: "SnapStyleExamples",
            targets: ["SnapStyleExamples"]),
    ],
    dependencies: [
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
                "SnapStyleView",
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
                "SnapStyleView",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/5-Views",
        ),
        // View layer: modifiers and styled views
        .target(
            name: "SnapStyleView",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                .product(name: "SnapFoundation", package: "snap-foundation"),
                .product(name: "SnapCore", package: "snap-core"),
            ],
            path: "Sources/4-View",
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
        // Examples: Re-exports package-level example views as public for the demo app.
        .target(
            name: "SnapStyleExamples",
            dependencies: [
                "SnapStyle",
                "SnapStyleView",
                "SnapStyleViews",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/X-Examples",
        ),
        // Tests
        .testTarget(
            name: "SnapStyleTests",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
            ],
            path: "Tests/SnapStyleTests",
        ),
    ],
)
