import Foundation

// MARK: - Container
public final class Container {

    // MARK: - Public Properties
    public static let shared = Container()

    // MARK: - Private Properties
    private var services: [String: Any] = [:]

    // MARK: - Public Methods
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
