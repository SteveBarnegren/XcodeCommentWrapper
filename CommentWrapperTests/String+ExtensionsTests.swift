//
//  String+ExtensionsTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest

class String_ExtensionsTests: XCTestCase {
    
    // MARK: - Lines
    
    func testEmptyStringReturnsNoLines() {
        
        let string = String()
        XCTAssertEqual(string.lines(), [])
    }
    
    func testStringWithSingleLineReturnsSingleLine() {
        
        let string = "I have one line"
        XCTAssertEqual(string.lines(), ["I have one line"])
    }
    
    func testStringWithMultipleLinesReturnsMultipleLines() {
        
        let string = "I am a string\nwith\nmultiple lines"
        XCTAssertEqual(string.lines(), ["I am a string", "with", "multiple lines"])
    }
    
    // MARK: - Character at index
    
    func testCharacterAtIndexReturnsCharacter() {
        
        let string = "string"
        XCTAssertEqual(string.character(at: 0), "s")
        XCTAssertEqual(string.character(at: 1), "t")
        XCTAssertEqual(string.character(at: 2), "r")
        XCTAssertEqual(string.character(at: 3), "i")
        XCTAssertEqual(string.character(at: 4), "n")
        XCTAssertEqual(string.character(at: 5), "g")
    }
    
    // MARK: - Removing prefix
    
    func testRemovingPrefixRemovesPrefix() {
        
        let string = "hello world"
        XCTAssertEqual(string.removing(prefix: "hello "), "world")
    }
    
    func testRemovingPrefixDoesntAlterStringWithoutPrefix() {
        
        let string = "hello world"
        XCTAssertEqual(string.removing(prefix: "abc"), "hello world")
    }
    
    // MARK: - Trimming trailing whitespace
    
    func testTrimmingTrailingWhitespaceRemovesTrailingSpaces() {
        
        let string = "hello   "
        XCTAssertEqual(string.trimmingTrailingWhitespace(), "hello")
    }
    
    func testTrimmingTrailingWhitespaceTrimsTrailingnNewlines() {
        
        let string = "hello\n\n\n"
        XCTAssertEqual(string.trimmingTrailingWhitespace(), "hello")
    }
    
    func testTrimmingTrailingWhitespaceTrimsTrailingTabs() {
        
        let string = "hello\t\t\t"
        XCTAssertEqual(string.trimmingTrailingWhitespace(), "hello")
    }
}
