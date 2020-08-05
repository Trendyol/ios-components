# ContinuousPagingView

**Custom paged collection view **

![](https://img.shields.io/badge/version-0.0.4-blue.svg)
![](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![](https://img.shields.io/badge/Owner-trendyol.com-yellowgreen.svg)

## What does ContinuousPagingView do?

**Custom collection view with pagination implementation, guarantees that all pages filled with equal number of items**

For example, if you have 7 items, and you want to display 3 cells at each page, ContinuousPagingView makes pagination in this order;

* Page 1: Item 1 - Item 2 - Item 3
* Page 2: Item 4 - Item 5 - Item 6
* Page 3: Item 5 - Item 6 - Item 7

<br/>

Examples;


Total: 9 items, 5 item per page;
----
![](https://s7.gifyu.com/images/scroll_first.gif)

Total: 6 items, 5 item per page;
----
![](https://s7.gifyu.com/images/scroll_second.gif)
## <br/>Setup

**Using CocoaPods (Recommended)**

Add the line below to your Podfile;

```
pod 'TYContinuousPagingView', '~> 0.0.4'
```

Then you can install it with *pod install* command.

**Manual**

Download the sample project from link below, just drag and drop files under the file *Classes* to your project.

## <br/>Usage
Import TYContinuousPagingView;

```swift
import TYContinuousPagingView
```

Place an UIView in storyboard or xib, make its class to **ContinuousPagingView**. Connect it to code by making outlet;

```swift
@IBOutlet private weak var continuousPagingView: ContinuousPagingView!
```

Set data source, register your cell;

```swift
continuousPagingView.dataSource = self
continuousPagingView.collectionView.register(cellType: TestCell.self)
```

Implement data source (**ContinuousPagingViewDataSource**), like collection view;

```swift
extension BannerChannelCell: ContinuousPagingViewDataSource {
    func continuousPagingViewNumberOfItems() -> Int {
        return testArray.count
    }
    
    func continuousPagingViewCellForItem(for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TestCell.self, for: indexPath)
        return cell
    }
}
```

Thats it. Rest will be handled at the framework. Item sizes will be calculated automatically depends on parameters like interItemSpacing, view's height and number of items per page.


## <br/> Public Variables

* **delegate:** Delegate of ContinuousPagingView, **ContinuousPagingViewDelegate**
* **numberOfItemsPerPage:** Number of items will be displayed at each page
* **interItemSpacing:** Margin between items
* **showsHorizontalScrollIndicator:** Flag that controls whether scroll indicator should visible or not

## <br/> ContinuousPagingViewDelegate

```swift
public protocol ContinuousPagingViewDelegate: class {
    func continuousPagingViewDidEndDecelerating(page: Int)
    func continuousPagingViewDidScroll()
    func continuousPagingViewWillDisplay(cell: UICollectionViewCell, at indexPath: IndexPath)
    func continuousPagingViewWillBeginDecelerating(page: Int)
    func continuousPagingViewDidEndScrollingAnimation()
    func continuousPagingViewDidEndDragging(decelerate: Bool)
    func continuousPagingVieWscrollViewWillBeginDragging()
}
```

 ## <br/>Questions or Advices
You can create an issue, or all PRs all welcome if you believe you fix something wrong.