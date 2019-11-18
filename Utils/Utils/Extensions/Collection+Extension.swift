//
//  Collection+Extension.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public extension UITableViewCell {
    class func getNib(for bundle: Bundle?) -> UINib {
        return UINib(nibName: self.className, bundle: bundle)
    }

    class var identifier: String {
        return self.className
    }
}

public extension UITableViewHeaderFooterView {
    class func getNib() -> UINib {
        return UINib(nibName: self.className, bundle: nil)
    }

    class var identifier: String {
        return self.className
    }
}

public extension UICollectionReusableView {
    class func getNib(for bundle: Bundle) -> UINib {
        return UINib(nibName: self.className, bundle: bundle)
    }

    class var identifier: String {
        return self.className
    }
}

public extension UITableView {
    func indexPathIsValid(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfRows(inSection: indexPath.section)
    }

    func sectionIsValid() -> Bool {
        return numberOfSections > 0
    }

    func register(cellType: UITableViewCell.Type, bundle: Bundle? = nil) {
        register(cellType.getNib(for: bundle), forCellReuseIdentifier: cellType.identifier)
    }

    func register(cellTypes: [UITableViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }

    func register(headerFooterViewClassWith type: UITableViewHeaderFooterView.Type) {
        register(type.getNib(), forHeaderFooterViewReuseIdentifier: type.identifier)
    }

    func register(headerFooterViewClassWith types: [UITableViewHeaderFooterView.Type]) {
        types.forEach { register(headerFooterViewClassWith: $0) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: type.className, for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(with type: T.Type) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: type)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(String(describing: type))")
        }
        return headerFooterView
    }

    func insertRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: (() -> Void)?) {
        CATransaction.begin()
        insertRows(at: indexPaths, with: animation)
        CATransaction.setCompletionBlock {
            completion?()
        }
        CATransaction.commit()
    }

    func deleteRows(at indexPaths: [IndexPath], with animation: UITableView.RowAnimation, completion: (() -> Void)?) {
        CATransaction.begin()
        deleteRows(at: indexPaths, with: animation)
        CATransaction.setCompletionBlock {
            completion?()
        }
        CATransaction.commit()
    }
}

public extension UICollectionView {
    func indexPathIsValid(indexPath: IndexPath) -> Bool {
        return indexPath.section < numberOfSections && indexPath.row < numberOfItems(inSection: indexPath.section)
    }

    func register(cellType: UICollectionViewCell.Type, bundle: Bundle) {
        register(cellType.getNib(for: bundle), forCellWithReuseIdentifier: cellType.identifier)
    }

    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle) {
        cellTypes.forEach({ register(cellType: $0, bundle: bundle) })
    }

    func register(reusableViewType: UICollectionReusableView.Type, ofKind kind: String = UICollectionView.elementKindSectionHeader, bundle: Bundle) {
        register(reusableViewType.getNib(for: bundle), forSupplementaryViewOfKind: kind, withReuseIdentifier: reusableViewType.identifier)
    }

    func register(reusableViewTypes: [UICollectionReusableView.Type], ofKind kind: String = UICollectionView.elementKindSectionHeader, bundle: Bundle) {
        reusableViewTypes.forEach({ register(reusableViewType: $0, ofKind: kind, bundle: bundle) })
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as? T else {
            fatalError()
        }
        
        return cell
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath, ofKind kind: String =  UICollectionView.elementKindSectionHeader) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.identifier, for: indexPath) as! T
    }
}

public extension Collection where Indices.Iterator.Element == Index {

    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension NSObject {
    @objc var className: String {
        return type(of: self).className
    }

    @objc static var className: String {
        return String(describing: self)
    }
}
