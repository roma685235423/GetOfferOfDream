import Foundation
import GetOfferDI

// MARK: - MainItemAssembly

final class FavoriteItemAssembly: Assembly {
    
    func assemble() {
        Container.shared.register(service: FavoriteItemViewController.self) { _ in
            FavoriteItemViewController()
        }
        @Dependency var view: FavoriteItemViewController
        
        view.viewDidLoad()
    }
}
