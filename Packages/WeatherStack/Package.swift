// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeatherStack",
    platforms: [.iOS(.v26)],
    products: [
        .library(
            name: "WeatherCore",
            targets: ["WeatherCore"]
        ),
        .library(
            name: "WeatherUI",
            targets: ["WeatherUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/alamofire/Alamofire.git", from: "5.12.0")
    ],
    targets: [
        .target(
            name: "WeatherCore",
            dependencies: [
                .product(name: "Alamofire", package: "alamofire")
            ]
        ),
        .target(
            name: "WeatherUI",
            dependencies: ["WeatherCore"]
        ),
    ],
    swiftLanguageModes: [.v6],
)
