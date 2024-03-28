import Foundation

public enum AudioEventGroup {
    case all
    case kilometerReached
    case percentageReached
    case paceReached

    public func priority() -> Int {
        switch self {
        case .all:
            return 0
        case .kilometerReached:
            return 1
        case .percentageReached:
            return 2
        case .paceReached:
            return 3
        }
    }
}
