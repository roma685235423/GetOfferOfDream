import Foundation

// MARK: - Dependency @propertyWrapper

@propertyWrapper
public class Dependency<T> {
    
    // MARK: public properties
    
    public var wrappedValue: T
    
    // MARK: life cycle
    
    public init() {
        self.wrappedValue = Container.shared.resolve()
    }
}
