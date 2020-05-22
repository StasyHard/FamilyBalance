
import Foundation
import UIKit

class CategoryUIModel {
    
    //MARK: - Open properties
    let id: Int
    let name: String
    let sum: Double
    var color: GraphColors
    
    //MARK: - Init
    init(id: Int, name: String, color: GraphColors = .systemGray, sum: Double) {
        self.id = id
        self.name = name
        self.color = color
        self.sum = sum
    }
    
    //MARK: - Open properties
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
        case .systemYellow:
            return UIColor.systemBlue
        case .systemGray:
            return UIColor.systemGray
        }
    }
}
