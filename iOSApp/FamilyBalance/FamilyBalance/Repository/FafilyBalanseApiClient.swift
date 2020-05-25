
import Foundation


class FafilyBalanseApiClient {
    
    func signIn(user: UserLoginModel, complition: @escaping (String?) -> Void) {
        let token: String? = "Token"
        
        complition(token)
    }
    
    func getOperations(period: Filters) -> [Operation] {
        let operations: [Operation]
        switch period {
        case .mounth:
            operations = [
                Operation(id: 1, sum: 100, date: "1.05.2020", comment: "", account: cash, category: categProduct),
                Operation(id: 2, sum: 500, date: "31.04.2020", comment: "", account: card, category: categCar),
                Operation(id: 3, sum: 800, date: "31.04.2020", comment: "", account: card, category: categRazvlechen),
                Operation(id: 4, sum: 1000, date: "30.04.2020", comment: "", account: card, category: nil)
            ]
        case .today:
            operations = []
        case .week:
            operations = [
                Operation(id: 1, sum: 100, date: "1.05.2020", comment: "", account: cash, category: categProduct),
                Operation(id: 5, sum: 500, date: "31.04.2020", comment: "", account: card, category: categCar),
                Operation(id: 6, sum: 800, date: "30.04.2020", comment: "", account: card, category: nil)
            ]
        case .year:
            operations = [
                Operation(id: 1, sum: 100, date: "1.05.2020", comment: "", account: cash, category: categProduct),
                Operation(id: 2, sum: 500, date: "31.04.2020", comment: "", account: card, category: categCar),
                Operation(id: 3, sum: 500, date: "31.04.2020", comment: "", account: card, category: categRazvlechen),
                Operation(id: 4, sum: 500, date: "30.04.2020", comment: "", account: card, category: nil),
                Operation(id: 5, sum: 100, date: "30.04.2020", comment: "", account: cash, category: categRazvlechen),
                Operation(id: 6, sum: 500, date: "29.04.2020", comment: "", account: card, category: categCar),
                Operation(id: 7, sum: 500, date: "29.04.2020", comment: "", account: card, category: categTransp),
                Operation(id: 8, sum: 500, date: "29.04.2020", comment: "", account: card, category: nil)
            ]
        }
        return operations
    }
}
