//
//  AppDelegate.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    // MARK: - Menu Bar Actions
    
    @IBAction private func helpMenuContactItemSelected(sender: AnyObject) {
        ExternalLinks.openContactForm()
    }
    
    @IBAction private func helpMenuTwitterItemSelected(sender: AnyObject) {
        ExternalLinks.openTwitterProfile()
    }
    
    @IBAction private func helpMenuGitHubItemSelected(sender: AnyObject) {
        ExternalLinks.openGitHubPage()
    }
}
