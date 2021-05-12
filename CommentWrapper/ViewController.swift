//
//  ViewController.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Cocoa
import SBAutoLayout

class ViewController: NSViewController {
    
    // MARK: - Types
    
    private enum ContentType {
        case introduction
        case installationInstructions
        case about
        case settings
    }
    
    // MARK: - Properties
    
    private var contentType = ContentType.introduction
    
    // MARK: - Views
    
    @IBOutlet private var segmentedControl: NSSegmentedControl!
    @IBOutlet private var contentContainerView: NSView!
    
    private var contentViewController: NSViewController?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showContent(type: contentType)
    }

    // MARK: - Actions
    
    @IBAction private func segmentedControlValueChanged(sender: NSSegmentedControl) {
        
        switch self.segmentedControl.selectedSegment {
        case 0: showContent(type: .introduction)
        case 1: showContent(type: .installationInstructions)
        case 2: showContent(type: .about)
        case 3: showContent(type: .settings)
        default: fatalError("Unhandled segmented control selection")
        }
    }
    
    // MARK: - Switch Content
    
    private func showContent(type: ContentType) {
        
        if type == contentType && contentViewController != nil {
            return
        }
        
        switch type {
        case .introduction:
            let attributedString = IntroductionContent.makeAttributedString()
            let introduction = AttributedTextViewController(attributedString: attributedString)
            displayContent(viewController: introduction)
            
        case .installationInstructions:
            let attributedString = InstructionsContent.makeAttributedString()
            let instructions = AttributedTextViewController(attributedString: attributedString)
            displayContent(viewController: instructions)
            
        case .about:
            let about = AboutViewController(nibName: "AboutViewController", bundle: nil)
            displayContent(viewController: about)
            
        case .settings:
            let settings = SettingsViewController(
                nibName: "SettingsViewController", bundle: nil
            )
            displayContent(viewController: settings)
        }
        
        self.contentType = type
    }
    
    private func displayContent(viewController: NSViewController) {
    
        contentViewController?.view.removeFromSuperview()
        contentViewController?.removeFromParent()
        contentViewController = nil
        
        contentContainerView.addSubview(viewController.view)
        viewController.view.pinToSuperviewEdges()
        addChild(viewController)
        contentViewController = viewController
    }
}
