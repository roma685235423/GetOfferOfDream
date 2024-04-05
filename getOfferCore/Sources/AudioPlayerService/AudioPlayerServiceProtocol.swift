import Foundation

/**
 Протокол для сервиса воспроизведения аудио.

 Данный протокол определяет методы, которые должен реализовать сервис для работы с аудио событиями и их группами.

 # Пример использования
 ```
 class MyAudioPlayerService: AudioPlayerServiceProtocol {
 func playAudio(for event: AudioEventType) {
 // Воспроизведение аудио для указанного события
 }
 }
 ```
 */

public protocol AudioPlayerServiceProtocol: AnyObject {
    var delegate: AudioPlayerServiceDelegate? { get set }
    func playAudio(for event: AudioEventType)
}
