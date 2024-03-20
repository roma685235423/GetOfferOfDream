import UIKit
import GetOfferDI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public Properties
    var window: UIWindow?

    // MARK: - Public Methods
    func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        AssemblySetupManager.shared.setup()
        return true
    }

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        @Dependency var tabBar: TabBarViewController
        window?.rootViewController = tabBar
        window?.makeKeyAndVisible()
        return true
    }
}
