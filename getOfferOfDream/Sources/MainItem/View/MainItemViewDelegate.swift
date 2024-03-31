import UIKit

protocol MainItemViewDelegate: AnyObject {
    func viewDidLoad()
    func playPaceSound()
    func playTimeSound()
    func playDistanceSound()
    func changePaceCategoryAvailability(to state: Bool)
    func changeTimeCategoryAvailability(to state: Bool)
    func changeDistanceCategoryAvailability(to state: Bool)
    func changeAllCategoryAvailability(to state: Bool)
}
