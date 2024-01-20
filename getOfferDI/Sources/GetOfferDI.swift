import Foundation

// MARK: - GetOfferDI

public final class Container {
    
    // MARK: public properties
    
    public static let shared = Container()
    
    // MARK: private properties
    
    private var services: [String: Any] = [:]
    
    // MARK: life cycle
    
    public init() {}
    
    // MARK: - public methods
    
    public func register<Service>(service: Service.Type, resolver: @escaping(Container) -> Service) {
        let key = "\(type(of: Service.self))"
        self.services[key] = resolver(self)
    }
    
    public func resolve<Service>() -> Service {
        let key = "\(type(of: Service.self))"
        guard let service = services[key] as? Service else {
            fatalError("\(key) service not registered")
        }
        return service
    }
}
