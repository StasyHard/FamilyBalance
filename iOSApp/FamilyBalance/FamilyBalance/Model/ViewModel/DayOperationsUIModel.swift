
import Foundation


final class DayOperationsUIModel {
    
    let date: Date
    let sum: Double
    let operations: [Operation]
    
    internal init(date: Date, sum: Double, operations: [Operation]) {
        self.date = date
        self.sum = sum
        self.operations = operations
    }
}
