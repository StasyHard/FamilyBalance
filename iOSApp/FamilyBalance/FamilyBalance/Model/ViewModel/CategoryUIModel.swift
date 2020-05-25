
import Foundation
import UIKit

class CategoryUIModel: GraphColorConvertable {
    
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
}
