//
//  AutoCompleteTextFieldViewController.swift
//  ComponentsTestApp
//
//  Created by Anıl T. on 2.04.2020.
//  Copyright © 2020 Emre Ergün. All rights reserved.
//

import UIKit
import TYAutoCompleteTextField

final class AutoCompleteTextFieldViewController: UIViewController {
    @IBOutlet private weak var textField: AutoCompleteTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.placeholder = "Basic text field"
        textField.completionValues = ["trendyol.com"]
        textField.completionValues.append(contentsOf: AutoCompleteTextField.defaultDomains)
        textField.autoCompleteType = .email
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(gesture)
        view.isUserInteractionEnabled = true
    }

    @objc func endEditing(){
        view.endEditing(true)
    }
}
