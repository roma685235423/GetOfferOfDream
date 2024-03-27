import Foundation

public enum AudioEventType {
    case kilometerReached(Int)
    case percentageReached(Int)
    case paceReached(Int)
    case highHeartRate

    public var audioFileName: String {
        switch self {
        case .kilometerReached(let kilometer):
            return "distance_\(kilometer)_km.wav"
        case .percentageReached(let percentage):
            return "time_workoutCompleted_\(percentage).wav"
        case .paceReached(let pace):
            return "pace_\(pace)_kmh.wav"
        case.highHeartRate:
            return "highHeartRate.wav"
        }
    }
}
