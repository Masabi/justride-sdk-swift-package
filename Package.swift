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
        .package(url: "https://github.com/ale-gen/zxingify-objc.git", exact: "3.6.7")
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
                .product(name: "SSZipArchive", package: "ZipArchive")
            ],
            path: "JustRideSDKWrapper"
        ),
        .binaryTarget(
            name: "JustRideSDK",
            url: "https://sdk-artifactory.justride.com/artifactory/ios-artifacts/14.1.0/JustRideSDK.xcframework.zip",
            checksum: "e4f1729392cfc019251344e6c73346cb52ddf03734442099ce3ee44f58cc2aa5")
    ]
)
