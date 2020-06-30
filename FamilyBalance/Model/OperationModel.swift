
import Foundation

class OperationModel {
    
    let sum: Double
    let date: Date
    let account: AccountModel
    var category: Category?
    
    internal init(sum: Double, date: Date, account: AccountModel, category: Category?) {
        self.sum = sum
        self.date = date
        self.account = account
        self.category = category
    }
}
