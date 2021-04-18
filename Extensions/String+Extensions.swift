//
//  String+Extensions.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

extension String {
    
    var isCodeFence: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines) == "```"
    }

    func lines() -> [String] {
        
        if self.isEmpty {
            return []
        } else {
            return self.components(separatedBy: "\n")
        }
    }
    
    func character(at index: Int) -> Character {
        let stringIndex = self.index(self.startIndex, offsetBy: index)
        return self[stringIndex]
    }
    
    func removing(prefix: String) -> String {
        
        if self.hasPrefix(prefix) {
            let substring = self.suffix(from: self.index(self.startIndex, offsetBy: prefix.count))
            return String(substring)
        } else {
            return self
        }
    }
    
    func trimmingTrailingWhitespace() -> String {
        
        var string = self
        while let last = string.last, last.isWhitespace {
            string = String(string.dropLast())
        }
        
        return string
    }
    
    func commentPrefix() -> String {
        
        var prefix = String()
        
        for character in self {
            if character == " " || character == "/" {
                prefix.append(character)
            } else {
                return prefix
            }
        }
        
        return prefix
    }
}
