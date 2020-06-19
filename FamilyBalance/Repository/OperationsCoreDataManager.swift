
import UIKit
import CoreData


class OperationsCoreDataManager {
    
    private var container: NSPersistentContainer? = {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }()
    
    private var operationsFRC: NSFetchedResultsController<Operation>?
    
    
    //MARK: - Open metods
    func getOperationsData(startDate: Date, endDate: Date) -> NSFetchedResultsController<Operation>? {
        if operationsFRC == nil {
            let sortDesc = NSSortDescriptor(key: "date", ascending: false)
            let predicate = NSPredicate(format: "date >= %@ AND date =< %@",
                                        startDate as NSDate,
                                        endDate as NSDate)
            
            let controller = createFRC(entityName: Operation.className,
                                       sortDesc: [sortDesc],
                                       predicate: predicate)
            operationsFRC = controller as? NSFetchedResultsController<Operation>
            return operationsFRC
        }
        return operationsFRC
    }
    
    
    private func createFRC(entityName: String, sortDesc: [NSSortDescriptor], predicate: NSPredicate)
        -> NSFetchedResultsController<NSFetchRequestResult> {
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Operation.className)
            request.predicate = predicate
            request.sortDescriptors = sortDesc
            let controller = NSFetchedResultsController(fetchRequest: request,
                                                        managedObjectContext: container!.viewContext,
                                                        sectionNameKeyPath: nil,
                                                        cacheName: nil)
            
            do {
                try controller.performFetch()
            } catch {
                print("Fetch failed")
            }
            return controller
    }
    
    
    func getCategories() -> [Category] {
        return getData(entityName: Category.className)
    }
    
    func getAccounts() -> [Account] {
        return getData(entityName: Account.className)
    }
    
    //добавить ообработку ошибок
    func save(operation: OperationModel) {
        container?.performBackgroundTask { [weak self] context in
            guard let `self` = self else { return }
            
            let newOperation = Operation(context: context)
            newOperation.sum = operation.sum
            newOperation.date = operation.date
            if let updateAccount = self.getAccount(byTitle: operation.account.title) {
                updateAccount.addToOperations(newOperation)
            }
            if let category = operation.category,
                let updateCategory = self.getCategory(byTitle: category.title) {
                updateCategory.addToOperations(newOperation)
            }
            context.saveThrows()
        }
    }
    
    
    //MARK: - Private metods
    private func getData<T>(entityName: String,
                            predicate: NSPredicate? = nil,
                            sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        
        do {
            if let response = try container?.viewContext.fetch(request) as? [T] {
                return response
            }
            else { return [T]() }
        } catch {
            return [T]()
        }
    }
    
    func getAccount(byTitle title: String) -> Account? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Account.className)
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            if let result = try container?.viewContext.fetch(request) as? [Account] {
                return result.first
            }
            else { return nil }
        } catch {
            return nil
        }
    }
    
    func getCategory(byTitle title: String) -> Category? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Category.className)
        request.predicate = NSPredicate(format: "title = %@", title)
        do {
            if let result = try container?.viewContext.fetch(request) as? [Category] {
                return result[0]
            }
            else { return nil }
        } catch {
            return nil
        }
    }
    
    
    //----------------------------------------------------------------------------------------
    
    func getOperationsResponse(startDate: Date, endDate: Date) -> [Operation] {
        let sortDesc = [NSSortDescriptor(key: "date", ascending: false)]
        let predicate = NSPredicate(format: "date >= %@ AND date =< %@",
                                    startDate as NSDate,
                                    endDate as NSDate)
        return getData(entityName: Operation.className, predicate: predicate, sortDescriptors: sortDesc)
    }
    
    
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
    
    
//    func getOperations(byPeriod period: PeriodModel) -> [OperationModel] {
//        var operations: [OperationModel] = []
//        operations = operationsData.filter{ operation in
//            operation.date >= period.startDate && operation.date <= period.endDate
//        }
//        return operations
//    }
    
    func addOperation(_ operation: OperationModel) -> Bool {
        //будет возвращаться ошибка или успех
        operationsData.append(operation)
        return true
    }
}



//Удалить все из бд
//let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Operation.className)
//let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//
//do {
//    try container?.viewContext.execute(deleteRequest)
//    try container?.viewContext.save()
//}
//catch {
//    print ("There was an error")
//}


//Добавить операции
//            let operation1 = Operation(context: container!.viewContext)
//            operation1.sum = 100
//            operation1.date = Date()
//            let operation2 = Operation(context: container!.viewContext)
//            operation2.sum = 200
//            operation2.date = Date()
//            let operation3 = Operation(context: container!.viewContext)
//            operation3.sum = 300
//            operation3.date = Date()
//            let operation4 = Operation(context: container!.viewContext)
//            operation4.sum = 400
//            operation4.date = Date()
//
//            let account = Account(context: container!.viewContext)
//            account.title = "Cash"
//            account.operations = [operation1, operation2, operation3, operation4]
//            let categ1 = Category(context: container!.viewContext)
//            categ1.title = "Car"
//            categ1.addToOperations(operation1)
//            categ1.addToOperations(operation2)
//            let categ2 = Category(context: container!.viewContext)
//            categ2.title = "Food"
//            categ2.addToOperations(operation3)
//
//            container!.viewContext.saveThrows()
