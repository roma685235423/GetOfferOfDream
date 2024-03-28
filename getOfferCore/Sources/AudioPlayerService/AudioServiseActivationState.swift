import Foundation

/**
 Оболочка для управления состоянием активации сервиса звукового воспроизведения.

 Свойство `wrappedValue` представляет состояние активации сервиса звукового воспроизведения,
 хранящееся в `UserDefaults` по указанному ключу.

 - Note: При чтении свойства `wrappedValue` будет извлечено текущее состояние активации сервиса из `UserDefaults`.
 При установке нового значения этот новое значение будет сохранено в `UserDefaults` под указанным ключом.
 */

@propertyWrapper
struct AudioServiseActivationState {

    let key: String
    let state: Bool

    var wrappedValue: Bool {
        get { UserDefaults.standard.bool(forKey: key) }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }

    init(key: String, state: Bool) {
        self.key = key
        self.state = state
    }
}
