
import Foundation


final class SumCalculator {
        
   static func getSum(by operations: [Operation]) -> Double {
        return operations
            .map { $0.sum }
            .reduce(0, +)
     }
    
    static func getSum(by categories: [CategoryUIModel]) -> Double {
       return categories
        .map { $0.sum }
        .reduce(0, +)
        
    }
}
