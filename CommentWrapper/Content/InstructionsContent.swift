//
//  InstructionsContent.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 21/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import AttributedStringBuilder

class InstructionsContent {
    
    static func makeAttributedString() -> NSAttributedString {
        
        return AttributedStringBuilder()
            .attributedText( makeHowToInstallAttributedString() )
            .newlines(3)
            .attributedText( makeHowToUseAttributedString() )
            .attributedString
    }
    
    private static func makeHowToInstallAttributedString() -> NSAttributedString {
        
        return ContentBuilder()
            .title("How to install")
            .body("""
            - Open System Preferences
            - Select 'Extensions'
            - Select 'Xcode Source Editor'
            - Enable 'Comment Wrapper'
            """)
            .attributedString
    }
    
    private static func makeHowToUseAttributedString() -> NSAttributedString {
        
        return ContentBuilder()
            .title("How to use")
            .body("""
            - Open Xcode and start editing a source file
            - Highlight the comment that you want to edit
            - Choose either wrap, unwrap or re-wrap from the menu under Editor -> Comment Wrapper
            """)
            .attributedString
    }
}
