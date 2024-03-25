import UIKit

public extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
}
