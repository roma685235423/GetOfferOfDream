import Foundation

// MARK: - Dependency @propertyWrapper
@propertyWrapper
public class Dependency<T> {

    // MARK: - Public Properties
    public var wrappedValue: T

    // MARK: - Initializers
    public init() {
        self.wrappedValue = Container.shared.resolve()
    }

}
