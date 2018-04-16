//
//  Itemizer.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

enum StringItem {
    case word(String)
    case space
    case newline
    case code(String)
    
    func debug_print() {
        switch self {
        case .word(let word): print("word: \(word)")
        case .space: print("space")
        case .newline: print("newline")
        case .code(let code): print("code: \(code)")
        }
    }
}

extension StringItem: Equatable {
    static func == (lhs: StringItem, rhs: StringItem) -> Bool {
        
        switch (lhs, rhs) {
        case (.word(let lWord), .word(let rWord)):
            return lWord == rWord
        case (.space, .space):
            return true
        case (.newline, .newline):
            return true
        case (.code(let lCode), .code(let rCode)):
            return lCode == rCode
        default:
            return false
        }
    }
}

class Itemizer {
    
    static func itemize(string: String) -> [StringItem] {

        var items = [StringItem]()
        func appendNewline() {
            if items.isEmpty == false {
                items.append(.newline)
            }
        }
        
        for line in string.lines() {
            
            if line.hasPrefix("    ") {
                appendNewline()
                items.append(.code(line))
            } else {
                appendNewline()
                items.append(contentsOf: itemize(line: line))
            }
        }
        
        return items
    }
    
    static func itemize(line: String) -> [StringItem] {
        
        var items = [StringItem]()
        var currentWord = String()
        
        var currentWhitespace = [StringItem]()
        
        func storeCurrentWord() {
            if !currentWord.isEmpty {
                items.append(.word(currentWord))
                currentWord = ""
            }
        }
        
        for character in line {
            if character == " " {
                storeCurrentWord()
                items.append(.space)
            } else if character == "\n" {
                storeCurrentWord()
                items.append(.newline)
            } else {
                currentWord.append(character)
            }
        }
        
        storeCurrentWord()
        
        return items
    }
}
