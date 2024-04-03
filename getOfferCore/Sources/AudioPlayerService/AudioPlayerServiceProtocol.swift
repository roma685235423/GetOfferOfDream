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

 func setAudioEventGroupAvailability(group: AudioEventGroup, state: Bool) {
 // Установка доступности группы аудио событий
 }

 func audioEventGroupAvailability(group: AudioEventGroup) -> Bool {
 // Получение информации о доступности группы аудио событий
 }
 }
 ```
 */

public protocol AudioPlayerServiceProtocol: AnyObject {
    var delegate: AudioPlayerServiceDelegate? { get set }
    func playAudio(for event: AudioEventType)
}

public protocol AudioPlayerUserDefaultsProtocol: AnyObject {
    func setAudioEventGroupAvailability(group: AudioEventGroup, state: Bool)
    func audioEventGroupAvailability(group: AudioEventGroup) -> Bool
}
