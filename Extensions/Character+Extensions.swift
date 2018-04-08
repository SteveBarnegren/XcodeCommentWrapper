//
//  Character+Extensions.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation

extension Character {
    
    var isWhitespace: Bool {
        return (self == " " || self == "\n" || self == "\t")
    }
    
}
