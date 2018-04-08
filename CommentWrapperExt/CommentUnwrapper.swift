//
//  CommentUnwrapper.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

class CommentUnwrapper {
    
    func unwrap(string: String) -> String {
        
        let items = Itemizer.itemize(string: string)
        return unwrappedString(fromItems: items)
    }
    
    private func unwrappedString(fromItems items: [StringItem]) -> String {
        
        var unwrappedString = String()
        
        var reversed = Array(items.reversed())
        while let next = reversed.popLast() {
            
            switch next {
            case .word(let word):
                unwrappedString += word
            case .space:
                unwrappedString += " "
            case .newline:
                unwrappedString += " "
            }
        }
        
        return unwrappedString
    }
}
