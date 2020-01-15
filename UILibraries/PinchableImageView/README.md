# PinchableImageView

**Provides full screen zooming ability to UIImageView like instagram.**

![](https://img.shields.io/badge/version-0.0.3-blue.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/Owner-trendyol.com-yellowgreen.svg)

## <br/>What does PinchableImageView do?
Gives full screen zooming ability to UIImageView with no additional code.

![](https://media.giphy.com/media/MarT2MCjgFAi86tJ3A/giphy.gif)

## <br/>Setup

**Using CocoaPods (Recommended)**

Add the line below to your Podfile;

```
pod 'TYPinchableImageView'
```

Then you can install it with pod install command.

**Manual**

Download the sample project from link below, just drag and drop the PinchableImageView.swift file to your project.

## <br/>Usage
Make your image view subclass of PinchableImageView. It's simple as that.

## <br/>Customizable Parameters
Custom parameters can be set through PinchableImageView instance

```
    @IBOutlet weak var pinchableImageView: PinchableImageView! {
        didSet {
            pinchableImageView.minZoomScale = 0.5
            pinchableImageView.maxZoomScale = 3.0
            pinchableImageView.resetAnimationDuration = 0.5
            pinchableImageView.zoomDelegate = self
        }
    }
```

* **minZoomScale:** Minimum scale of the zoom imageview. Default value is 1.00
* **maxZoomScale:** Maximum scale of the zoom imageview. Default value is 3.00
* **resetAnimationDuration:** Duration of the reset animation. Default value is 0.3 sec
* **zoomDelegate:** Zoom Delegate is informed when zooming started and ended.
* **isZoomingActive:** Flag that indicates whether zooming is active or not. (Read Only)

 ## <br/>Questions or Advices
You can create an issue, or all PRs all welcome if you believe you fix something wrong.