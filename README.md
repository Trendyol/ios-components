
<img src="https://i.hizliresim.com/Z5GJRA.png" width="500"/>

**iOS Components** for iOS by Trendyol application development team.

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

iOS Components contains various ios custom views and helper frameworks written in pure swift. Developed by iOS app development team at Trendyol. 

## Why? ##
Developed to help iOS developers in community to build beautiful and functional iOS apps with less effort.

## Components Test App ## 
You can look at the test app named ComponentsTestApp by cloning the repo. All components shared here also implemented in test application.

<img src="https://media.giphy.com/media/iK59XSoO08IkdwWjqH/giphy.gif" width="240"/>

## Components ##

You can see brief summary of all components below. For detailed info, please click a component link provided in each component's section.

# ImageSlider
Custom collection view based slider component with infinite circular scrolling

[ImageSlider Link](https://github.com/Trendyol/ios-components/tree/master/UILibraries/ImageSlider)

# PinchableImageView
Provides full screen zooming ability to UIImageView like instagram.

[PinchableImageView Link](https://github.com/Trendyol/ios-components/tree/master/UILibraries/PinchableImageView/)

# AutoCompleteTextField

[AutoCompleteTextField Link](https://github.com/Trendyol/ios-components/tree/master/UILibraries/AutoCompleteTextField)

# PropertyWrapper

When you need use a enum on DTO you need to be sure all types can confirm. For that you need to create custom init. With this implemantation you don't need to write custom init anymore. Also We think on DTO no need to use optional Bool. Beacuse when will be we use optional bool on our code we wrote it with default value. You can simply use DefaultTrue or DefaultFalse wrapper on your dto and if that field is nil it will be set default value.

```swift
// With this implemantation you can be sure your code can't crash when new UserType added.
enum UserType: String, Codable {
    case admin, user, none
    
    public init(from decoder: Decoder) throws {
        self = try UserType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .none
    }
}
```

```swift
// With This Property Wrapper you can set Default value for UserType. You can set default value with LastCase or FirstCase.
// Also With DefaultFalse or DefaultTrue you can save your code from `UserResponse.isAdmin ?? false`
enum UserType: String, EnumDefaultValueSelectable {
    case admin, user, none
}

struct UserResponse: Codable {
    @DefaultCodable<LastCase> var user: UserType
    @DefaultCodable<DefaultFalse> var isAdmin: Bool
}

```

[PropertyWrapper Link](https://github.com/Trendyol/ios-components/tree/master/Utils/PropertyWrapper)


# ContinuousPagingView
Custom collection view with pagination implementation, guarantees that all pages filled with equal number of items.

[ContinuousPagingView Link](https://github.com/Trendyol/ios-components/tree/master/UILibraries/ContinuousPagingView)

# LinkLabel
Custom label which provides clickable hashtags and links

[LinkLabel Link](https://github.com/Trendyol/ios-components/tree/master/UILibraries/LinkLabel)

License
--------
    Copyright 2019 Trendyol.com

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
