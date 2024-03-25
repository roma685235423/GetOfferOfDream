import UIKit

public extension UIColor {

    // MARK: - Static colors
    static let darkBlue = UIColor(hex: 0x005EFF)
    static let lightBlue = UIColor(hex: 0x0077FF)

    static let darkMagenta = UIColor(hex: 0xFF0C69)
    static let lightMagenta = UIColor(hex: 0xFF3985)

    static let darkPurple = UIColor(hex: 0x6F16AA)
    static let lightPurple = UIColor(hex: 0x8024C0)

    static let darkMint = UIColor(hex: 0x00D3E6)
    static let lightMint = UIColor(hex: 0x7CEDF8)

    static let lightTextSubhead = UIColor(hex: 0x6D7885)
    static let lightTextPlaceholder = UIColor(hex: 0x818C99)
    static let lightTextDisabled = UIColor(red: 153, green: 153, blue: 153, alpha: 1)

    static let lightIcon = UIColor(hex: 0x818C99)
    static let lightIconDisabled = UIColor(red: 227, green: 230, blue: 234, alpha: 1)

    static let lightFieldBorder = UIColor(hex: 0x000000, alpha: 0.12)
    static let lightFieldBorderDisabled = UIColor(red: 238, green: 239, blue: 239, alpha: 1)

    static let lightFieldBackground = UIColor(hex: 0xF2F3F5)
    static let lightFieldBackgroundDisabled  = UIColor(red: 250, green: 250, blue: 251, alpha: 1)

    static let lightFieldErrorBorder = UIColor(hex: 0xE64646)
    static let lightFieldErrorBackground = UIColor(hex: 0xFAEBEB)

    static let lightAccentsDestructive = UIColor(hex: 0xE64646)
    static let lightAccentsAccent = UIColor(hex: 0x2688EB)

    static let lightButtonPrimaryBackground = UIColor(hex: 0x2D81E0)
    static let lightButtonBackground = UIColor(hex: 0x001C3D0D, alpha: 0.05)

    // MARK: - Dynamic colors
    static var blackDynamic: UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }
    }

    static var blueDynamic: UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? .darkBlue : .lightBlue
        }
    }

    static var magentaDynamic: UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? .darkMagenta : .lightMagenta
        }
    }

    static var purpleDynamic: UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? .darkPurple : .lightPurple
        }
    }

    static var mintDynamic: UIColor {
        UIColor { traits -> UIColor in
            return traits.userInterfaceStyle == .dark ? .darkMint : .lightMint
        }
    }

    // MARK: - Initializers
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
