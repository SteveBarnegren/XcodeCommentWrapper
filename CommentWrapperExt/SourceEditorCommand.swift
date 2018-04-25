//
//  SourceEditorCommand.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

// swiftlint:disable redundant_void_return

import Foundation
import XcodeKit

enum Action: String {
    case wrap40 = "commentwrapper.wrap-40"
    case wrap60 = "commentwrapper.wrap-60"
    case wrap80 = "commentwrapper.wrap-80"
    case unwrap = "commentwrapper.unwrap"
    case rewrap40 = "commentwrapper.rewrap-40"
    case rewrap60 = "commentwrapper.rewrap-60"
    case rewrap80 = "commentwrapper.rewrap-80"
    
    var identifier: String {
        return self.rawValue
    }
    
    var name: String {
        switch self {
        case .wrap40: return "Wrap (40)"
        case .wrap60: return "Wrap (60)"
        case .wrap80: return "Wrap (80)"
        case .unwrap: return "Unwrap"
        case .rewrap40: return "Re-wrap (40)"
        case .rewrap60: return "Re-wrap (60)"
        case .rewrap80: return "Re-wrap (80)"
        }
    }
    
    var lineLength: Int {
        
        switch self {
        case .wrap40: return 40
        case .wrap60: return 60
        case .wrap80: return 80
        case .unwrap: fatalError("Unwrap action does not have a line length")
        case .rewrap40: return 40
        case .rewrap60: return 60
        case .rewrap80: return 80
        }
    }
    
    static var all: [Action] {
        return [Action.wrap40, .wrap60, .wrap80, .unwrap, .rewrap40, .rewrap60, .rewrap80]
    }
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation,
                 completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it
        // nil on success, and an NSError on failure.
        
        guard let action = Action(rawValue: invocation.commandIdentifier) else {
            print("Unknown action")
            completionHandler(nil)
            return
        }
        
        for selection in invocation.buffer.selections as! [XCSourceTextRange] {
            
            let selectedLines: [String] = invocation.buffer.lines as! [String]
            if selectedLines.count == 0 { continue }
            
            let startLine = selection.start.line
            let endLine = min(selection.end.line, selectedLines.count-1)
            var selectedText = selectedLines[startLine...endLine].joined()
            
            switch action {
            case .wrap40, .wrap60, .wrap80:
                selectedText = CommentWrapper.wrap(string: selectedText, lineLength: action.lineLength)
            case .unwrap:
                selectedText = CommentUnwrapper.unwrap(string: selectedText)
            case .rewrap40, .rewrap60, .rewrap80:
                let unwrapped = CommentUnwrapper.unwrap(string: selectedText)
                let rewrapped = CommentWrapper.wrap(string: unwrapped, lineLength: action.lineLength)
                selectedText = rewrapped
            }
            
            let range = NSRange(location: startLine, length: (endLine - startLine)+1)
            invocation.buffer.lines.replaceObjects(in: range, withObjectsFrom: selectedText.lines())
        }
        
        completionHandler(nil)
    }
}
