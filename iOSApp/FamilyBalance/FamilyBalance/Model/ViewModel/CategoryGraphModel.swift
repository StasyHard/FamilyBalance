
import Foundation


final class CategoryGraphModel: GraphColorConvertable {
    
    //MARK: - Open properties
    let color: GraphColors
    let sum: Double
    
    
    //MARK: - Init
    internal init(color: GraphColors, sum: Double) {
        self.color = color
        self.sum = sum
    }
}
