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
            targets: ["JustRideSDKTarget"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ale-gen/RNCryptor.git", exact: "5.1.0"),
        .package(url: "https://github.com/ale-gen/MarqueeLabel.git", exact: "4.3.2"),
        .package(url: "https://github.com/ale-gen/ZipArchive.git", exact: "2.4.3"),
        .package(url: "https://github.com/ale-gen/zxingify-objc.git", exact: "3.6.7")
    ],
    targets: [
        .target(
            name: "JustRideSDKTarget",
            dependencies: [
                .target(
                    name: "JustRideSDK",
                    condition: .when(platforms: [.iOS])
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
            url: "https://sdk-artifactory.justride.com/artifactory/ios-artifacts/13.2.0/JustRideSDK.xcframework.zip",
            checksum: "382e22024beda8228d279bccb6b9f844358c99373076c5cadc73bc92e5907949")
    ]
)
