//
//  SyntaxHighlighter.swift
//  SwiftPad
//
//  Created by Sameh Mabrouk on 4/9/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Cocoa

import SourceKittenFramework

/** 
 SyntaxHighlighter class is responsible for handling all syntax Highlighting using SourceKitten Framework.
 */
class SyntaxHighlighter: NSObject, NSTextStorageDelegate, NSLayoutManagerDelegate {
    var textStorage: NSTextStorage?
    var textView: NSTextView?
    var scrollView: NSScrollView?

    convenience init(textStorage: NSTextStorage, textView: NSTextView, scrollView: NSScrollView) {
        self.init()
        self.textStorage = textStorage
        self.scrollView = scrollView
        self.textView = textView

        textStorage.delegate = self

        parse()
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    func visibleRange() -> NSRange {
        let container = textView!.textContainer
        let layoutManager = textView!.layoutManager
        let textVisibleRect = scrollView!.contentView.bounds
        let glyphRange = layoutManager!.glyphRangeForBoundingRect(textVisibleRect,
            inTextContainer: container!)
        return layoutManager!.characterRangeForGlyphRange(glyphRange,
            actualGlyphRange: nil)
    }

    func parse() {
        guard let tokens = parseString(textStorage!.string) else {
            return
        }

        let range = visibleRange()
        let layoutManagerList = textStorage!.layoutManagers as [NSLayoutManager]
        for layoutManager in layoutManagerList {
            layoutManager.delegate = self
            layoutManager.removeTemporaryAttribute(SWIFT_ELEMENT_TYPE_KEY,
                forCharacterRange: range)

            for token in tokens {
                layoutManager.addTemporaryAttributes([SWIFT_ELEMENT_TYPE_KEY: token.kind],
                    forCharacterRange: token.range)
            }
        }
    }

    func parseString(string: String) -> [Token]? {
        /* using SourceKittenFramework */
        if(string.isEmpty){
            return []
        }
        let syntaxMap1:SyntaxMap = SyntaxMap(file: File(contents: string))
        let syntaxJSON = syntaxMap1.description
        let tokens = try! NSJSONSerialization.JSONObjectWithData(syntaxJSON.dataUsingEncoding(NSUTF8StringEncoding)!, options: []) as! [NSDictionary]

        return tokens.map { token in
            let offset = token["offset"] as! Int
            let length = token["length"] as! Int
            let type = token["type"] as! String
            return Token(kind: type, range: NSRange(location: offset, length: length))
        }
    }

    override func textStorageDidProcessEditing(aNotification: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            self.parse()
        }
    }

    func layoutManager(layoutManager: NSLayoutManager, shouldUseTemporaryAttributes attrs: [String : AnyObject], forDrawingToScreen toScreen: Bool, atCharacterIndex charIndex: Int, effectiveRange effectiveCharRange: NSRangePointer) -> [String : AnyObject]? {

        if let type = attrs[SWIFT_ELEMENT_TYPE_KEY] as? String where toScreen {
            if let style = SyntaxKind(rawValue: type)?.colorValue {
                return [NSForegroundColorAttributeName: style]
            } else {
                print("\(type) not a valid style")
            }
        }
        return attrs
    }
}
