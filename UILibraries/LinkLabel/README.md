# LinkLabel

**Custom label which provides clickable hashtags and links**

## Setup

**Using CocoaPods**

Add the line below to your Podfile;

```
pod 'TYLinkLabel'
```

Then you can install it with *pod install* command.

## Usage
First place an UIView in storyboard or xib, make its class to **TYLinkLabel**. Connect it to code by making outlet;

```
@IBOutlet private weak var label: TYLinkLabel!
```
Then customize linkLabel;

```
let firstText = "firstText"
let secondText = "secondText"
let fullText = "firstText and secondText"
let firstLink = LabelLink(title: firstText,
                          color: .red,
                          font: .boldSystemFont(ofSize: 12))
let secondLink = LabelLink(title: secondText,
                           color: .blue,
                           font: .boldSystemFont(ofSize: 12))
label.add([firstLink, secondLink])
label.text = fullText
label.handleAllTaps { [weak self] tappedLink in
    switch tappedLink {
    case firstLink:
        // handle first link
    case secondLink:
        // handle second link
    default:
        break
    }
}
```

For hashtags;
```
label.hashtagColor = .blue
label.text = ""
label.addHashtagsHandleTaps { [weak self] hashtag in
    // handle hastags
}
```

 ## Author
Selin Ersev, selin.ersev@trendyol.com
