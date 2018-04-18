//
//  StringItemTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 16/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest

class StringItemTests: XCTestCase {
    
    func testEquatable() {
        
        let uniqueInstances: [StringItem] = [
            .space,
            .newline,
            .bullet,
            .word("aaa"),
            .word("bbb"),
            .code("aaa"),
            .code("bbb")
        ]
        
        for (leftIndex, left) in uniqueInstances.enumerated() {
            for (rightIndex, right) in uniqueInstances.enumerated() {
             
                if leftIndex == rightIndex {
                    XCTAssertEqual(left, right)
                } else {
                    XCTAssertNotEqual(left, right)
                }
            }
        }
    }
    
    func testIsWhitespace() {
        
        XCTAssertTrue(StringItem.space.isWhitespace)
        XCTAssertTrue(StringItem.newline.isWhitespace)
        XCTAssertFalse(StringItem.bullet.isWhitespace)
        XCTAssertFalse(StringItem.word("aaa").isWhitespace)
        XCTAssertFalse(StringItem.code("aaa").isWhitespace)
    }
    
    func testStringItemsArrayContainsOnlyWhiteSpace() {
        
        XCTAssertTrue([StringItem.space, StringItem.newline].containsOnlyWhiteSpace)
        XCTAssertFalse([StringItem.space, StringItem.bullet].containsOnlyWhiteSpace)
    }

}
