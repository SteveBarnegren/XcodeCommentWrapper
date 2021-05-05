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
        //-------------------------------------- <-- Guide (40 chars)
        let input = """
        ant bear cat dog emu fox gecko heron
        iguana jellyfish koala lion monkey newt
        octopus parrot quail rabbit sheep tiger
        uakari vole walrus xenopus yak zebra
        """
        
        let expected = TestStrings.alphabeticalAnimals
        let output = CommentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    func testUnwrapsLinesWithMultipleSpaces() {
        
        // If this wrapped input had been generated with two spaces between each line,
        // unwrapping will lose the double space where the line wraps
        
        //-------------------------------------- <-- Guide (40 chars)
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

        let output = CommentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Comment prefix
    
    func testHandlesCommentPrefix() {
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let expected = "// ".appending(TestStrings.alphabeticalAnimals)
        let output = CommentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Newlines
    
    func testHandlesNewlines() {
        
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
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
        let output = CommentUnwrapper.unwrap(string: input)
        
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Code
    
    func testHandlesCode() {
        
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        //
        //     this.is.some.code.that.runs.longer.than.40.chars()
        //
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let expected =
            "// " + TestStrings.alphabeticalAnimals + "\n" +
                "\n" +
                "//     this.is.some.code.that.runs.longer.than.40.chars()" + "\n" +
                "\n" +
                "// " + TestStrings.alphabeticalAnimals
        
        let output = CommentUnwrapper.unwrap(string: input)
        XCTAssertEqual(output, expected)
    }
    
    func testHandlesMultipleLinesOfCode() {
        
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        //
        //     this.is.some.code.that.runs.longer.than.40.chars()
        //     this.is.some.code.that.runs.longer.than.40.chars()
        //
        // ant bear cat dog emu fox gecko heron
        // iguana jellyfish koala lion monkey newt
        // octopus parrot quail rabbit sheep tiger
        // uakari vole walrus xenopus yak zebra
        """
        
        let expected =
            "// " + TestStrings.alphabeticalAnimals + "\n" +
                "\n" +
                "//     this.is.some.code.that.runs.longer.than.40.chars()" + "\n" +
                "//     this.is.some.code.that.runs.longer.than.40.chars()" + "\n" +
                "\n" +
                "// " + TestStrings.alphabeticalAnimals
        
        let output = CommentUnwrapper.unwrap(string: input)
        XCTAssertEqual(output, expected)
    }
    
    // MARK: - Bullets
    
    func testHandlesBullets() {
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // - First item
        // - Second item
        // - Third item
        """
        
        let output = CommentUnwrapper.unwrap(string: input)
        XCTAssertEqual(output, input)
    }
    
    func testHandlesBulletsAfterRegularComments() {
        
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // This is a comment
        //
        // - First item
        // - Second item
        // - Third item
        """
        
        let expected = """
        // This is a comment

        // - First item
        // - Second item
        // - Third item
        """
        
        let output = CommentUnwrapper.unwrap(string: input)
        XCTAssertEqual(output, expected)
    }
    
    func testHandlesMarkdownCodeBlocks() {
        
        //*---------------------------------------- <-- Guide (40 chars + 3 prefix)
        let input = """
        // Below is some code that should not be
        // unwrapped.
        // ```
        // this is the code that should not be unwrapped.
        // ```
        // Above is some code that should not be
        // unwrapped.
        """
        
        let expected = """
        // Below is some code that should not be unwrapped.
        // ```
        // this is the code that should not be unwrapped.
        // ```
        // Above is some code that should not be unwrapped.
        """
        
        let output = CommentUnwrapper.unwrap(string: input)
        XCTAssertEqual(output, expected)
    }
    
}
