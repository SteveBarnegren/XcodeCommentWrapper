//
//  ContentBuilder.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 21/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import AttributedStringBuilder

class ContentBuilder {
    
    private let stringBuilder = AttributedStringBuilder()
    private let textColor = NSColor.black
    private let codeFont = NSFont(name: "menlo", size: 11.5)!
    
    @discardableResult func title(_ string: String) -> ContentBuilder {
        
        startNewParagraphIfRequired()
        
        let attributes: [AttributedStringBuilder.Attribute] = [
            .font(NSFont.systemFont(ofSize: 16, weight: .bold)),
            .textColor(textColor)
        ]
        
        stringBuilder.text(string, attributes: attributes)
        return self
    }
    
    @discardableResult func body(_ string: String) -> ContentBuilder {
        
        startNewParagraphIfRequired()
        
        let attributes: [AttributedStringBuilder.Attribute] = [
            .font(NSFont.systemFont(ofSize: 14, weight: .regular)),
            .textColor(textColor)
        ]
        
        stringBuilder.text(string, attributes: attributes)
        return self
    }
    
    @discardableResult func comment(_ string: String) -> ContentBuilder {
        
        startNewParagraphIfRequired()
        
        let color = NSColor(calibratedRed: 1.000, green: 0.000, blue: 0.353, alpha: 1.00)
        
        let attributes: [AttributedStringBuilder.Attribute] = [
            .font(codeFont),
            .textColor(color)
        ]
        
        stringBuilder.text(string, attributes: attributes)
        return self
    }
    
    var attributedString: NSAttributedString {
        return stringBuilder.attributedString
    }
    
    private func startNewParagraphIfRequired() {
        if stringBuilder.attributedString.length > 0 {
            stringBuilder.newlines(2)
        }
    }
}
