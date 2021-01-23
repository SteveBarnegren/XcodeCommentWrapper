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
    @IBOutlet private var contactButton: NSButton!
    @IBOutlet private var githubIssueButton: NSButton!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButtons()
    }
    
    func styleButtons() {
        
        [websiteButton, twitterButton, githubButton, contactButton, githubIssueButton].forEach {
            
            let text = $0!.title
            let font = $0!.font!
            let color = NSColor.linkColor
            
            let attributedString =
                AttributedStringBuilder()
                    .text(text, attributes: [.font(font), .textColor(color)])
                    .attributedString
            
            $0!.attributedTitle = attributedString
        }
    }
    
    // MARK: - Actions
    
    @IBAction private func websiteButtonPressed(sender: NSButton) {
        ExternalLinks.openWebsite()
    }
    
    @IBAction private func twitterButtonPressed(sender: NSButton) {
        ExternalLinks.openTwitterProfile()
    }
    
    @IBAction private func githubButtonPressed(sender: NSButton) {
        ExternalLinks.openGitHubPage()
    }
    
    @IBAction private func contactButtonPressed(sender: NSButton) {
        ExternalLinks.openContactForm()
    }
    
    @IBAction private func githubIssueButtonPressed(sender: NSButton) {
        ExternalLinks.openNewGitHubIssue()
    }
}
