//
//  StoryboardHelper.swift
//  Utils
//
//  Created by Emre Ergün on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public protocol StoryboardProtocol {
    var identifier: String { get }
    var bundle: Bundle { get }
}

protocol StoryboardHelperProtocol {
    associatedtype Storyboard: StoryboardProtocol
    
    static func create(storyboard: Storyboard) -> UIStoryboard
}

public class StoryboardHelper<Storyboard: StoryboardProtocol>: StoryboardHelperProtocol {
    public static func create(storyboard: Storyboard) -> UIStoryboard {
        return UIStoryboard.init(name: storyboard.identifier, bundle: storyboard.bundle)
    }
}
