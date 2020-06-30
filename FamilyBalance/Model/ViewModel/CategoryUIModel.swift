
import Foundation
import UIKit

final class CategoryUIModel: GraphColorConvertable {
    
    //MARK: - Open properties
    let name: String
    let sum: Double
    var color: GraphColors
    
    //MARK: - Init
    init(name: String, color: GraphColors = .systemGray, sum: Double) {
        self.name = name
        self.color = color
        self.sum = sum
    }
}
