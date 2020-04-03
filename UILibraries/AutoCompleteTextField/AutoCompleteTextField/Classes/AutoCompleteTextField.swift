//
//  AutoCompleteTextField.swift
//  AutoCompleteTextField
//
//  Created by Anıl Taskıran on 18.01.2020.
//  Copyright © 2020 Anıl  Taskıran. All rights reserved.
//

import UIKit

public extension AutoCompleteTextField {
    enum ATAutoCompleteType {
        case email, none
    }
    
    static var defaultDomains: [String] {
        return ["gmail.com", "aol.com", "att.net", "comcast.net", "facebook.com", "gmx.com", "googlemail.com", "google.com", "hotmail.com", "hotmail.co.uk", "mac.com", "me.com", "mail.com", "msn.com", "live.com", "sbcglobal.net", "verizon.net", "yahoo.com", "yahoo.co.uk", "email.com", "games.com", "gmx.net", "hush.com", "hushmail.com", "icloud.com", "inbox.com", "lavabit.com", "love.com", "outlook.com", "pobox.com", "rocketmail.com", "safe-mail.net", "wow.com", "ygm.com", "ymail.com", "zoho.com", "fastmail.fm", "yandex.com", "bellsouth.net", "charter.net", "comcast.net", "cox.net", "earthlink.net", "juno.com", "btinternet.com", "virginmedia.com", "blueyonder.co.uk", "freeserve.co.uk", "live.co.uk", "ntlworld.com", "o2.co.uk", "orange.net", "sky.com", "tiscali.co.uk", "virgin.net", "wanadoo.co.uk", "bt.com", "sina.com", "qq.com", "naver.com", "hanmail.net", "daum.net", "nate.com", "yahoo.co.jp", "yahoo.co.kr", "yahoo.co.id", "yahoo.co.in", "yahoo.com.sg", "yahoo.com.ph", "hotmail.fr", "live.fr", "laposte.net", "yahoo.fr", "wanadoo.fr", "orange.fr", "gmx.fr", "sfr.fr", "neuf.fr", "free.fr", "gmx.de", "hotmail.de", "live.de", "online.de", "t-online.de", "web.de", "yahoo.de", "mail.ru", "rambler.ru", "yandex.ru", "ya.ru", "list.ru", "hotmail.be", "live.be", "skynet.be", "voo.be", "tvcablenet.be", "telenet.be", "hotmail.com.ar", "live.com.ar", "yahoo.com.ar", "fibertel.com.ar", "speedy.com.ar", "arnet.com.ar", "hotmail.com", "gmail.com", "yahoo.com.mx", "live.com.mx", "yahoo.com", "hotmail.es", "live.com", "hotmail.com.mx", "prodigy.net.mx", "msn.com", "yahoo.com.br", "hotmail.com.br", "outlook.com.br", "uol.com.br", "bol.com.br", "terra.com.br", "ig.com.br", "itelefonica.com.br", "r7.com", "zipmail.com.br", "globo.com", "globomail.com", "oi.com.br"]
    }
}

private extension AutoCompleteTextField {
    enum Constant {
        static let domainSeperator = "@"
    }
}

open class AutoCompleteTextField: UITextField {
    open var padding: UIEdgeInsets = .init(top: 0, left: 10, bottom: 0, right: 0)
    open var completionValues: [String] = defaultDomains
    open var autoCompleteType: ATAutoCompleteType = .email {
        didSet {
            
            if autoCompleteType == .email {
                keyboardType = .emailAddress
                autocorrectionType = .no
                autocapitalizationType = .none
            }
        }
    }
    public var autoCompletionTextColor: UIColor = .completionGray {
        didSet {
            autoCompleteLabel.textColor = autoCompletionTextColor
        }
    }
    
    private lazy var autoCompleteLabel: UILabel = {
        let label = UILabel()
        label.font = font
        label.sizeToFit()
        label.textColor = autoCompletionTextColor
        addSubview(label)
        
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
        
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    func initialize(){
        spellCheckingType = .no
        autocorrectionType = .no
        autoCompleteLabel.frame = frame
        addTarget(self, action: .editingChanged, for: .editingChanged)
        addTarget(self, action: .editingDidEnd, for: .editingDidEnd)
        addTarget(self, action:.editingDidEnd, for: .editingDidEndOnExit)
    }
    
    deinit {
        removeTarget(self, action: .editingChanged, for: .editingChanged)
        removeTarget(self, action: .editingDidEnd, for: .editingDidEnd)
        removeTarget(self, action:.editingDidEnd, for: .editingDidEndOnExit)
    }
    
    @objc func editingChanged() {
        autoCompleteLabel.text = nil
        guard let text = self.text,
            !text.isEmpty,
            case .email = autoCompleteType,
            text.isValidEmail else { return }
        
        let writtenDomain = text.components(separatedBy: Constant.domainSeperator).last ?? ""
        let recommendDomain: String = writtenDomain.isEmpty ? completionValues.first ?? "" : suggestDomain(writtenText: writtenDomain) ?? ""

        autoCompleteLabel.text = String(recommendDomain.dropFirst(writtenDomain.count))

        let textWidth: CGFloat = text.size(withAttributes: [.font: font as Any]).width
        autoCompleteLabel.frame = CGRect(x: textWidth + textRect(forBounds: bounds).origin.x, y: 0, width: self.frame.width - textWidth, height: frame.height)
    }

    @objc func editingDidEnd() {
        autoCompleteLabel.text = nil
        guard let text = self.text,
            !text.isEmpty,
            case .email = autoCompleteType,
            text.isValidEmail,
            let writtenDomain = text.components(separatedBy: Constant.domainSeperator).last,
            let recommendDomain: String = suggestDomain(writtenText: writtenDomain) else { return }
        
        let remainDomain: String = recommendDomain.replacingOccurrences(of: writtenDomain, with: "")
        guard !remainDomain.isEmpty else { return }
        
        self.text = text + remainDomain
    }
    
    func suggestDomain(writtenText: String) -> String? {
        return completionValues.filter { item in
            if item.count > writtenText.count {
                let index1 = writtenText.index(writtenText.endIndex, offsetBy: 0)
                let substring1 = item[..<index1]
                
                return String(substring1) == writtenText
            }
            return false
        }.first
    }
}

