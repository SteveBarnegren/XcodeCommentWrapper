//
//  IntroductionContent.swift
//  CommentWrapper
//
//  Created by Steve Barnegren on 21/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

// swiftlint:disable line_length

import Foundation
import AttributedStringBuilder

class IntroductionContent {
    
    static func makeAttributedString() -> NSAttributedString {
        
        return AttributedStringBuilder()
            .attributedText( makeIntroductionAttributedString() )
            .newlines(3)
            .attributedText( makeWrappingSectionAttributedString() )
            .newlines(3)
            .attributedText( makeUnwrappingSectionAttributedString() )
            .newlines(3)
            .attributedText( makeReWrappingSectionAttributedString() )
            .newlines(3)
            .attributedText( makeFeaturesSectionAttributedString() )
            .attributedString
    }
    
    private static func makeIntroductionAttributedString() -> NSAttributedString {
        
        return ContentBuilder()
            .title("Comment Wrapper")
            .body("""
            Comment Wrapper is an Xcode source editor extension that can format comments to wrap at a certain line length.
            """)
            .attributedString
    }
    
    private static func makeWrappingSectionAttributedString() -> NSAttributedString {
        
        let originalComment = """
            /// This is a long comment that descripes some behavior. Long comments are difficult to read because they become very long horizontally. We often place limits on how many columns wide our code should be in order to improve readablity, but this can be more difficult to achieve with comments
            """
        let wrappedComment = CommentWrapper.wrap(string: originalComment, lineLength: 80)
        
        return ContentBuilder()
            .title("Wrapping Comments")
            .body("""
            You might have a comment that looks like this:
            """)
            .comment(originalComment)
            .body("Using Comment Wrapper to wrap the text at a line length of 80 results in the following:")
            .comment(wrappedComment)
            .attributedString
    }
    
    private static func makeUnwrappingSectionAttributedString() -> NSAttributedString {
        
        return ContentBuilder()
            .title("Unwrapping Comments")
            .body("""
            Want to edit a wrapped comment? No problem, use the Comment Wrapper's 'unwrap' functionality to revert a comment to it's original format
            """)
            .attributedString
    }
    
    private static func makeReWrappingSectionAttributedString() -> NSAttributedString {
        
        let lineLength = 60
        
        let comment = "// This code performs actions 1, 2 and 3 on any input a, b or c. Any action that's passed in must conform to firstProtocol and secondProtocol. The result will be of a type x, y or z."
        let wrappedComment = CommentWrapper.wrap(string: comment, lineLength: lineLength)
        let editedComment = wrappedComment.replacingOccurrences(of: "must conform", with: "must not confrom to XYZProtocol but must conform")
        
        var rewrappedComment = CommentUnwrapper.unwrap(string: editedComment)
        rewrappedComment = CommentWrapper.wrap(string: rewrappedComment, lineLength: lineLength)
        
        return ContentBuilder()
            .title("Re-Wrapping Comments")
            .body("""
            Once you've wrapped a comment, you might want to edit it in place, although adding or removing characters an a particular line will make it too long or too short. You can use Comment Wrapper's 're-wrap' functionality to re-wrap the comment.
            """)
            .body("Original comment (wrapped at a line length of \(lineLength):")
            .comment(wrappedComment)
            .body("After editing:")
            .comment(editedComment)
            .body("After Re-wrapping:")
            .comment(rewrappedComment)
            .attributedString
    }
    
    private static func makeFeaturesSectionAttributedString() -> NSAttributedString {
        
        return ContentBuilder()
            .title("Other features:")
            .body("- Comment Wrapper will preserve your comment prefix, whether it's '//' or '///'")
            .body("- This makes Comment Wrapper great for formatting your inline documentation!")
            .body("- Comment Wrapper understands when you're using example code in your inline documentation, so it won't wrap your code")
            .attributedString
    }

}
