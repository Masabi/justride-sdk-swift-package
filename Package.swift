// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JustRideSDK",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "JustRideSDK",
            targets: ["JustRideSDKWrapper"]
        ),
    ],
    dependencies: [
        // we're linking to a fork of each of the libraries that the Justride SDK depends on
        // because the Justride SDK needs the libraries to declare an explicit 'type';
        // see the following Stack Overflow thread for details: https://stackoverflow.com/questions/77274207
        .package(url: "https://github.com/ale-gen/RNCryptor.git", exact: "5.1.0"),
        .package(url: "https://github.com/Masabi/MarqueeLabel.git", exact: "4.5.1"),
        .package(url: "https://github.com/ale-gen/ZipArchive.git", exact: "2.4.3"),
        .package(url: "https://github.com/ale-gen/zxingify-objc.git", exact: "3.6.7"),
        .package(url: "https://github.com/Masabi/j2objc-dynamic-frameworks-swift-package.git", exact: "2023.09.26")
    ],
    targets: [
        .target(
            name: "JustRideSDKWrapper",
            dependencies: [
                .target(name: "JustRideSDK"),
                .product(name: "RNCryptor", package: "RNCryptor"),
                .product(name: "MarqueeLabel", package: "MarqueeLabel"),
                .product(name: "ZXingObjC", package: "zxingify-objc"),
                .product(name: "SSZipArchive", package: "ZipArchive"),
                .product(name: "JRE_Core", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "JSON", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "JSR305", package: "j2objc-dynamic-frameworks-swift-package")
            ],
            path: "JustRideSDKWrapper",
            linkerSettings: [
                .linkedFramework("CoreLocation"),
                .linkedFramework("CryptoKit"),
                .linkedFramework("Network"),
                .linkedFramework("PassKit"),
                .linkedFramework("Security"),
                .linkedFramework("WebKit"),
                .linkedFramework("UIKit")
            ]
        ),
        .binaryTarget(
            name: "JustRideSDK",
            url: "https://sdk-artifactory.justride.com/artifactory/ios-artifacts/16.3.0/JustRideSDK.xcframework.zip",
            checksum: "8930293afcf43d9d7e05a5ea8d3301df7c2c25252520e292b98e3b38897c99da"
        )
    ]
)

