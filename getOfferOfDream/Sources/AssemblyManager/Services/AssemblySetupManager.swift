import Foundation
import GetOfferDI

// MARK: - AssemblySetupManager

final class AssemblySetupManager {
    
    // MARK: Public properties
    static let shared = AssemblySetupManager()
    
    // MARK: Private properties
    private let assemblies: [Assembly] = [
        MainItemAssembly(),
        FavoriteItemAssembly(),
        QuizItemAssembly(),
        FeedbackItemAssembly(),
        ProfileAssembly(),
        TabBarAssembly()
    ]
}

// MARK: - Public methods

extension AssemblySetupManager {
    
    func setup() {
        assemblies.forEach{ assemble in
            assemble.assemble()
        }
    }
}
