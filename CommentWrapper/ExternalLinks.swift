//
//  ExternalLinks.swift
//  Comment Wrapper Host
//
//  Created by Steve Barnegren on 29/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import AppKit

class ExternalLinks {
    
    static func openWebsite() {
        open(url: "https://www.stevebarnegren.com")
    }
    
    static func openTwitterProfile() {
        open(url: "https://www.twitter.com/stevebarnegren")
    }
    
    static func openGitHubPage() {
        open(url: "https://github.com/SteveBarnegren/XcodeCommentWrapper")
    }
    
    static func openContactForm() {
        open(url: "https://www.stevebarnegren.com/contact")
    }
    
    static func openNewGitHubIssue() {
        open(url: "https://github.com/SteveBarnegren/XcodeCommentWrapper/issues/new")
    }
    
    private static func open(url urlString: String) {
        if let url = URL(string: urlString) {
            NSWorkspace.shared.open(url)
        } else {
            print("Unable to construct url from string: \(urlString)")
        }
    }
}
