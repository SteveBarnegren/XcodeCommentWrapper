//
//  AboutViewController.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 21/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Cocoa
import AttributedStringBuilder

class AboutViewController: NSViewController {
    
    // MARK: - Views
    
    @IBOutlet private var websiteButton: NSButton!
    @IBOutlet private var twitterButton: NSButton!
    @IBOutlet private var githubButton: NSButton!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
    }
    
    func styleButtons() {
        
        [websiteButton, twitterButton, githubButton].forEach {
            
            let text = $0!.title
            let font = $0!.font!
            let color = NSColor.blue
            
            let attributedString =
                AttributedStringBuilder()
                    .text(text, attributes: [.font(font), .textColor(color)])
                    .attributedString
            
            $0!.attributedTitle = attributedString
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func websiteButtonPressed(sender: NSButton) {
        if let url = URL(string: "https://www.stevebarnegren.com") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction private func twitterButtonPressed(sender: NSButton) {
        if let url = URL(string: "https://www.twitter.com/stevebarnegren") {
            NSWorkspace.shared.open(url)
        }
    }
    
    @IBAction private func githubButtonPressed(sender: NSButton) {
        if let url = URL(string: "https://github.com/SteveBarnegren/XcodeCommentWrapper") {
            NSWorkspace.shared.open(url)
        }
    }
}
