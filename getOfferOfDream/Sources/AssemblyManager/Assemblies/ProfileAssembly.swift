import Foundation
import GetOfferDI

// MARK: - ProfileAssembly

final class ProfileAssembly: Assembly {
    
    func assemble() {
        Container.shared.register(service: ProfileItemViewController.self) { _ in
        ProfileItemViewController()
        }
        @Dependency var view: ProfileItemViewController
        
        view.viewDidLoad()
    }
}
