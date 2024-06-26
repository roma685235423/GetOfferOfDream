import UIKit

public extension UIButton {

    static func withStandardConfiguration(title text: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = Constants.cornerRadius

        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.captionRegular

        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.backgroundColor = UIColor.lightGray.cgColor

        button.addTarget(self, action: #selector(changeBackgroundForTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(changeBackgroundForTouchUp(_:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(changeBackgroundForTouchUp(_:)), for: .touchUpOutside)
        return button
    }

    @objc private static func changeBackgroundForTouchDown(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        sender.setTitleColor(UIColor.black.withAlphaComponent(0.6), for: .normal)
    }

    @objc private static func changeBackgroundForTouchUp(_ sender: UIButton) {
        sender.backgroundColor = UIColor.lightGray
        sender.setTitleColor(UIColor.black, for: .normal)
    }
}
