//
//  SettingsViewController.swift
//  Comment Wrapper Host
//
//  Created by Peter Schorn on 5/11/21.
//  Copyright © 2021 Steve Barnegren. All rights reserved.
//

import AppKit

class SettingsViewController: NSViewController {

    @IBOutlet weak var lineLengthPopupButton: NSPopUpButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for option in LineLengthOption.allCases {
            self.lineLengthPopupButton.addItem(withTitle: option.rawValue)
        }

        switch Settings.lineLength {
            case .absolute:
                self.lineLengthPopupButton.selectItem(at: 1)
            default /* .excludingLeadingIndentation */:
                self.lineLengthPopupButton.selectItem(at: 0)
        }


    }

    
    @IBAction func selectedLineLengthPopupButton(
        _ popupButton: NSPopUpButton
    ) {
        let lineLength: LineLengthOption
        let index = popupButton.indexOfSelectedItem
        switch index {
            case 0:
                lineLength = .excludingLeadingIndentation
            case 1:
                lineLength = .absolute
            default:
                print("unexpected index for popup button: \(index)")
                return
        }
        
        Settings.lineLength = lineLength
        print("set line length to \(lineLength)")
        
    }
    
}
