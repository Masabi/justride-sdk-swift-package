// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "JustRideSDK",
    platforms: [
        .iOS(.v15)
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
        .package(url: "https://github.com/Masabi/RNCryptor.git", exact: "5.1.0"),
        .package(url: "https://github.com/Masabi/MarqueeLabel.git", exact: "4.5.1"),
        .package(url: "https://github.com/Masabi/ZIPFoundation.git", exact: "2025.2.21"),
        .package(url: "https://github.com/Masabi/zxingify-objc.git", exact: "3.6.10"),
        .package(url: "https://github.com/Masabi/j2objc-dynamic-frameworks-swift-package.git", exact: "2023.09.26-j2objc-prefix")
    ],
    targets: [
        .target(
            name: "JustRideSDKWrapper",
            dependencies: [
                .target(name: "JustRideSDK"),
                .product(name: "RNCryptor", package: "RNCryptor"),
                .product(name: "MarqueeLabel", package: "MarqueeLabel"),
                .product(name: "ZXingObjC", package: "zxingify-objc"),
                .product(name: "ZIPFoundation", package: "ZIPFoundation"),
                .product(name: "J2ObjC_JRE_Core", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "J2ObjC_JSON", package: "j2objc-dynamic-frameworks-swift-package"),
                .product(name: "J2ObjC_JSR305", package: "j2objc-dynamic-frameworks-swift-package")
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
            url: "https://sdk-artifactory.justride.com/artifactory/ios-artifacts/24.1.0/JustRideSDK.xcframework.zip",
            checksum: "61ec7ce1d9f4070e0695b757b5fd5a20de48f7c7149c7eb5f962307ca9714cf2"
        )
    ]
)

