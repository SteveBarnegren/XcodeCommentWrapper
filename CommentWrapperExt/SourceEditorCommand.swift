//
//  SourceEditorCommand.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        if invocation.commandIdentifier == "wrap" {
            let commentWrapper = CommentWrapper()
            invocation.buffer.completeBuffer = commentWrapper.wrap(string: invocation.buffer.completeBuffer, lineLength: 40)
        }
        
        completionHandler(nil)
    }
    
}
