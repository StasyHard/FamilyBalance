
import Foundation

class OperationModel {
    
    let sum: Double
    let date: Date
    let account: Account
    var category: Category?
    
    internal init(sum: Double, date: Date, account: Account, category: Category?) {
        self.sum = sum
        self.date = date
        self.account = account
        self.category = category
    }
}
