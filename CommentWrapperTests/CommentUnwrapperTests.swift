//
//  CommentUnwrapperTests.swift
//  CommentWrapperTests
//
//  Created by Steve Barnegren on 08/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import XCTest

class CommentUnwrapperTests: XCTestCase {
    
    // MARK: - Unwrapping
    
    func testUnwrapsLines() {
        
        //////////////////////////////////////// <-- Guide (40 chars)
        let input = """
        ant bear cat dog emu fox gecko heron
        iguana jellyfish koala lion monkey newt
        octopus parrot quail rabbit sheep tiger
        uakari vole walrus xenopus yak zebra
        """
        
        let expected = TestStrings.alphabeticalAnimals
        
        let commentUnwrapper = CommentUnwrapper()
        let output = commentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    func testUnwrapsLinesWithMultipleSpaces() {
        
        // If this wrapped input had been generated with two spaces between each line, unwrapping will lose the double space where the line wraps
        
        //////////////////////////////////////// <-- Guide (40 chars)
        let input = """
        ant  bear  cat  dog  emu  fox  gecko
        heron  iguana  jellyfish  koala  lion
        monkey  newt  octopus  parrot  quail
        rabbit  sheep  tiger  uakari  vole
        walrus  xenopus  yak  zebra
        """
        
        let expected = TestStrings.alphabeticalAnimals
            .replacingOccurrences(of: " ", with: "  ")
            .replacingOccurrences(of: "gecko  ", with: "gecko ")
            .replacingOccurrences(of: "lion  ", with: "lion ")
            .replacingOccurrences(of: "quail  ", with: "quail ")
            .replacingOccurrences(of: "vole  ", with: "vole ")

        let commentUnwrapper = CommentUnwrapper()
        let output = commentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Comment prefix
    
    func testHandlesCommentPrefix() {
        
        ////////////////////////////////////////*** <-- Guide (40 chars + 3 prefix)
        let input = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let expected = "// ".appending(TestStrings.alphabeticalAnimals)
        
        let commentUnwrapper = CommentUnwrapper()
        let output = commentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Newlines
    
    func testHandlesNewlines() {
        
        ////////////////////////////////////////*** <-- Guide (40 chars + 3 prefix)
        let input = """
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
        
        let expected = "// " + TestStrings.alphabeticalAnimals + "\n\n" + "// " + TestStrings.alphabeticalAnimals
        
        
        let commentUnwrapper = CommentUnwrapper()
        let output = commentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
}
