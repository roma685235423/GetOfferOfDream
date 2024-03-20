import Foundation
import GetOfferDI

// MARK: - AssemblySetupManager
final class AssemblySetupManager {

    // MARK: Public Properties
    static let shared = AssemblySetupManager()

    // MARK: Private Properties
    private let assemblies: [Assembly] = [
        MainItemAssembly(),
        FavoriteItemAssembly(),
        QuizItemAssembly(),
        FeedbackItemAssembly(),
        ProfileAssembly(),
        TabBarAssembly()
    ]

}

// MARK: - Public Methods
extension AssemblySetupManager {

    func setup() {
        assemblies.forEach { assemble in
            assemble.assemble()
        }
    }

}
