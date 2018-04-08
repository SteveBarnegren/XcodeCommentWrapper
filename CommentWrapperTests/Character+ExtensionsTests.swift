//
//  Character+ExtensionsTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest

class Character_ExtensionsTests: XCTestCase {

    func testIsWhitespace() {
        
        XCTAssertTrue(Character(" ").isWhitespace)
        XCTAssertTrue(Character("\n").isWhitespace)
        XCTAssertTrue(Character("\t").isWhitespace)
        XCTAssertFalse(Character("a").isWhitespace)
    }

}
