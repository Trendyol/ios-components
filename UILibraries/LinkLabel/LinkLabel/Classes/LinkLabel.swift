//
//  LinkLabel.swift
//  LinkLabel
//
//  Created by Selin Ersev on 22.06.2021.
//

import UIKit
import Foundation

public protocol TYLinkLabelDelegate: AnyObject {
    func didSelect(_ link: LabelLink)
}

public final class TYLinkLabel: UILabel {
    public weak var delegate: TYLinkLabelDelegate?

    private var linkTapHandlers: [LabelLink : (LabelLink) -> ()] = [:]
    private var allLinkTapHandler: ((LabelLink) -> ())?
    private var hashtagTapHandler: ((LabelLink) -> ())?
    private var customize: Bool = true

    private var links: [LabelLink] = [] {
        didSet {
            createLinkLabel()
        }
    }

    public var hashtagColor: UIColor = .blue {
        didSet {
            createHashtagLinks()
        }
    }

    public var hashtagFont: UIFont? {
        didSet {
            createHashtagLinks()
        }
    }

    public override var textColor: UIColor? {
        didSet {
            createLinkLabel()
        }
    }

    public override var text: String? {
        didSet {
            if let text = text {
                attributedText = NSAttributedString(string: text)
            } else {
                attributedText = nil
            }
            createLinkLabel()
        }
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)
        customize = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:)))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customize = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(gesture:)))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    private func createLinkLabel() {
        guard !customize else { return }
        guard let text = text, let normalFont = font  else { return }
        let rawText = text as NSString
        let attributedText = NSMutableAttributedString(string: text)
        let normalRange = rawText.range(of: text)
        attributedText.addAttribute(.font, value: normalFont, range: normalRange)
        for link in links {
            let linkedRange = rawText.range(of: link.title)
            attributedText.addAttribute(.font, value: link.font, range: linkedRange)
            attributedText.addAttribute(.foregroundColor, value: link.color, range: linkedRange)
            if link.shouldAddUnderline {
                attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkedRange)
            }
        }
        self.attributedText = attributedText
        customize = false
    }

    @objc private func tapLabel(gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self)
        let tapIndex = indexOfAttributedTextCharacter(at: tapLocation)
        for link in links where isTapped(link: link, tapIndex: tapIndex) {
            didTap(for: link)
            return
        }
    }

    private func isTapped(link:LabelLink, tapIndex:Int) -> Bool{
        let linkedText = link.title
        guard let linkedTextRange = attributedText?.string.range(of: linkedText),
              let targetRange = attributedText?.string.range(from: linkedTextRange) else { return false }
        return tapIndex > targetRange.location && tapIndex < targetRange.location + targetRange.length
    }

    private func indexOfAttributedTextCharacter(at point: CGPoint) -> Int {
        guard let attributedString = attributedText, let labelFont = font else { return -1 }

        let mutableAttribString = NSMutableAttributedString(attributedString: attributedString)
        mutableAttribString.addAttributes([NSAttributedString.Key.font: labelFont],
                                          range: NSRange(location: 0,
                                                         length: attributedString.length))

        let textStorage = NSTextStorage(attributedString: mutableAttribString)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let index = layoutManager.characterIndex(for: point,
                                                 in: textContainer,
                                                 fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }

    public func handleCustomTap(for type: LabelLink, handler: @escaping (LabelLink) -> ()) {
        linkTapHandlers[type] = handler
    }

    public func handleAllTaps(handler: @escaping (LabelLink) -> ()) {
        allLinkTapHandler = handler
    }

    public func addHashtagsHandleTaps(handler: @escaping (LabelLink) -> ()) {
        createHashtagLinks()
        hashtagTapHandler = handler
    }

    public func add(_ links: [LabelLink]) {
        self.links += links
    }

    @discardableResult
    public func customize(_ block: (_ label: TYLinkLabel) -> ()) -> TYLinkLabel {
        customize = true
        block(self)
        customize = false
        createLinkLabel()
        return self
    }

    private func didTap(for link: LabelLink) {
        if let allTapHandlerElement = allLinkTapHandler {
            allTapHandlerElement(link)
        }
        if let elementHandler = linkTapHandlers[link] {
            elementHandler(link)
        }
        if let hashtagTapHandlerElement = hashtagTapHandler {
            hashtagTapHandlerElement(link)
        }
        delegate?.didSelect(link)
    }

    private func createHashtagLinks() {
        links += findHashtagInText().map{ LabelLink(title: $0, color: hashtagColor, font: hashtagFont ?? self.font) }
    }

    private func findHashtagInText() -> [String] {
        guard let text = text else { return [] }
        var hashtags: [String] = []
        let regex = try? NSRegularExpression(pattern: "(?:^|\\s|$)#[\\p{L}(&)0-9_]*", options: [.caseInsensitive])
        if let matches = regex?.matches(in: text, options:[], range: NSMakeRange(0, text.utf16.count)) {
            for match in matches {
                hashtags.append(NSString(string: text).substring(with: NSRange(location: match.range.location, length: match.range.length)))
            }
        }
        return hashtags
    }
}

public struct LabelLink: Equatable, Hashable {
    public let title: String
    public let color: UIColor
    public let font: UIFont
    public let shouldAddUnderline: Bool

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.title == rhs.title
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    public init(title: String, color: UIColor, font: UIFont, shouldAddUnderline: Bool = false) {
        self.title = title
        self.color = color
        self.font = font
        self.shouldAddUnderline = shouldAddUnderline
    }
}

private extension StringProtocol where Index == String.Index {
    func range(from range: Range<Index>) -> NSRange {
        return NSRange(range, in: self)
    }
}
