import Foundation
import AVFoundation

// MARK: - AudioPlayerService
public final class AudioPlayerService: NSObject {

    // MARK: - Public Properties
    public weak var delegate: AudioPlayerServiceDelegate?
    public static let shared = AudioPlayerService()

    // MARK: - Private Properties
    private var player: AVAudioPlayer?
    private var eventQueue: [AudioEventType] = [] {
        didSet {
            delegate?.audioPlayerService(didUpdateQueue: eventQueue)
        }
    }
    // MARK: - Public Methods
    public func playAudio(for event: AudioEventType) {
        let fileName = event.audioFileName
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            print("Audio file \(fileName) not found")
            return
        }
        eventQueue.append(event)

        guard player == nil || !player!.isPlaying else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: fileUrl)
            player?.delegate = self
            player?.prepareToPlay()
            player?.play()

        } catch let error {
            print("Error playing audio: \(error.localizedDescription)")
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioPlayerService: AVAudioPlayerDelegate {

    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        eventQueue.removeFirst()
        guard let nextEvent = eventQueue.first else { return }

        if let fileUrl = Bundle.main.url(forResource: nextEvent.audioFileName, withExtension: nil) {
            do {
                self.player = try AVAudioPlayer(contentsOf: fileUrl)
                self.player?.delegate = self
                self.player?.prepareToPlay()
                self.player?.play()
            } catch let error {
                print("Error playing audio: \(error.localizedDescription)")
            }
        }
    }
}
