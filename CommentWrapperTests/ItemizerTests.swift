//
//  ItemizerTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 16/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest

class ItemizerTests: XCTestCase {
    
    func testItemizesWordsAndSpaces() {
        
        let input = "hello world"
        let expected: [StringItem] = [.word("hello"), .space, .word("world")]
        XCTAssertEqual(Itemizer.itemize(string: input), expected)
    }
    
    func testItemizesNewlines() {
        
        let input = "hello\nworld"
        let expected: [StringItem] = [.word("hello"), .newline, .word("world")]
        XCTAssertEqual(Itemizer.itemize(string: input), expected)
    }
    
    func testItemizesTextWithCodeLines() {
        
        let input = """
        This is a comment
            var x = y
        This is a comment
        """
        
        let expected: [StringItem] = [
            .word("This"), .space, .word("is"), .space, .word("a"), .space, .word("comment"), .newline,
            .code("    var x = y"), .newline,
            .word("This"), .space, .word("is"), .space, .word("a"), .space, .word("comment")
        ]
        
        XCTAssertEqual(Itemizer.itemize(string: input), expected)
    }
    
    func testItemizesBulletedLists() {
        
        let input = """
        - First item
        - Second item
        - Third item
        """
        
        let expected: [StringItem] = [
            .bullet, .space, .word("First"), .space, .word("item"), .newline,
            .bullet, .space, .word("Second"), .space, .word("item"), .newline,
            .bullet, .space, .word("Third"), .space, .word("item"),
        ]
        
        XCTAssertEqual(Itemizer.itemize(string: input), expected)
    }

}
