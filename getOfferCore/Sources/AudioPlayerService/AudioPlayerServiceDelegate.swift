import Foundation

public protocol AudioPlayerServiceDelegate: AnyObject {
    func audioPlayerService(didUpdateQueue eventQueue: [AudioEventType])
    func audioEventGroupFeedback( group: AudioEventGroup, state: Bool )
}
