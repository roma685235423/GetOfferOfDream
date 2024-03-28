import Foundation

protocol MainItemViewInput: AnyObject {
    func updateAllSwitch(with state: Bool)
    func updatePaceSwitch(with state: Bool)
    func updateTimeSwitch(with state: Bool)
    func updateDistanceSwitch(with state: Bool)
}
