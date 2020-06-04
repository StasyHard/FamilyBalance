//
//  CoreDataClient.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 13.05.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//

import Foundation

class CoreDataClient {
    
    var operationsData = [OperationModel]()
    
    init() {
        operationsData = [
            OperationModel(id: 1, sum: 100, date: convertToDate(string: "01.06.2020"), comment: "", account: cash, category: categProduct),
            OperationModel(id: 2, sum: 500, date: convertToDate(string: "02.06.2020"), comment: "", account: card, category: categCar),
            OperationModel(id: 3, sum: 500, date: convertToDate(string: "20.05.2020"), comment: "", account: card, category: categRazvlechen),
            OperationModel(id: 4, sum: 500, date: convertToDate(string: "20.05.2020"), comment: "", account: card, category: nil),
            OperationModel(id: 5, sum: 100, date: convertToDate(string: "20.05.2020"), comment: "", account: cash, category: categRazvlechen),
            OperationModel(id: 6, sum: 500, date: convertToDate(string: "29.05.2020"), comment: "", account: card, category: categChocolad),
            OperationModel(id: 7, sum: 500, date: convertToDate(string: "29.04.2020"), comment: "", account: card, category: categTelephone),
            OperationModel(id: 8, sum: 700, date: convertToDate(string: "29.04.2020"), comment: "", account: card, category: categKvartira),
            OperationModel(id: 9, sum: 200, date: convertToDate(string: "28.04.2020"), comment: "", account: card, category: categZdorovie),
            OperationModel(id: 10, sum: 500, date: convertToDate(string: "27.04.2020"), comment: "", account: card, category: nil),
            OperationModel(id: 11, sum: 100, date: convertToDate(string: "27.04.2020"), comment: "", account: card, category: categTransp)
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

    
    func getOperations(byPeriod period: PeriodModel) -> [OperationModel] {
        var operations: [OperationModel] = []
        operations = operationsData.filter{ operation in
            operation.date >= period.startDate && operation.date <= period.endDate
        }
        return operations
    }
    
    func addOperation(_ operation: OperationModel) -> Bool {
        //будет возвращаться ошибка или успех
        operationsData.append(operation)
        return true
    }
}
