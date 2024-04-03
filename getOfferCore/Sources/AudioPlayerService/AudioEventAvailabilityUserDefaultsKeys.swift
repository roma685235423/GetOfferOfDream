import Foundation

enum AudioEventAvailabilityUserDefaultsKeys {
    case kilometer
    case percentage
    case pace

    var string: String {
        switch self {
        case .kilometer:
            return "kilometerReachedEnabled"
        case .percentage:
            return "percentageReachedEnabled"
        case .pace:
            return "paceReachedEnabled"
        }
    }
}
