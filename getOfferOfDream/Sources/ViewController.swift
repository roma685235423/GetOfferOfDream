import UIKit
import GetOfferCore
import GetOfferDI
import GetOfferNetwork
import GetOfferUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        GetOfferCore.test()
        GetOfferDI.test()
        GetOfferNetwork.test()
        GetOfferUI.test()
    }
}

