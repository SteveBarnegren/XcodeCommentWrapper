//
//  CommentUnwrapper.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

class CommentUnwrapper {
    
    static func unwrap(string: String) -> String {
        
        let prefix = string.commentPrefix()
        let unprefixedString = string.lines()
            .map { $0.removing(prefix: prefix) }
            .map { $0.removing(prefix: prefix.trimmingTrailingWhitespace()) }
            .joined(separator: "\n")
                
        let items = Itemizer.itemize(string: unprefixedString)
        return unwrappedString(fromItems: items)
            .lines()
            .map {
                if $0.isEmpty == false {
                    return prefix + $0
                } else {
                    return $0
                }
            }
            .joined(separator: "\n")
    }
    
    private static func unwrappedString(fromItems items: [StringItem]) -> String {
        
        var unwrappedString = String()
        
        var lastItem: StringItem?
        
        var spacePending = false
        func commitPendingSpace() {
            if spacePending == true {
                unwrappedString += " "
                spacePending = false
            }
        }
                
        var reversed = Array(items.reversed())
        while let next = reversed.popLast() {
            
            // next.debug_print()
            
            switch next {
            case .word(let word):
                commitPendingSpace()
                unwrappedString += word
            case .space:
                commitPendingSpace()
                spacePending = true
            case .newline:
                switch lastItem {
                    case .newline:
                        if spacePending {
                            unwrappedString += "\n"
                            spacePending = false
                        }
                        unwrappedString += "\n"
                    case .code, .markdownReferenceLink:
                        unwrappedString += "\n"
                    default:
                        spacePending = true
                }
            case .bullet:
                if spacePending {
                    unwrappedString += "\n"
                    spacePending = false
                }
                unwrappedString += "-"
                spacePending = false
            case .code(let value), .markdownReferenceLink(let value):
                if spacePending {
                    unwrappedString += "\n"
                    spacePending = false
                }
                unwrappedString.append(contentsOf: value)
            }
            
            
            lastItem = next
        }
        
        return unwrappedString
    }
}
