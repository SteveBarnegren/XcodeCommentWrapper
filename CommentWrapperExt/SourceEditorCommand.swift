//
//  SourceEditorCommand.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import XcodeKit

enum Action: String {
    case wrap = "wrap"
    case unwrap = "unwrap"
    case rewrap = "re-wrap"
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        guard let action = Action(rawValue: invocation.commandIdentifier) else {
            print("Unknown action")
            completionHandler(nil)
            return
        }
        
        for selection in invocation.buffer.selections as! [XCSourceTextRange] {
            
            let startLine = selection.start.line
            let endLine = selection.end.line
            let selectedLines: [String] = invocation.buffer.lines as! [String]
            var selectedText = selectedLines[startLine...endLine].joined()
            
            switch action {
            case .wrap:
                selectedText = CommentWrapper.wrap(string: selectedText, lineLength: 40)
            case .unwrap:
                selectedText = CommentUnwrapper.unwrap(string: selectedText)
            case .rewrap:
                let unwrapped = CommentUnwrapper.unwrap(string: selectedText)
                let rewrapped = CommentWrapper.wrap(string: unwrapped, lineLength: 40)
                selectedText = rewrapped
            }
            
            let range = NSRange(location: startLine, length: (endLine - startLine)+1)
            invocation.buffer.lines.replaceObjects(in: range, withObjectsFrom: selectedText.lines())
        }
        
        completionHandler(nil)
    }
}
