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
    
    func debug_print() {
        switch self {
        case .word(let word): print("word: \(word)")
        case .space: print("space")
        case .newline: print("newline")
        }
    }
}

class Itemizer {
    
    static func itemize(string: String) -> [StringItem] {
        
        var items = [StringItem]()
        var currentWord = String()
        
        func storeCurrentWord() {
            if !currentWord.isEmpty {
                items.append(.word(currentWord))
                currentWord = ""
            }
        }
        
        for character in string {
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
