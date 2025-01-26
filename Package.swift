// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftSyntaxHighlighter",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SwiftSyntaxHighlighter",
            targets: ["SwiftSyntaxHighlighter"]),
        .executable(name: "swift-highlight",
                    targets: ["swift-highlight"])
    ],
    dependencies: [
        .package(
                 url: "https://github.com/unionst/SwiftSyntax.git",
                 .branchItem("main")),
        .package(name: "swift-argument-parser",
                 url: "https://github.com/apple/swift-argument-parser.git",
                 .upToNextMinor(from: "0.3.2"))
    ],
    targets: [
        .target(name: "Highlighter",
                dependencies: ["SwiftSyntax"]),
        .target(name: "Pygments",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Pygments"),
        .target(name: "Xcode",
                dependencies: ["Highlighter"],
                path: "Sources/TokenizationSchemes/Xcode"),
        .target(
            name: "swift-highlight",
            dependencies: [
                "SwiftSyntaxHighlighter",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .target(
            name: "SwiftSyntaxHighlighter",
            dependencies: [
                .product(name: "SwiftSyntax", package: "SwiftSyntax"),
                "Highlighter",
                "Xcode",
                "Pygments",
//                .target(name: "_InternalSwiftSyntaxParser", condition: .when(platforms: [.macOS]))
            ]),
        .testTarget(
            name: "SwiftSyntaxHighlighterTests",
            dependencies: ["SwiftSyntaxHighlighter"]),
//        .binaryTarget(
//          name: "_InternalSwiftSyntaxParser",
//          url: "https://github.com/apple/swift-syntax/releases/download/0.50600.0/_InternalSwiftSyntaxParser.xcframework.zip",
//          checksum: "0e0d9ecbfddd0765485ded160beb9e7657e7add9d5ffd98ef61e8bd0c967e3a9"
//        ),
    ]
)
