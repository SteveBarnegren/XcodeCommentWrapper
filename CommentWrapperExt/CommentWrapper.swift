//
//  CommentWrapper.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

enum StringItem {
    case word(String)
    case space
    case newline
}

extension String {
    
    func lines() -> [String] {
        return self.components(separatedBy: "\n")
    }
    
    func words() -> [String] {
        return self.components(separatedBy: " ")
    }
    
    func character(at index: Int) -> Character {
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
}

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

    func wrap(string: String, lineLength: Int) -> String {
        
        let prefix = commentPrefix(fromString: string)
        let unprefixedString = String(
            string.suffix(from: string.index(string.startIndex, offsetBy: prefix.count))
        )
        let items = itemize(string: unprefixedString)
        let wrappedString = wrap(items: items, lineLength: lineLength)
    
        let wrappedWithPrefix = wrappedString
            .lines()
            .map { prefix.appending($0) }
            .joined(separator: "\n")
    
        return wrappedWithPrefix
    }
    
    func commentPrefix(fromString string: String) -> String {
        
        var prefix = String()
        
        for character in string {
            if character == " " || character == "/" {
                prefix.append(character)
            } else {
                return prefix
            }
        }
        
        return prefix
    }
    
    func itemize(string: String) -> [StringItem] {
     
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
    
    func wrap(items: [StringItem], lineLength: Int) -> String {
        
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
                appendCurrentLine()
            }
        }
        
        appendCurrentLine()
        
        return lines.joined(separator: "\n")
    }
}
