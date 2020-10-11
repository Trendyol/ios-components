//
//  StringExtension.swift
//  AutoCompleteTextField
//
//  Created by Anıl T. on 2.04.2020.
//  Copyright © 2020 DSM Group Trendyol. All rights reserved.
//

import Foundation

extension String {
    static let emailPattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Z0-9.-]{0,}$"

    var isValidEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: String.emailPattern, options: .caseInsensitive)
            let matches = regex.matches(in: self, range: NSRange(location: 0, length: self.count))
            return !matches.isEmpty
        } catch {
            return false
        }
    }
}
