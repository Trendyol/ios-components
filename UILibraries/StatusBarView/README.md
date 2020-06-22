# StatusBarView

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Setup

**Using CocoaPods (Recommended)**

Add the line below to your Podfile;

```
pod 'TYStatusBarView'
```

Then you can install it with *pod install* command.

**Manual**

Download the sample project from link below, just drag and drop files

## Usage

After you initialize the `StatusBarView`, you can configure the view by calling `configure` method.

**Example:**

```swift
let titles = ["Received", "Preparing", "Shipped", "Completed"]
statusBarView.configure(titles: titles, activeIndex: 1, activeColor: .systemGreen, passiveColor: .lightGray)
```

## Author

Ersen Tekin, ersen.tekin@trendyol.com

## License

TYStatusBarView is available under the MIT license. See the LICENSE file for more info.
