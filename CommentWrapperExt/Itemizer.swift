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
    case bullet
    case code(String)
    case markdownReferenceLink(String)
    
    var isWhitespace: Bool {
        switch self {
        case .word: return false
        case .space: return true
        case .newline: return true
        case .bullet: return false
        case .code: return false
        case .markdownReferenceLink: return false
        }
    }
    
    func debug_print() {
        switch self {
        case .word(let word): print("word: \(word)")
        case .space: print("space")
        case .newline: print("newline")
        case .bullet: print("bullet")
        case .code(let code): print("code: \(code)")
        case .markdownReferenceLink(let link): print("link: \(link)")
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
        case (.bullet, .bullet):
            return true
        case (.code(let lCode), .code(let rCode)):
            return lCode == rCode
        case (.markdownReferenceLink(let lLink), .markdownReferenceLink(let rLink)):
            return lLink == rLink
        default:
            return false
        }
    }
}

extension Array where Element == StringItem {
    
    var containsOnlyWhiteSpace: Bool {
        return self.contains { $0.isWhitespace == false } == false
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
        
        var insideCodeBlock = false

        for line in string.lines() {

            appendNewline()
            
            if insideCodeBlock {
                items.append(.code(line))
                if line.isCodeFence {
                    insideCodeBlock = false
                }
            }
            else if line.isCodeFence {
                insideCodeBlock = true
                items.append(.code(line))
            }

            else if line.hasPrefix("    ") {
                items.append(.code(line))
            } else if isMarkdownReferenceLink(line) {
                items.append(.markdownReferenceLink(line))
            } else {
                items.append(contentsOf: itemize(line: line))
            }
        }
        
        return items
    }
    
    static func itemize(line: String) -> [StringItem] {
        
        var items = [StringItem]()
        var currentWord = String()
                
        func storeCurrentWord() {
            if !currentWord.isEmpty {
                items.append(.word(currentWord))
                currentWord = ""
            }
        }
        
        for character in line {
            
            switch character {
                case " ":
                    storeCurrentWord()
                    items.append(.space)
                case "\n":
                    storeCurrentWord()
                    items.append(.newline)
                case "-" where currentWord.isEmpty && items.containsOnlyWhiteSpace:
                    items.append(.bullet)
                default:
                    currentWord.append(character)
            }

        }
        
        storeCurrentWord()
        
        return items
    }
    
    private static func isMarkdownReferenceLink(_ line: String) -> Bool {
        
        let trimmedLine = line.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        // See https://regex101.com/r/74bf6w/1
        let regex = try! NSRegularExpression(
            pattern: #"^\[\d+\]:\s*[^\s]+$"#
        )
        
        let nsRange = NSRange(
            trimmedLine.startIndex..<trimmedLine.endIndex,
            in: trimmedLine
        )

        let match = regex.firstMatch(in: trimmedLine, options: [], range: nsRange)
        return match != nil

    }

}
