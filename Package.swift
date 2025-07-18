// swift-tools-version: 6.0
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
            targets: ["SnapStyle", "SnapStyleViews", "SnapStyleLayout", "SnapStyleDefinitions", "SnapStyleComponents", "SnapStyleBase", "SnapStyleDebug"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/simonnickel/snap-foundation.git", branch: "main"),
    ],
    targets: [
        // The main target to import, it just exports the other targets.
        .target(
            name: "SnapStyle",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
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
                "SnapStyleLayout",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/Views",
        ),
        // Layout
        .target(
            name: "SnapStyleLayout",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                "SnapStyleDefinitions",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/Layout",
        ),
        // Values
        .target(
            name: "SnapStyleDefinitions",
            dependencies: [
                "SnapStyleBase",
                "SnapStyleComponents",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/Definitions",
        ),
        // Components and Elements
        .target(
            name: "SnapStyleComponents",
            dependencies: [
                "SnapStyleBase",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/Components",
        ),
        // Implementation of core features.
        .target(
            name: "SnapStyleBase",
            dependencies: [
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ],
            path: "Sources/Base",
        ),
        // A separate target for Debugging related helper.
        .target(
            name: "SnapStyleDebug",
            dependencies: [
                "SnapStyle"
            ],
            path: "Sources/X-Debug",
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
