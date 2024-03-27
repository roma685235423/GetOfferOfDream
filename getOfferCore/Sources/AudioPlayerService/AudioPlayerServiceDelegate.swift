import Foundation

public protocol AudioPlayerServiceDelegate: AnyObject {
    func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType])
}
