// swift-tools-version:5.0
//
//  Package.swift
//  Created by Ahmet Keskin on 13.11.2019.
//
import PackageDescription

let package = Package(
    name: "Channel-Components",
    platforms: [
        .macOS(.v10_12), .iOS(.v11),
    ],
    products: [
        .library(name: "API", targets: ["API"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .exact("5.0.0-rc.3")),
    ],
    targets: [
        .target(name: "API", dependencies: ["Alamofire"], path: "API"),
    ]
)
