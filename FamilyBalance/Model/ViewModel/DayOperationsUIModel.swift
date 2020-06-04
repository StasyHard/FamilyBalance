
import Foundation


final class DayOperationsUIModel {
    
    let date: Date
    let sum: Double
    let operations: [OperationModel]
    
    internal init(date: Date, sum: Double, operations: [OperationModel]) {
        self.date = date
        self.sum = sum
        self.operations = operations
    }
}
