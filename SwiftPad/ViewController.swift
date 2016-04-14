//
//  ViewController.swift
//  SwiftPad
//
//  Created by Sameh Mabrouk on 4/9/16.
//  Copyright © 2016 smapps. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var scrollView: NSScrollView?

    var textView: NSTextView { return scrollView!.contentView.documentView as! NSTextView }
    var rulerView: RulerView?
    var syntaxHighligher: SyntaxHighlighter?

    override func viewDidLoad() {
        super.viewDidLoad()

        let textView = self.textView
        textView.textContainerInset = NSMakeSize(0,1)
        textView.font = NSFont.userFixedPitchFontOfSize(NSFont.smallSystemFontSize())
        textView.automaticQuoteSubstitutionEnabled = false

        rulerView = RulerView(scrollView: scrollView, orientation: .VerticalRuler)
        scrollView?.verticalRulerView = rulerView
        scrollView?.hasHorizontalRuler = false
        scrollView?.hasVerticalRuler = true
        scrollView?.rulersVisible = true

        syntaxHighligher = SyntaxHighlighter(textStorage: textView.textStorage!, textView: textView, scrollView: scrollView!)

    }

    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}

