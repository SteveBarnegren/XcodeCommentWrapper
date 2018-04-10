//
//  CommentWrapperTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest
@testable import CommentWrapper

/*
 ant
 bear
 cat
 dog
 emu
 fox
 gecko
 heron
 iguana
 jellyfish
 koala
 lion
 monkey
 newt
 octopus
 parrot
 quail
 rabbit
 sheep
 tiger
 uakari
 vole
 walrus
 xenopus
 yak
 zebra
 */

class CommentWrapperTests: XCTestCase {
    
    // MARK: - Wrapping
    
    func testWrapsLines() {
        
        let input = TestStrings.alphabeticalAnimals
        
        //////////////////////////////////////// <-- Guide (40 chars)
        let expected = """
        ant bear cat dog emu fox gecko heron
        iguana jellyfish koala lion monkey newt
        octopus parrot quail rabbit sheep tiger
        uakari vole walrus xenopus yak zebra
        """
        
        let output = CommentWrapper.wrap(string: input, lineLength: 40)
        
        XCTAssertEqual(output, expected)
    }
    
    func testWrapsLinesWithMultipleSpaces() {
        
        let input = TestStrings.alphabeticalAnimals.replacingOccurrences(of: " ", with: "  ")
        
        //////////////////////////////////////// <-- Guide (40 chars)
        let expected = """
        ant  bear  cat  dog  emu  fox  gecko
        heron  iguana  jellyfish  koala  lion
        monkey  newt  octopus  parrot  quail
        rabbit  sheep  tiger  uakari  vole
        walrus  xenopus  yak  zebra
        """
        
        let output = CommentWrapper.wrap(string: input, lineLength: 40)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Comment prefixes
    
    func testInsertsPrefixWithDoubleForwardSlashAndSpace() {
        
        let input = "// ".appending(TestStrings.alphabeticalAnimals)
        
        ////////////////////////////////////////*** <-- Guide (40 chars + 3 prefix)
        let expected = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let output = CommentWrapper.wrap(string: input, lineLength: 40)
        
        XCTAssertEqual(output, expected)
    }
    
    func testInsertsPrefixWithTripleForwardSlash() {
        
        let input = "///".appending(TestStrings.alphabeticalAnimals)
        
        ////////////////////////////////////////*** <-- Guide (40 chars + 3 prefix)
        let expected = """
        ///ant bear cat dog emu fox gecko heron
        ///iguana jellyfish koala lion monkey newt
        ///octopus parrot quail rabbit sheep tiger
        ///uakari vole walrus xenopus yak zebra
        """
        
        let output = CommentWrapper.wrap(string: input, lineLength: 40)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Newlines
    
    func testHandlesNewLines() {
    
        let input = "// " + TestStrings.alphabeticalAnimals + "\n\n" + "// " + TestStrings.alphabeticalAnimals
        
        ////////////////////////////////////////*** <-- Guide (40 chars + 3 prefix)
        let expected = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        //
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let output = CommentWrapper.wrap(string: input, lineLength: 40)
        
        XCTAssertEqual(output, expected)
    }
}
