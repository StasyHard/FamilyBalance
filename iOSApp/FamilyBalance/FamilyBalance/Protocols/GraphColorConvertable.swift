
import UIKit

protocol GraphColorConvertable: class { }

extension GraphColorConvertable {
    func getUIcolorFromGraphColor(_ graphColor: GraphColors) -> UIColor {
        switch graphColor {
        case .systemBlue:
            return UIColor.systemBlue
        case .systemRed:
            return UIColor.systemRed
        case .systemGreen:
            return UIColor.systemGreen
        case .systemOrange:
            return UIColor.systemOrange
        case .systemGray:
            return UIColor.systemGray
        case .systemPurple:
            return UIColor.purple
        case .systemIndigo:
            return UIColor.systemIndigo
        }
    }
}
