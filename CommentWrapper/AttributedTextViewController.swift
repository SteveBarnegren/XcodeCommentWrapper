//
//  AttributedTextViewController.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 21/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Cocoa

class AttributedTextViewController: NSViewController {
    
    @IBOutlet private var textView: NSTextView!
    private let attributedString: NSAttributedString
    
    init(attributedString: NSAttributedString) {
        self.attributedString = attributedString
        super.init(nibName: "AttributedTextViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.isSelectable = false
        textView.isEditable = false
        textView.textStorage?.append(attributedString)
    }
}
