import UIKit
import GetOfferCore
import GetOfferDI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        GetOfferCore.test()
        GetOfferDI.test()
    }
}

