//
//  CoreDataClient.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 13.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation

class CoreDataClient {
    
    var operationsData = [Operation]()
    
    init() {
        operationsData = [
            Operation(id: 1, sum: 100, date: convertToDate(string: "01.06.2020"), comment: "", account: cash, category: categProduct),
            Operation(id: 2, sum: 500, date: convertToDate(string: "02.06.2020"), comment: "", account: card, category: categCar),
            Operation(id: 3, sum: 500, date: convertToDate(string: "20.05.2020"), comment: "", account: card, category: categRazvlechen),
            Operation(id: 4, sum: 500, date: convertToDate(string: "20.05.2020"), comment: "", account: card, category: nil),
            Operation(id: 5, sum: 100, date: convertToDate(string: "20.05.2020"), comment: "", account: cash, category: categRazvlechen),
            Operation(id: 6, sum: 500, date: convertToDate(string: "29.05.2020"), comment: "", account: card, category: categChocolad),
            Operation(id: 7, sum: 500, date: convertToDate(string: "29.04.2020"), comment: "", account: card, category: categTelephone),
            Operation(id: 8, sum: 700, date: convertToDate(string: "29.04.2020"), comment: "", account: card, category: categKvartira),
            Operation(id: 9, sum: 200, date: convertToDate(string: "28.04.2020"), comment: "", account: card, category: categZdorovie),
            Operation(id: 10, sum: 500, date: convertToDate(string: "27.04.2020"), comment: "", account: card, category: nil),
            Operation(id: 11, sum: 100, date: convertToDate(string: "27.04.2020"), comment: "", account: card, category: categTransp)
        ]
    }
    
    private func convertToDate(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ru_RU")
        let date = formatter.date(from: string)
        return date!
    }

    
    func getOperations(byPeriod period: Period) -> [Operation] {
        var operations: [Operation] = []
        operations = operationsData.filter{ operation in
            operation.date >= period.startDate && operation.date <= period.endDate
        }
        return operations
    }
    
    func addOperation(_ operation: Operation) -> Bool {
        //будет возвращаться ошибка или успех
        operationsData.append(operation)
        return true
    }
}
