//
//  HomeViewController.swift
//  ComponentsTestApp
//
//  Created by Emre Ergün on 14.01.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    @IBOutlet private weak var componentsTableView: UITableView!
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Component.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentTableViewCell", for: indexPath)
        cell.textLabel?.text = Component(rawValue: indexPath.row)?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(64.0)
    }
}

extension HomeViewController {
    enum Component: Int, CaseIterable {
        case ImageSlider = 0
        case PinchableImageView
        
        var title: String {
            switch self {
            case .ImageSlider:
                return "Image Slider"
            case .PinchableImageView:
                return "Pinchable ImageView"
            }
        }
    }
}
