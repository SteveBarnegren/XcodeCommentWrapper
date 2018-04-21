//
//  ViewController.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Types
    
    private enum ContentType {
        case introduction
        case installationInstructions
        case about
    }
    
    // MARK: - Properties
    
    private var contentType = ContentType.introduction
    
    // MARK: - Views
    
    @IBOutlet private var whatButton: NSButton!
    @IBOutlet private var howButton: NSButton!
    @IBOutlet private var whoButton: NSButton!
    @IBOutlet private var contentContainerView: NSView!
    
    private var contentViewController: NSViewController?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showContent(type: contentType)
    }

    // MARK: - Actions
    
    @IBAction private func whatButtonPressed(sender: NSButton) {
        showContent(type: .introduction)
    }
    
    @IBAction private func howButtonPressed(sender: NSButton) {
        showContent(type: .installationInstructions)
    }
    
    @IBAction private func whoButtonPressed(sender: NSButton) {
        showContent(type: .about)
    }
    
    // MARK: - Switch Content
    
    private func showContent(type: ContentType) {
        
        if type == contentType && contentViewController != nil {
            return
        }
        
        switch type {
        case .introduction:
            let introduction = IntroductionViewController(nibName: NSNib.Name(rawValue: "IntroductionViewController"),
                                                          bundle: nil)
            displayContent(viewController: introduction)
        case .installationInstructions:
            let installationInstructions = InstallationInstructionsViewController(nibName: NSNib.Name(rawValue: "InstallationInstructionsViewController"),
                                                                                  bundle: nil)
            displayContent(viewController: installationInstructions)
        case .about:
            let about = AboutViewController(nibName: NSNib.Name(rawValue: "AboutViewController"), bundle: nil)
            displayContent(viewController: about)
        }
        
        self.contentType = type
    }
    
    private func displayContent(viewController: NSViewController) {
    
        contentViewController?.view.removeFromSuperview()
        contentViewController?.removeFromParentViewController()
        contentViewController = nil
        
        contentContainerView.addSubview(viewController.view)
        viewController.view.frame = contentContainerView.bounds
        addChildViewController(viewController)
        contentViewController = viewController
    }
}

