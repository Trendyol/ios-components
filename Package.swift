// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "ios-components",
    platforms: [.iOS(.v11)],
    products: [
        .library(name: "TYStatusBarView", targets: ["TYStatusBarView"]),
        .library(name: "TYPropertyWrapper", targets: ["TYPropertyWrapper"]),
        .library(name: "TYLinkLabel", targets: ["TYLinkLabel"]),
        .library(name: "TYAutoCompleteTextField", targets: ["TYAutoCompleteTextField"]),
        .library(name: "TYContinuousPagingView", targets: ["TYContinuousPagingView"]),
        .library(name: "TYPinchableImageView", targets: ["TYPinchableImageView"]),
        .library(name: "TYImageSlider", targets: ["TYImageSlider", "TYPinchableImageView"])
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage", .upToNextMajor(from: "5.0.0"))
    ],
    targets: [
        .target(
            name: "TYStatusBarView",
            path: "UILibraries/StatusBarView/StatusBarView/StatusBarView/Classes"
        ),
        .target(
            name: "TYLinkLabel",
            path: "UILibraries/LinkLabel/LinkLabel/Classes"
        ),
        .target(
            name: "TYAutoCompleteTextField",
            path: "UILibraries/AutoCompleteTextField/AutoCompleteTextField/Classes"
        ),
        .target(
            name: "TYPropertyWrapper",
            path: "Utils/PropertyWrapper/PropertyWrapper/Classes"
        ),
        .target(
            name: "TYContinuousPagingView",
            path: "UILibraries/ContinuousPagingView/ContinuousPagingView/Classes"
        ),
        .target(
            name: "TYImageSlider",
            dependencies: [
                .product(name: "SDWebImage", package: "SDWebImage")
            ],
            path: "UILibraries/ImageSlider/ImageSlider/Classes"
        ),
        .target(
            name: "TYPinchableImageView",
            path: "UILibraries/PinchableImageView/PinchableImageView/PinchableImageView/Classes"
        )
    ]
)
