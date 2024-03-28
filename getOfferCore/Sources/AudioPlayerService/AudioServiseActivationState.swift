import Foundation

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
