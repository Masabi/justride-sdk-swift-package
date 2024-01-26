// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JustRideSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "JustRideSDK",
            targets: ["JustRideSDKWrapper"]),
    ],
    dependencies: [
        // we're linking to a fork of each of the libraries that the Justride SDK depends on
        // because the Justride SDK needs the libraries to declare an explicit 'type';
        // see the following Stack Overflow thread for details: https://stackoverflow.com/questions/77274207
        .package(url: "https://github.com/ale-gen/RNCryptor.git", exact: "5.1.0"),
        .package(url: "https://github.com/ale-gen/MarqueeLabel.git", exact: "4.3.2"),
        .package(url: "https://github.com/ale-gen/ZipArchive.git", exact: "2.4.3"),
        .package(url: "https://github.com/ale-gen/zxingify-objc.git", exact: "3.6.7"),
        .package(url: "https://github.com/Masabi/j2objc-dynamic-frameworks-swift-package.git", branch: "main")
    ],
    targets: [
        .target(
            name: "JustRideSDKWrapper",
            dependencies: [
                .target(
                    name: "JustRideSDK"
                ),
                .product(name: "RNCryptor", package: "RNCryptor"),
                .product(name: "MarqueeLabel", package: "MarqueeLabel"),
                .product(name: "ZXingObjC", package: "zxingify-objc"),
                .product(name: "SSZipArchive", package: "ZipArchive"),
                .product(name: "JRE_Core", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "JSON", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "JSR305", package: "j2objc-dynamic-frameworks-swift-package")
            ],
            path: "JustRideSDKWrapper"
        ),
        .binaryTarget(
            name: "JustRideSDK",
            url: "https://sdk-artifactory.justride.com/artifactory/ios-artifacts/14.2.0-test2/JustRideSDK.xcframework.zip",
            checksum: "8e9cfc117614994542a697e1c8c36e63b68847d977352499c285b156a2285c98")
    ]
)
