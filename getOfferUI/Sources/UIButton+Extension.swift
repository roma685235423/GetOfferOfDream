import UIKit
import GetOfferCore

public extension UIButton {

    static func withStandardConfiguration(title text: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = Constansts.cornerRadius

        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.captionRegular

        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.backgroundColor = UIColor.blueDynamic.cgColor
        return button
    }
}
