//
//  RouterInterface.swift
//  Utils
//
//  Created by Ahmet Keskin on 5.11.2019.
//  Copyright © 2019 Trendyol.com. All rights reserved.
//

import UIKit

public protocol RouterInterface: class {
    var navigationController: UINavigationController? { get set }
    
    func showAlert(title: String, message: String, action: DefaultAlertAction)
    func showAlert(title: String, message: String, actions: [UIAlertAction])
}

extension RouterInterface {
    public func showAlert(title: String, message: String, action: DefaultAlertAction = .none) {
        let alertAction = UIAlertAction(title: "Tamam", style: .default) {[weak self] (_) in
            switch action {
            case .pop(let animated):
                self?.navigationController?.popViewController(animated: animated)
            case .dismiss(let animated):
                self?.navigationController?.dismiss(animated: animated, completion: nil)
            case .custom(let completion):
                completion()
            case .none:
                break
            }
        }
        
        showAlert(title: title, message: message, actions: [alertAction])
    }
    
    public func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        navigationController?.present(alertController, animated: true, completion: nil)
    }
}

public enum DefaultAlertAction {
    case pop(Bool)
    case dismiss(Bool)
    case custom(() -> Void)
    case none
}
