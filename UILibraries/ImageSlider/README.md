# ImageSlider

**Custom collection view based image slider component with infinite circular scrolling**

![](https://img.shields.io/badge/version-0.0.9-blue.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/Owner-trendyol.com-yellowgreen.svg)

## What does ImageSlider do?
* Shows images from given remote url horizontally
* Looping through images
* Full screen pinch zoom on displayed image
* Built-in pager

<br/>

![](https://media.giphy.com/media/ZClbLmhoBHA2fPkAje/giphy.gif)

## <br/>Setup

**Using CocoaPods (Recommended)**

Add the line below to your Podfile;

```
pod 'TYImageSlider'
```

Then you can install it with *pod install* command.

**Manual**

Download the sample project from link below, just drag and drop files under the file *Classes* to your project.

## <br/>Usage
First place an UIView in storyboard or xib, make its class to **ImageSliderView**. Connect it to code by making outlet;

```
@IBOutlet private weak var imageSliderView: ImageSliderView!
```
Then create an instance of **ImageSliderViewPresenter**, pass your remote image urls and imageslider view outlet created before to it's initializer. Then set the ImageSliderViewPresenter instance to presenter property of imageSliderView;

```
let imageSliderPresenter = ImageSliderViewPresenter(imageUrls: imageUrls,
                                               loopingEnabled: true,
                                                         view: imageSliderView)
imageSliderView.presenter = imageSliderPresenter
```

## <br/> Parameters

Configure imageSlider view while you are creating instance of ImageSliderViewPresenter explained above. Parameters;

* **imageUrls:** Remote image urls
* **loopingEnabled:** It enables looping through images when set to true
* **view:** ImageSlider view instance

## <br/>Todos

* ImageSliderView initializes from interface builder only at this moment. It should be initialize from code directly
* ImageSliderView should support UIImage objects directly. It supports remote image urls only at this moment.
* Pager should be configurable

 ## <br/>Questions or Advices
You can create an issue, or all PRs all welcome if you believe you fix something wrong.