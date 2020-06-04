
import Foundation


final class SumCalculator {
    
    func getSum(by operations: [OperationModel]) -> Double {
         var sum = 0.0
         if !operations.isEmpty {
             operations.forEach { sum += $0.sum}
         }
         return sum
     }
}
