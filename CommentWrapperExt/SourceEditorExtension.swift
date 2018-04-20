//
//  SourceEditorExtension.swift
//  CommentWrapperExt
//
//  Created by Steve Barnegren on 06/04/2018.
//  Copyright © 2018 Steve Barnegren. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    /*
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
     */
    
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        
        return Action.all
            .map { [XCSourceEditorCommandDefinitionKey.identifierKey: $0.identifier,
                    XCSourceEditorCommandDefinitionKey.nameKey: $0.name,
                    XCSourceEditorCommandDefinitionKey.classNameKey: "Comment_Wrapper.SourceEditorCommand"
                ]}
    }
    
}
