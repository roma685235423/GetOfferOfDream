import Foundation
import GetOfferDI

// MARK: - MainItemAssembly

final class MainItemAssembly: Assembly {
    
    func assemble() {
        Container.shared.register(service: MainItemViewController.self) { _ in
            MainItemViewController()
        }
        @Dependency var view: MainItemViewController
        
        view.viewDidLoad()
    }
}
