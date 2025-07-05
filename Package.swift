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
            targets: ["SnapStyle", "SnapStyleLayout", "SnapStyleBase", "SnapStyleDebug"]),
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
                "SnapStyleLayout",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ]
        ),
        // Views and Values
        .target(
            name: "SnapStyleLayout",
            dependencies: [
                "SnapStyleBase",
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ]
        ),
        // Implementation of core features.
        .target(
            name: "SnapStyleBase",
            dependencies: [
                .product(name: "SnapFoundation", package: "snap-foundation"),
            ]
        ),
        // A separate target for Debugging related helper.
        .target(
            name: "SnapStyleDebug",
            dependencies: [
                "SnapStyle"
            ],
            path: "Sources/SupportDebug"
        ),
    ],
    swiftLanguageModes: [.version("6")]
)
