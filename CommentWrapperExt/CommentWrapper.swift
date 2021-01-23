//
//  CommentWrapper.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

public extension Array {
    
    mutating func popFirst() -> Element? {
        
        if self.isEmpty {
            return nil
        } else {
            return self.remove(at: 0)
        }
    }
}

class CommentWrapper {

    static func wrap(string: String, lineLength: Int) -> String {
        
        let prefix = string.commentPrefix()
        let unprefixedString = string.lines()
            .map { $0.removing(prefix: prefix) }
            .map { $0.removing(prefix: prefix.trimmingTrailingWhitespace()) }
            .joined(separator: "\n")
        
        let items = Itemizer.itemize(string: unprefixedString)
        let wrappedString = wrap(items: items, lineLength: lineLength)
    
        let wrappedWithPrefix = wrappedString
            .lines()
            .map { prefix.appending($0) }
            .map { $0.trimmingTrailingWhitespace() }
            .joined(separator: "\n")
    
        return wrappedWithPrefix
    }
    
    private static func wrap(items: [StringItem], lineLength: Int) -> String {
        
        var lines = [String]()
        var currentLine = String()
        var whiteSpace = String()
        
        func appendCurrentLine() {
            if currentLine.isEmpty == false {
                lines.append(currentLine)
                currentLine = ""
            }
        }
        
        var reversed = Array(items.reversed())
        while let next = reversed.popLast() {
            
            // next.debug_print()
            
            switch next {
            case .word(let word):
                if currentLine.count + whiteSpace.count + word.count > lineLength {
                    appendCurrentLine()
                    whiteSpace = ""
                }
                currentLine.append(contentsOf: whiteSpace)
                currentLine.append(contentsOf: word)
                whiteSpace = ""
            case .space:
                whiteSpace.append(" ")
            case .newline:
                if currentLine.isEmpty {
                    lines.append("")
                } else {
                    appendCurrentLine()
                }
            case .bullet:
                whiteSpace = ""
                currentLine.append("-")
            case .code(let code):
                whiteSpace = ""
                currentLine.append(contentsOf: code)
            }
        }
        
        appendCurrentLine()
        
        return lines.joined(separator: "\n")
    }
    
}
