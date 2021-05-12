import Foundation
import XCTest

class TestObserver: NSObject, XCTestObservation {
    
    static var storedLineLength: LineLengthOption? = nil

    override init() {
        super.init()
        XCTestObservationCenter.shared.addTestObserver(self)
    }

    func testBundleWillStart(_ testBundle: Bundle) {
        // Save the line length that is stored in user defaults
        Self.storedLineLength = Settings.lineLength
        
        // Set the line length to the default value so that the tests will pass
        Settings.lineLength = .excludingLeadingIndentation
    }
    
    func testBundleDidFinish(_ testBundle: Bundle) {
        // Set the line length back to what was stored in user defaults.
        Settings.lineLength = Self.storedLineLength ??
                .excludingLeadingIndentation
    }

}
