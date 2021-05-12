import Foundation

/// Contains the settings from UserDefaults.
enum Settings {
    
    private static let userDefaults = UserDefaults(
        suiteName: "group.CommentWrapper"
    )!
    
    static var lineLength: LineLengthOption {
        get {
            Self.userDefaults.string(
                forKey: LineLengthOption.lineLengthKey
            )
            .flatMap(LineLengthOption.init(rawValue:))
            ?? .excludingLeadingIndentation
        }
        set {
            Self.userDefaults.setValue(
                newValue.rawValue,
                forKey: LineLengthOption.lineLengthKey
            )
        }
    }

}

enum LineLengthOption: String, CaseIterable {
    
    /// The `UserDefaults` key used to store this option.
    static let lineLengthKey = "line length"

    case excludingLeadingIndentation = "Excluding Leading Indentation"
    case absolute = "Absolute"
}
